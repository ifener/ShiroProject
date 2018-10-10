package com.wey.framework.cas.mapper;

import com.wey.framework.cas.pojo.User;

public interface UserMapper {
    
    public User findByUserName(String username);
    
    public Long save(User user);
}
