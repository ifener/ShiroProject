package com.wey.framework.cas.filter;

import org.jasig.cas.client.authentication.UrlPatternMatcherStrategy;

/**
 * 不需要拦截的页面的策略
 * @author weisunqing
 *
 */
public class NoInterceptUrlPatternMatcherStrategy implements UrlPatternMatcherStrategy {
    
    public String[] urls = null;
    
    public boolean matches(String url) {
        
        if (urls != null && urls.length > 0) {
            for (int i = 0, j = urls.length; i < j; i++) {
                String subUrl = urls[i];
                if (url.contains(subUrl)) {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    public void setPattern(String patterns) {
        urls = patterns.split("\n");
    }
    
}
