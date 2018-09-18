<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Shiro 笔记</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link href="${ctx}/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
<link href="${ctx}/css/bootstrap/bootstrap-theme.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"
	src="${ctx}/js/bootstrap/bootstrap.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-9"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Brand</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-9">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#">Link</a></li>
					<li><a href="#">Link</a></li>
					<li>
						<a href="#">
							<c:if test="${username!=null}">
								欢迎：${username}
							</c:if>
						</a>
					</li>
				</ul>
				
				<div class="navbar-form navbar-right">
        			<a href="${ctx}/logout" class="btn btn-primary">登出</a>
          		</div>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>

	<div class="container">
		<h1>登录成功</h1>
		<p>Shiro:http://jinnianshilongnian.iteye.com/blog/2018398</p>
		<p>isAuthenticated/isRemembered是互斥的，即如果其中一个返回true，另一个返回false。</p>
		<p>remember:${remember}</p>
		<p>authenticated:${authenticated}</p>
		<div>
			<shiro:hasPermission name="printer:print">
				<p>有打印机打印的权限</p>
			</shiro:hasPermission>
			<shiro:hasPermission name="printer:query">
				<p>有打印机查询的权限</p>
			</shiro:hasPermission>
			<shiro:hasPermission name="printer:delete">
				<p>有打印机删除的权限</p>
			</shiro:hasPermission>
		</div>
		<h3>1. 基于角色的访问控制</h3>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>方法</th>
					<th>作用</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><code>hasRole(String roleName)</code></td>
					<td>判断是否有该角色访问权，返回boolen</td>
				</tr>
				<tr>
					<td><code>hasRoles(List&lt;String&gt; roleNames)</code></td>
					<td>判断是否有这些这些角色访问权，返回boolean[]</td>
				</tr>
				<tr>
					<td><code>hasAllRoles(Collection&lt;String&gt;
							roleNames)</code></td>
					<td>判断是否有这些这些角色访问权，返回boolean</td>
				</tr>
			</tbody>
		</table>
		<article>
			对这三个API，做一下简单的说明，第一个很简单，传入一个role即可，判断是否拥有该角色访问权，第二个方法是传入一个role的集合，然后Shiro会根据集合中的每一个role做一下判断，并且将每次的判断结果放到boolean[]数组中，顺序与集合中role的顺序一致；第三个方法也是传入一个role的集合，不同的是，返回boolean类型，必须集合中全部role都有才为true，否则为false。
		</article>
		<article>
			除了这三个API外，Shiro还提供了check的API，与上面不同的是，has-xxx会返回boolean类型的数据，用来判断，而check-xxx不会返回任何东西，如果验证成功就继续处理下面的代码，否则会抛出一个异常，可以用来通过捕获异常来处理。API如下：
		</article>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>方法</th>
					<th>作用</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><code>checkRole(String roleName)</code></td>
					<td>如果判断失败抛出AuthorizationException异常</td>
				</tr>
				<tr>
					<td><code>checkRoles(String... roleNames)</code></td>
					<td>如果判断失败抛出AuthorizationException异常</td>
				</tr>
				<tr>
					<td><code>checkRoles(Collection&lt;String&gt;
							roleNames)</code></td>
					<td>如果判断失败抛出AuthorizationException异常</td>
				</tr>
			</tbody>
		</table>
		<h3>2. 基于权限的访问控制</h3>
		<p>基于权限的访问控制和基于角色的访问控制在原理上是一模一样的，只不过API不同而已，我不再做过多的解释，API如下：</p>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>方法</th>
					<th>作用</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><code>isPermitted(String perm)</code></td>
					<td>判断是否有该权限，返回boolen</td>
				</tr>
				<tr>
					<td><code>isPermitted(List&lt;String&gt; perms)</code></td>
					<td>判断是否有这些这些权限，返回boolean[]</td>
				</tr>
				<tr>
					<td><code>isPermittedAll(Collection&lt;String&gt;
							perms)</code></td>
					<td>判断是否有这些这些权限，返回boolean</td>
				</tr>
				<tr>
					<td><code>checkPermission(String perm)</code></td>
					<td>如果判断失败抛出AuthorizationException异常</td>
				</tr>
				<tr>
					<td><code>checkPermissions(String... perms)</code></td>
					<td>如果判断失败抛出AuthorizationException异常</td>
				</tr>
				<tr>
					<td><code>checkPermissionsAll(Collection&lt;String&gt;
							perms)</code></td>
					<td>如果判断失败抛出AuthorizationException异常</td>
				</tr>
			</tbody>
		</table>
		<div class="card card-block">
			<h3 class="card-title">3.其权限过滤器及配置释义</h3>
			<div class="card-text">
				<h4 class="text-bold">anon:</h4>
				<p>例子/admins/**=anon 没有参数，表示可以匿名使用。</p>
				<h4 class="text-bold">roles(角色):</h4>
				<p>例子/admins/user/**=roles[admin],参数可以写多个，参数之间用逗号分割，当有多个参数时，例如admins/user/**=roles["admin,guest"],每个参数通过才算通过，相当于hasAllRoles()方法。</p>
				<h4 class="text-bold">authc:</h4>
				<p>例如/admins/user/**=authc表示需要认证(登录)才能使用，没有参数</p>
				<h4 class="text-bold">perms（权限）：</h4>
				<p>例子/admins/user/**=perms[add],参数可以写多个，例如/admins/user/**=perms["add, modify"]，当有多个参数时必须每个参数都通过才通过，想当于isPermitedAll()方法。</p>
				<h4 class="text-bold">rest:</h4>
				<p>例子/admins/user/**=rest[user],根据请求的方法，相当于/admins/user/**=perms[user:method] ,其中method为post，get，delete等。</p>
				<h4 class="text-bold">port:</h4>
				<p>例子/admins/user/**=port[8081],当请求的url的端口不是8081是跳转到schemal://serverName:8081?queryString,其中schmal是协议http或https等，serverName是你访问的host,8081是url配置里port的端口，queryString是你访问的url里的？后面的参数。</p>
				<h4 class="text-bold">authcBasic:</h4>
				<p>例如/admins/user/**=authcBasic没有参数.表示httpBasic认证</p>
				<h4 class="text-bold">ssl:</h4>
				<p>例子/admins/user/**=ssl没有参数，表示安全的url请求，协议为https</p>
				<h4 class="text-bold">user:</h4>
				<p>例如/admins/user/**=user没有参数表示必须存在用户，当登入操作时不做检查</p>
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">4.URL模式使用Ant风格模式</h3>
			<div class="card-text">
				<p>Ant路径通配符支持?、*、**，注意通配符匹配不包括目录分隔符“/”：</p>
				<p><b>?：匹配一个字符</b>，如”/admin?”将匹配/admin1，但不匹配/admin或/admin2</p>
				<p><b>*：匹配零个或多个字符串</b>，如/admin*将匹配/admin、/admin123，但不匹配/admin/1</p>
				<p><b>**：匹配路径中的零个或多个路径</b>，如/admin/**将匹配/admin/a或/admin/a/b。</p>
				<p><b>匹配顺序:</b></p>
				<p>url模式匹配顺序是按照在配置中的声明顺序匹配，即从头开始使用第一个匹配的url模式对应的拦截器链。如：</p>
				<pre>
/bb/**=filter1  
/bb/aa=filter2  
/**=filter3
				</pre>
				<p>如果请求的url是“/bb/aa”，因为按照声明顺序进行匹配，那么将使用filter1进行拦截。</p>
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">5.AdviceFilter</h3>
			<div class="card-text">
				AdviceFilter提供了AOP风格的支持，类似于SpringMVC中的Interceptor：
				<pre>
boolean preHandle(ServletRequest request, ServletResponse response) throws Exception  
void postHandle(ServletRequest request, ServletResponse response) throws Exception  
void afterCompletion(ServletRequest request, ServletResponse response, Exception exception) throws Exception;   
				</pre>
				<p>
				preHandler：类似于AOP中的前置增强；在拦截器链执行之前执行；如果返回true则继续拦截器链；否则中断后续的拦截器链的执行直接返回；进行预处理（如基于表单的身份验证、授权）
postHandle：类似于AOP中的后置返回增强；在拦截器链执行完成后执行；进行后处理（如记录执行时间之类的）；
afterCompletion：类似于AOP中的后置最终增强；即不管有没有异常都会执行；可以进行清理资源（如接触Subject与线程的绑定之类的）
				</p>
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">6.AccessControlFilter</h3>
			<div class="card-text">
				AccessControlFilter提供了访问控制的基础功能；比如是否允许访问/当访问拒绝时如何处理等：
				<pre>
abstract boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception;  
boolean onAccessDenied(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception;  
abstract boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception;     
				</pre>
				<p>
				isAccessAllowed：表示是否允许访问；mappedValue就是[urls]配置中拦截器参数部分，如果允许访问返回true，否则false；
onAccessDenied：表示当访问拒绝时是否已经处理了；如果返回true表示需要继续处理；如果返回false表示该拦截器实例已经处理了，将直接返回即可。
				</p>
				<p>onPreHandle会自动调用这两个方法决定是否继续处理：</p>
				<pre>
boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {  
    return isAccessAllowed(request, response, mappedValue) || onAccessDenied(request, response, mappedValue);  
}  
				</pre>
				<p>
					另外AccessControlFilter还提供了如下方法用于处理如登录成功后/重定向到上一个请求： 
				</p>
				<pre>
void setLoginUrl(String loginUrl) //身份验证时使用，默认/login.jsp  
String getLoginUrl()  
Subject getSubject(ServletRequest request, ServletResponse response) //获取Subject实例  
boolean isLoginRequest(ServletRequest request, ServletResponse response)//当前请求是否是登录请求  
void saveRequestAndRedirectToLogin(ServletRequest request, ServletResponse response) throws IOException //将当前请求保存起来并重定向到登录页面  
void saveRequest(ServletRequest request) //将请求保存起来，如登录成功后再重定向回该请求  
void redirectToLogin(ServletRequest request, ServletResponse response) //重定向到登录页面
				</pre>
				<p>比如基于表单的身份验证就需要使用这些功能。如果我们想进行访问访问的控制就可以继承AccessControlFilter；如果我们要添加一些通用数据我们可以直接继承PathMatchingFilter。</p>
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">7.拦截器链</h3>
			<div class="card-text">
				Shiro对Servlet容器的FilterChain进行了代理，即ShiroFilter在继续Servlet容器的Filter链的执行之前，通过ProxiedFilterChain对Servlet容器的FilterChain进行了代理；即先走Shiro自己的Filter体系，然后才会委托给Servlet容器的FilterChain进行Servlet容器级别的Filter链执行；Shiro的ProxiedFilterChain执行流程：1、先执行Shiro自己的Filter链；2、再执行Servlet容器的Filter链（即原始的Filter）。
而ProxiedFilterChain是通过FilterChainResolver根据配置文件中[urls]部分是否与请求的URL是否匹配解析得到的。 
				<pre>
FilterChain getChain(ServletRequest request, ServletResponse response, FilterChain originalChain);  
</pre>
				<p>
				即传入原始的chain得到一个代理的chain。
Shiro内部提供了一个路径匹配的FilterChainResolver实现：PathMatchingFilterChainResolver，其根据[urls]中配置的url模式（默认Ant风格）=拦截器链和请求的url是否匹配来解析得到配置的拦截器链的；而PathMatchingFilterChainResolver内部通过FilterChainManager维护着拦截器链，比如DefaultFilterChainManager实现维护着url模式与拦截器链的关系。<b>因此我们可以通过FilterChainManager进行动态动态增加url模式与拦截器链的关系。</b>
				</p>
				<p>DefaultFilterChainManager会默认添加org.apache.shiro.web.filter.mgt.DefaultFilter中声明的拦截器：</p>
				<pre>
public enum DefaultFilter {  
    anon(AnonymousFilter.class),  
    authc(FormAuthenticationFilter.class),  
    authcBasic(BasicHttpAuthenticationFilter.class),  
    logout(LogoutFilter.class),  
    noSessionCreation(NoSessionCreationFilter.class),  
    perms(PermissionsAuthorizationFilter.class),  
    port(PortFilter.class),  
    rest(HttpMethodPermissionFilter.class),  
    roles(RolesAuthorizationFilter.class),  
    ssl(SslFilter.class),  
    user(UserFilter.class);  
}   
				</pre>
				<p>如果想动态实现url-拦截器的注册，就可以通过实现此处的FilterChainResolver来完成，比如：</p>
				<pre>
//1、创建FilterChainResolver  
PathMatchingFilterChainResolver filterChainResolver =  
        new PathMatchingFilterChainResolver();  
//2、创建FilterChainManager  
DefaultFilterChainManager filterChainManager = new DefaultFilterChainManager();  
//3、注册Filter  
for(DefaultFilter filter : DefaultFilter.values()) {  
    filterChainManager.addFilter(  
        filter.name(), (Filter) ClassUtils.newInstance(filter.getFilterClass()));  
}  
//4、注册URL-Filter的映射关系  
filterChainManager.addToChain("/login.jsp", "authc");  
filterChainManager.addToChain("/unauthorized.jsp", "anon");  
filterChainManager.addToChain("/**", "authc");  
filterChainManager.addToChain("/**", "roles", "admin");  
  
//5、设置Filter的属性  
FormAuthenticationFilter authcFilter =  
         (FormAuthenticationFilter)filterChainManager.getFilter("authc");  
authcFilter.setLoginUrl("/login.jsp");  
RolesAuthorizationFilter rolesFilter =  
          (RolesAuthorizationFilter)filterChainManager.getFilter("roles");  
rolesFilter.setUnauthorizedUrl("/unauthorized.jsp");  
  
filterChainResolver.setFilterChainManager(filterChainManager);  
return filterChainResolver;   
				</pre>
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">8.默认拦截器</h3>
			<div class="card-text">
				<p>Shiro内置了很多默认的拦截器，比如身份验证、授权等相关的。默认拦截器可以参考</p>
				<p>org.apache.shiro.web.filter.mgt.DefaultFilter中的枚举拦截器：  </p>
				<div>
					<table class="table table-striped table-bordered table-condensed">
						<tbody>
							<tr>
								<th>默认拦截器名</th>
								<th>拦截器类</th>
								<th>说明（括号里的表示默认值）</th>
							</tr>
							<tr>
								<td>
									<strong>身份验证相关的</strong>
								</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>authc</td>
								<td>org.apache.shiro.web.filter.authc.FormAuthenticationFilter</td>
								<td>
									基于表单的拦截器；如“/**=authc”，如果没有登录会跳到相应的登录页面登录；主要属性：usernameParam：表单提交的用户名参数名（ username）； &nbsp;passwordParam：表单提交的密码参数名（password）； rememberMeParam：表单提交的密码参数名（rememberMe）；&nbsp; loginUrl：登录页面地址（/login.jsp）；successUrl：登录成功后的默认重定向地址； failureKeyAttribute：登录失败后错误信息存储key（shiroLoginFailure）；</p>
								</td>
							</tr>
							<tr>
								<td>authcBasic</td>
								<td>org.apache.shiro.web.filter.authc.BasicHttpAuthenticationFilter</td>
								<td>Basic HTTP身份验证拦截器，主要属性： applicationName：弹出登录框显示的信息（application）</td>
							</tr>
							<tr>
								<td>logout</td>
								<td>org.apache.shiro.web.filter.authc.LogoutFilter</td>
								<td>退出拦截器，主要属性：redirectUrl：退出成功后重定向的地址（/）;示例“/logout=logout”</td>
							</tr>
							<tr>
								<td>user</td>
								<td>org.apache.shiro.web.filter.authc.UserFilter</td>
								<td>用户拦截器，用户已经身份验证/记住我登录的都可；示例“/**=user”</td>
							</tr>
							<tr>
								<td>anon</td>
								<td>org.apache.shiro.web.filter.authc.AnonymousFilter</td>
								<td>匿名拦截器，即不需要登录即可访问；一般用于静态资源过滤；示例“/static/**=anon”</td>
							</tr>
							<tr>
								<td>
									<strong>授权相关的</strong>
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>roles</td>
								<td>org.apache.shiro.web.filter.authz.RolesAuthorizationFilter</td>
								<td>角色授权拦截器，验证用户是否拥有所有角色；主要属性： loginUrl：登录页面地址（/login.jsp）；unauthorizedUrl：未授权后重定向的地址；示例“/admin/**=roles[admin]”</td>
							</tr>
							<tr>
								<td>perms</td>
								<td>org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter</td>
								<td>权限授权拦截器，验证用户是否拥有所有权限；属性和roles一样；示例“/user/**=perms["user:create"]”</td>
							</tr>
							<tr>
								<td>port</td>
								<td>org.apache.shiro.web.filter.authz.PortFilter</td>
								<td>端口拦截器，主要属性：port（80）：可以通过的端口；示例“/test= port[80]”，如果用户访问该页面是非80，将自动将请求端口改为80并重定向到该80端口，其他路径/参数等都一样</td>
							</tr>
							<tr>
								<td>rest</td>
								<td>org.apache.shiro.web.filter.authz.HttpMethodPermissionFilter</td>
								<td>rest风格拦截器，自动根据请求方法构建权限字符串（GET=read, POST=create,PUT=update,DELETE=delete,HEAD=read,TRACE=read,OPTIONS=read, MKCOL=create）构建权限字符串；示例“/users=rest[user]”，会自动拼出“user:read,user:create,user:update,user:delete”权限字符串进行权限匹配（所有都得匹配，isPermittedAll）</td>
							</tr>
							<tr>
								<td>ssl</td>
								<td>org.apache.shiro.web.filter.authz.SslFilter</td>
								<td>SSL拦截器，只有请求协议是https才能通过；否则自动跳转会https端口（443）；其他和port拦截器一样；</td>
							</tr>
							<tr>
								<td><strong>其他</strong></td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>noSessionCreation</td>
								<td>org.apache.shiro.web.filter.session.NoSessionCreationFilter</td>
								<td>不创建会话拦截器，调用 subject.getSession(false)不会有什么问题，但是如果 subject.getSession(true)将抛出 DisabledSessionException异常；</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>