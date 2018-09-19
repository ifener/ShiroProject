package com.wey.mapper;

import com.wey.pojo.User;

public interface UserMapper {
    
    public User findByUsername(String username);
    
    public User findById(Long id);
    
    /**
     * 添加后返回主键 
     * @param user
     * @return
     */
    public Long save(User user);
    
    /**
     * 修改密码
     * @param password
     * @param username
     * @return
     */
    public Long updatePassword(User user);
}
