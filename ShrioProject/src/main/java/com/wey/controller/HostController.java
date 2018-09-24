package com.wey.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/host")
public class HostController {
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
}
