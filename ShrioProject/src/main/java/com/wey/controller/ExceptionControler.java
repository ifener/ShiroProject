package com.wey.controller;

import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.wey.shrio.util.ExceptionUtil;

@ControllerAdvice
public class ExceptionControler {
    
    /**
     * 此类要用@ControllerAdvice修饰一下
     * @param e
     * @return
     */
    @ExceptionHandler({ UnauthorizedException.class })
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ModelAndView processUnauthenticatedException(final Throwable e) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("exception", ExceptionUtil.getExceptionStack(e));
        mv.setViewName("denied");
        return mv;
    }
}
