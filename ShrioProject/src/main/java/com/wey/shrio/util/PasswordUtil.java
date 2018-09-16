package com.wey.shrio.util;

import org.apache.shiro.codec.Base64;
import org.apache.shiro.codec.Hex;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

import com.wey.pojo.User;

public class PasswordUtil {
    
    /**
     * 加密盐
     */
    public final static String CREDENTIALS = "salt";
    
    private static final RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();
    private static String algorithmName = "md5";
    // 密码进行几次散列（用md5算法做几次运算）
    private static final int hashIterations = 2;
    
    public static void encryptPassword(User user) {
        // User对象包含最基本的字段Username和Password
    	//盐
        user.setSalt(randomNumberGenerator.nextBytes().toHex());
        // 将用户的注册密码经过散列算法替换成一个不可逆的新密码保存进数据，散列过程使用了盐
        String newPassword = new SimpleHash(algorithmName, user.getPassword(), ByteSource.Util.bytes(user.getCredentialsSalt()),
                                            hashIterations).toHex();
        
        System.out.println(newPassword);
        user.setPassword(newPassword);
    }
    

    public static String base64String(String str) {
    	String base64Encoded = Base64.encodeToString(str.getBytes());  
    	System.out.println();
    	String base64Decoded = Base64.decodeToString(base64Encoded);  
    	System.out.println(base64Decoded);
    	return base64Encoded;
    }
    
    public static String hexString(String str) {
    	String hexEncoded = Hex.encodeToString(str.getBytes());  
    	String hexDecoded = new String(Hex.decode(hexEncoded.getBytes()));  
    	System.out.println(hexDecoded);
    	return hexEncoded;
    }
    
    public static String md5Salt(String str,String salt) {
    	return new Md5Hash(str,salt).toString();
    }
    
    public static String md5Salt(String str,String salt,int hashIteration) {
    	return new Md5Hash(str,salt,hashIteration).toString();
    }
    
    public static String sha256Hash(String str,String salt) {
    	return new Sha256Hash(str, salt).toString();   
    }
    
    public static void main(String[] args) {
        System.out.println("Base64转换后："+base64String("ken"));	
        System.out.println("16进制转换后："+hexString("ken"));	
        System.out.println(md5Salt("Ken","Ngai"));
        System.out.println(md5Salt("Ken","Ngai",5));
        System.out.println("Sha256Hash后："+sha256Hash("ken","Ngai"));	
    }
}
