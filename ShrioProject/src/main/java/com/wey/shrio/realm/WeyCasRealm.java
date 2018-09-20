package com.wey.shrio.realm;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cas.CasRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.wey.pojo.Role;
import com.wey.pojo.User;
import com.wey.service.UserService;

public class WeyCasRealm extends CasRealm {

	@Autowired
	private UserService userService;

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
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
        
        Set<String> permissionNames = new HashSet<String>();
        permissionNames.add("printer:print");
        permissionNames.add("printer:query");
        permissionNames.add("printer:delete");
        
        authorizationInfo.setStringPermissions(permissionNames);
        
		return authorizationInfo;
	}
}
