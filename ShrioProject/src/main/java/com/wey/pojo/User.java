package com.wey.pojo;

import java.io.Serializable;
import java.util.List;

public class User implements Serializable {
    
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    
    private Long id;
    
    private String username;
    
    private String password;
    
    private Long locked;
    
    private List<Role> roles;
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public Long getLocked() {
        return locked;
    }
    
    public void setLocked(Long locked) {
        this.locked = locked;
    }
    
    public List<Role> getRoles() {
        return roles;
    }
    
    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
    
}
