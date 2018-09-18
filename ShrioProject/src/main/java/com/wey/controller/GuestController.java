package com.wey.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("guest")
public class GuestController {
    
    @RequestMapping("index")
    public String index() {
        return "/guest/index";
    }
}
