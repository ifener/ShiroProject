package com.wey.framework.cas.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogoutController {
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:https://cas.ifener.com:8443/CAS52/logout?service=https://cas.ifener.com:8443/CAS52/login";
    }
}
