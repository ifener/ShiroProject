package com.wey.shrio.realm;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.wey.pojo.Role;
import com.wey.pojo.User;
import com.wey.service.UserService;

public class UserRealm extends AuthorizingRealm {
    
    private static final Logger logger = LoggerFactory.getLogger(UserRealm.class);
    
    @Autowired
    private UserService userService;
    
    /**
     * 提供用户信息返回权限信息
     * 参考：http://www.sojson.com/shiro
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        logger.info("###############doGetAuthorizationInfo被调用###############");
        String username = (String) principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        // 根据用户名查询当前用户拥有的角色
        User user = userService.findByUsername(username);
        List<Role> roles = user.getRoles();
        Set<String> roleNames = new HashSet<String>();
        for (Role role : roles) {
            roleNames.add(role.getRoleCode());
        }
        // 将角色名称提供给info
        authorizationInfo.setRoles(roleNames);
        // 根据用户名查询当前用户权限
        /*Set<Permission> permissions = userService.findPermissions(username);
        Set<String> permissionNames = new HashSet<String>();
        for (Permission permission : permissions) {
            permissionNames.add(permission.getPermission());
        }
        // 将权限名称提供给info
        authorizationInfo.setStringPermissions(permissionNames);*/
        
        Set<String> permissionNames = new HashSet<String>();
        permissionNames.add("printer:print");
        permissionNames.add("printer:query");
        permissionNames.add("printer:delete");
        
        authorizationInfo.setStringPermissions(permissionNames);
        
        return authorizationInfo;
    }
    
    /**
     * 提供账户信息返回认证信息
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token;
        String username = usernamePasswordToken.getUsername();
        // String username = (String) token.getPrincipal();
        //String password = new String((char[])token.getCredentials()); //得到密码  
        User user = userService.findByUsername(username);
        if (user == null) {
            // 用户名不存在抛出异常
            throw new UnknownAccountException();
        }
        if (user.getLocked() == 0) {
            // 用户被管理员锁定抛出异常
            throw new LockedAccountException();
        }
        
        // if (!"123".equals(user.getPassword())) {
        // throw new IncorrectCredentialsException();
        // }
        
      //如果身份认证验证成功，返回一个AuthenticationInfo实现；  
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user.getUsername(), user
                .getPassword(), ByteSource.Util.bytes(user.getCredentialsSalt()), getName());
        return authenticationInfo;
    }
    
}
