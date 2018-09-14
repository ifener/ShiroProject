package com.wey.shrio.util;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

import com.wey.pojo.User;

public class PasswordUtil {
    
    /**
     * 加密盐
     */
    public final static String CREDENTIALS = "salt";
    
    private RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();
    private static String algorithmName = "md5";
    private static final int hashIterations = 2;
    
    public static void encryptPassword(User user) {
        // User对象包含最基本的字段Username和Password
        // user.setSalt(randomNumberGenerator.nextBytes().toHex());
        // 将用户的注册密码经过散列算法替换成一个不可逆的新密码保存进数据，散列过程使用了盐
        // user.getCredentialsSalt()
        String newPassword = new SimpleHash(algorithmName, user.getPassword(), ByteSource.Util.bytes(CREDENTIALS),
                                            hashIterations).toHex();
        System.out.println(newPassword);
        user.setPassword(newPassword);
    }
}
