package com.wey.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.wey.pojo.User;
import com.wey.service.UserService;
import com.wey.shrio.util.PasswordUtil;

@Controller
public class LoginController {
    
    // https://blog.csdn.net/qq_39874546/article/details/79081950
    @Autowired
    private UserService userService;
    
    @GetMapping("/login")
    public String login() {
        return "/login";
    }
    
    @PostMapping("/login")
    public ModelAndView doLogin(@RequestParam("username") String username, @RequestParam("password") String password) {
        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, password);
        usernamePasswordToken.setRememberMe(true);
        Subject subject = SecurityUtils.getSubject();
        
        try {
            User user = new User();
            user.setPassword(password);
            PasswordUtil.encryptPassword(user);
            subject.login(usernamePasswordToken);
            
            // 是否已经验证
            boolean authenticated = subject.isAuthenticated();
            System.out.println("是否已经验证=" + authenticated);
            boolean hasRole = subject.hasRole("ADMIN");
            System.out.println("是否有ADMIN的角色=" + hasRole);
            boolean permitted = subject.isPermitted("printer:print");
            System.out.println("是否有打印的权限=" + permitted);
        }
        catch (IncorrectCredentialsException ice) {
            // 捕获密码错误异常
            ModelAndView mv = new ModelAndView("/login");
            mv.addObject("message", "password error!");
            return mv;
        }
        catch (UnknownAccountException uae) {
            // 捕获未知用户名异常
            ModelAndView mv = new ModelAndView("/login");
            mv.addObject("message", "username error!");
            return mv;
        }
        catch (ExcessiveAttemptsException eae) {
            // 捕获错误登录过多的异常
            ModelAndView mv = new ModelAndView("/login");
            mv.addObject("message", "times error");
            return mv;
        }
        
        User user = userService.findByUsername(username);
        subject.getSession().setAttribute("user", user);
        return new ModelAndView("redirect:/home/index");
    }
    
    @GetMapping("/denied")
    public String denied() {
        return "/denied";
    }
    
    @RequestMapping("/logout")
    public String logout() {
        SecurityUtils.getSubject().logout();
        return "/login";
    }
    
    @RequestMapping("/print")
    @RequiresPermissions({ "printer:print" })
    public String print() {
        return null;
    }
}
