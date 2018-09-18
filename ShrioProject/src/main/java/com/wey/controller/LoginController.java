package com.wey.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.session.mgt.ServletContainerSessionManager;
import org.apache.shiro.web.util.SavedRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.wey.constants.Constants;
import com.wey.framework.util.StringUtil;
import com.wey.pojo.User;
import com.wey.service.UserService;
import com.wey.shrio.util.PasswordUtil;

@Controller
public class LoginController {
    
    // https://blog.csdn.net/qq_39874546/article/details/79081950
    // http://jinnianshilongnian.iteye.com/blog/2018398
    @Autowired
    private UserService userService;
    
    @Autowired
    private HttpServletRequest request;
    
    @GetMapping("/login")
    public String login() {
        // org.apache.shiro.web.filter.mgt.DefaultFilter
        // org.apache.shiro.web.filter.authc.FormAuthenticationFilter
        // org.apache.shiro.web.filter.authc.AuthenticationFilter
    	//DefaultWebSecurityManager//使用的默认实现，用于Web环境，其直接使用Servlet容器的会话；
    	//ServletContainerSessionManager 
        return "/login";
    }
    
    @PostMapping("/login")
    public ModelAndView doLogin(@RequestParam("username") String username, @RequestParam("password") String password,
            @RequestParam(name = "rememberMe", required = false) String rememberMe) {
        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, password);
        if (Constants.BOOLEAN_Y.equals(rememberMe)) {
            usernamePasswordToken.setRememberMe(true);
        }
        
        // Subject是Shiro的核心对象，基本所有身份验证、授权都是通过Subject完成。
        Subject subject = SecurityUtils.getSubject();
        
        try {
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            PasswordUtil.encryptPassword(user);
            subject.login(usernamePasswordToken);
            
            // 是否已经验证
            boolean authenticated = subject.isAuthenticated();
            System.out.println("是否已经验证=" + authenticated);
            System.out.println("Is remember me is " + subject.isRemembered());
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
        
        /**
         * 我们可以直接调用subject.getPrincipal获取PrimaryPrincipal（即所谓的第一个）；
         * 或者通过getPrincipals获取PrincipalCollection；
         * 然后通过其getPrimaryPrincipal获取PrimaryPrincipal。
         */
        // subject.getPrincipals().getPrimaryPrincipal();
        // subject.getPrincipal();
        
        // 登录后判断是否有登录之前的页面，如果有则跳转回登录前的页面
        SavedRequest savedRequest = (SavedRequest) subject.getSession().getAttribute("shiroSavedRequest");
        if (savedRequest != null) {
            String returnUrl = savedRequest.getRequestUrl();
            
            if (!StringUtil.isRealEmpty(returnUrl)) {
                
                String contextPath = request.getContextPath();
                returnUrl = returnUrl.replace(contextPath, "");
                return new ModelAndView("redirect:" + returnUrl);
            }
        }
        
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
