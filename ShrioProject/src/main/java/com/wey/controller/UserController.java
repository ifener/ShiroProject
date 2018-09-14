package com.wey.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wey.pojo.User;
import com.wey.service.UserService;

@RestController
@RequestMapping("/users")
public class UserController {
    
    private static Logger logger = LoggerFactory.getLogger(UserController.class);
    
    @Autowired
    UserService userService;
    
    @GetMapping("/{username}")
    public User findByUsername(@PathVariable(name = "username") String username) {
        return userService.findByUsername(username);
    }
    
    @PostMapping
    public User save(User user) {
        Long id = userService.save(user);
        logger.info("effect rows is " + id);
        logger.info("The key column value is " + user.getId());
        return userService.findById(user.getId());
    }
}
