package com.wey.framework.handler;

import java.security.GeneralSecurityException;
import java.util.ArrayList;

import javax.security.auth.login.AccountNotFoundException;

import org.apereo.cas.authentication.HandlerResult;
import org.apereo.cas.authentication.PreventedException;
import org.apereo.cas.authentication.UsernamePasswordCredential;
import org.apereo.cas.authentication.handler.support.AbstractUsernamePasswordAuthenticationHandler;
import org.apereo.cas.authentication.principal.PrincipalFactory;
import org.apereo.cas.services.ServicesManager;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.wey.framework.cas.mapper.UserMapper;
import com.wey.framework.cas.pojo.User;
import com.wey.framework.util.PasswordSaltUtil;

public class LoginAuthenticationHandler extends AbstractUsernamePasswordAuthenticationHandler {
    
    private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(LoginAuthenticationHandler.class);
    
    @Autowired
    private UserMapper userMapper;
    
    public LoginAuthenticationHandler(String name, ServicesManager servicesManager, PrincipalFactory principalFactory,
            Integer order) {
        super(name, servicesManager, principalFactory, order);
    }
    
    @Override
    protected HandlerResult authenticateUsernamePasswordInternal(UsernamePasswordCredential transformedCredential,
            String originalPassword) throws GeneralSecurityException, PreventedException {
        
        String username = transformedCredential.getUsername();
        String password = transformedCredential.getPassword();
        
        try {
            User user = userMapper.findByUserName(username);
            if (user == null) {
                throw new AccountNotFoundException("用户名或者密码错误");
            }
            
            String encodePassword = PasswordSaltUtil.encode(password, user.getSalt());
            if (encodePassword.equals(user.getPassword())) {
                return createHandlerResult(transformedCredential, this.principalFactory.createPrincipal(username),
                                           new ArrayList<>(0));
            }
            throw new AccountNotFoundException("用户名或者密码错误");
            
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new AccountNotFoundException("用户名或者密码错误");
        }
        
    }
    
}
