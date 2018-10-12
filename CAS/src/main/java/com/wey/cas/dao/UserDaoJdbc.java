package com.wey.cas.dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

public class UserDaoJdbc {
    
    private static final String SQL_VERIFY_ACCOUNT = "SELECT COUNT(*) FROM sys_user  WHERE login_name=?  AND del_flag=0";
    private static final String SQL_VERIFY_PASSWORD = "SELECT password FROM sys_user  WHERE login_name=?  AND del_flag=0";
    private JdbcTemplate jdbcTemplate;
    public static final int HASH_INTERATIONS = 1024;
    
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
    // https://blog.csdn.net/yangkalaok/article/details/68944256
    
}
