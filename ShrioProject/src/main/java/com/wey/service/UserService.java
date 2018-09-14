package com.wey.service;

import com.wey.pojo.User;

public interface UserService {
    
    User findByUsername(String username);
    
    User findById(Long id);
    
    Long save(User user);
}
