package com.wey.framework.cas.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.wey.framework.cas.mapper.UserMapper;
import com.wey.framework.cas.pojo.User;
import com.wey.framework.util.PasswordSaltUtil;

@Controller
public class RegisterController {
    
    @Autowired
    private UserMapper userMapper;
    
    // 参考：https://blog.csdn.net/u010588262/article/category/7548325
    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("pagetitle", "用户注册");
        return "register";
    }
    
    @PostMapping("/doRegister")
    public String doRegister(User user) {
        user = PasswordSaltUtil.encode(user);
        Long id = userMapper.save(user);
        System.out.println(id);
        return "register";
    }
    
}
