package com.wey.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wey.mapper.UserMapper;
import com.wey.pojo.User;
import com.wey.service.UserService;

@Service
public class UserServiceImpl implements UserService {
    
    @Autowired
    UserMapper userMapper;
    
    @Override
    public User findByUsername(String username) {
        return userMapper.findByUsername(username);
    }
    
    @Override
    public User findById(Long id) {
        return userMapper.findById(id);
    }
    
    @Override
    @Transactional
    public Long save(User user) {
        return userMapper.save(user);
    }
    
    @Override
    public Long updatePassword(User user) {
        return userMapper.updatePassword(user);
    }
    
}
