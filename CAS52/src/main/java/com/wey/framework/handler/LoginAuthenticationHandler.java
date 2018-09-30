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

public class LoginAuthenticationHandler extends AbstractUsernamePasswordAuthenticationHandler {
    
    private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(LoginAuthenticationHandler.class);
    
    public LoginAuthenticationHandler(String name, ServicesManager servicesManager, PrincipalFactory principalFactory,
            Integer order) {
        super(name, servicesManager, principalFactory, order);
    }
    
    @Override
    protected HandlerResult authenticateUsernamePasswordInternal(UsernamePasswordCredential transformedCredential,
            String originalPassword) throws GeneralSecurityException, PreventedException {
        if ("admin".equals(transformedCredential.getUsername())) {
            return createHandlerResult(transformedCredential,
                                       this.principalFactory.createPrincipal(transformedCredential.getUsername()),
                                       new ArrayList<>(0));
        }
        else {
            throw new AccountNotFoundException("必须是admin用户才允许通过");
        }
    }
    
}
