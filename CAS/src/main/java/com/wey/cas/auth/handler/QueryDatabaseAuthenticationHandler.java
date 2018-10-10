package com.wey.cas.auth.handler;

import java.security.GeneralSecurityException;

import org.jasig.cas.authentication.PreventedException;
import org.jasig.cas.authentication.handler.support.AbstractUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.principal.Principal;

public class QueryDatabaseAuthenticationHandler extends AbstractUsernamePasswordAuthenticationHandler {
    
    // https://www.cnblogs.com/notDog/p/5275149.html
    @Override
    protected Principal authenticateUsernamePasswordInternal(String username, String password)
            throws GeneralSecurityException, PreventedException {
        
        return null;
    }
    
}
