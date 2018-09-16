package com.wey.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/home")
public class HomeController {
    
    //@RequiresAuthentication
    @GetMapping("/index")
    public ModelAndView index(ModelAndView mv) {
    	Subject subject = SecurityUtils.getSubject();
    	mv.setViewName("/home/index");
    	String username = subject.getPrincipal().toString();
        mv.addObject("username", username);
        
        boolean remembered = subject.isRemembered();
        mv.addObject("remember", remembered);
        boolean authenticated = subject.isAuthenticated();
        mv.addObject("authenticated", authenticated);
        return mv;
    }
}
