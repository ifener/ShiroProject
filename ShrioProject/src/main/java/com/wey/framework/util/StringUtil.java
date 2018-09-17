package com.wey.framework.util;

public class StringUtil {
    
    public static boolean isRealEmpty(String str) {
        if (isNull(str)) {
            return true;
        }
        
        return str.trim().isEmpty();
    }
    
    public static boolean isNull(String str) {
        return str == null;
    }
}
