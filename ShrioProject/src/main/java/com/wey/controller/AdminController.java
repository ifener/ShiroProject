package com.wey.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @GetMapping("/index")
    public String adminIndex(Model model) {
        Subject subject = SecurityUtils.getSubject();
        
        Session session = subject.getSession();
        
        boolean remembered = subject.isRemembered();
        model.addAttribute("remember", remembered);
        
        // org.apache.shiro.subject.support.DefaultSubjectContext_AUTHENTICATED_SESSION_KEY
        boolean authenticated = subject.isAuthenticated();
        model.addAttribute("authenticated", authenticated);
        
        return "/admin/index";
    }
}
