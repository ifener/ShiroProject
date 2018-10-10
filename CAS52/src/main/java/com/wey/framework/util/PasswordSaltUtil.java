package com.wey.framework.util;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.ConfigurableHashService;
import org.apache.shiro.crypto.hash.DefaultHashService;
import org.apache.shiro.crypto.hash.HashRequest;
import org.apache.shiro.util.ByteSource;

import com.wey.framework.cas.pojo.User;

/**
 * 加盐密码生成（迭代2次）
 * @author weisunqing
 *
 */
public class PasswordSaltUtil {
    
    private static final RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();
    private static final int ITERATIONS = 2;
    private static final String ALGORITHM = "MD5";
    private static final String STATIC_SALG = ".";
    
    public static String encode(String password, String salt) {
        ConfigurableHashService hashService = new DefaultHashService();
        
        hashService.setPrivateSalt(ByteSource.Util.bytes(STATIC_SALG));
        
        hashService.setHashAlgorithmName(ALGORITHM);
        hashService.setHashIterations(ITERATIONS);
        HashRequest request = new HashRequest.Builder().setSalt(salt).setSource(password).build();
        String res = hashService.computeHash(request).toHex();
        return res;
    }
    
    /**
     * 用户加密密码并返回盐
     * @param user
     * @return
     */
    public static User encode(User user) {
        String salt = randomNumberGenerator.nextBytes().toHex();
        user.setSalt(salt);
        String password = encode(user.getPassword(), user.getSalt());
        user.setPassword(password);
        return user;
    }
    
    public static void main(String[] args) {
        String encode = PasswordSaltUtil.encode("123456", "1111");
        System.out.println(encode);
    }
}
