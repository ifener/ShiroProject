<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Shiro 标签</title>
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

		<h3>1.导入标签库</h3>
		<article>
			&lt;%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %&gt;  
		</article>
	
		<h3>2.guest标签</h3>
		<p>用户没有身份验证时显示相应信息，即游客访问信息。</p>
	    <div>
	    	<pre>
&lt;shiro:guest&gt;
欢迎游客访问，&lt;a href="${pageContext.request.contextPath}/login"&gt;登录&lt;/a&gt; 
&lt;/shiro:guest&gt; 
	    	</pre>
	    	
	    	<shiro:guest>  
				欢迎游客访问，<a href="${pageContext.request.contextPath}/login">登录</a>  
			</shiro:guest>   
	    </div>
	    
		<div class="card card-block">
			<h3 class="card-title">3.user标签</h3>
			<p>用户已经身份验证/记住我登录后显示相应的信息。</p>
			<div class="card-text">
				<pre>
&lt;shiro:user&gt; 
欢迎[&lt;shiro:principal/&gt; ]登录，&lt;a href="${pageContext.request.contextPath}/logout"&gt; 退出&lt;/a&gt;  
&lt;/shiro:user&gt; 
				</pre>
				<shiro:user>  
					欢迎[<shiro:principal/>]登录，<a href="${pageContext.request.contextPath}/logout">退出</a>  
				</shiro:user>   
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">4.authenticated标签</h3>
			<div class="card-text">
				<p>用户已经身份验证通过，即Subject.login登录成功，不是记住我登录的。    </p>
				<pre>
&lt;shiro:authenticated&gt;
    用户[&lt;shiro:principal/&gt;]已身份验证通过  
&lt;/shiro:authenticated&gt;
				</pre>
				<div>
					<shiro:authenticated>  
    					用户[<shiro:principal/>]已身份验证通过  
					</shiro:authenticated>  
				</div>
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">5.notAuthenticated标签</h3>
			<div class="card-text">
				<p>用户已经身份验证通过，即没有调用Subject.login进行登录，包括记住我自动登录的也属于未进行身份验证。 </p>
				<pre>
&lt;shiro:notAuthenticated&gt;
    未身份验证（包括记住我）
&lt;/shiro:notAuthenticated&gt;
				</pre>
				<div>
					<shiro:notAuthenticated>
    					未身份验证（包括记住我）
					</shiro:notAuthenticated>
				</div>
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">6.hasRole标签 </h3>
			<div class="card-text">
				如果当前Subject没有角色将显示body体内容。 
				<pre>
&lt;shiro:lacksRole name="abc"&gt;
    用户[&lt;shiro:principal/&gt;]没有角色abc
&lt;/shiro:lacksRole&gt; 
                </pre>
				<p>
				    <shiro:hasRole name="admin">  
   						 用户[<shiro:principal/>]拥有角色admin<br/>  
					</shiro:hasRole>   
				</p>
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">7.hasAnyRoles标签 </h3>
			<div class="card-text">
				<p>如果当前Subject有任意一个角色（或的关系）将显示body体内容。 </p>
				<pre>
&lt;shiro:hasAnyRoles name="admin,user"&gt;  
    用户[&lt;shiro:principal/&gt;]拥有角色admin或user
&lt;/shiro:hasAnyRoles&gt;
                </pre>
				<p>
				   <shiro:hasAnyRoles name="admin,user">  
					    用户[<shiro:principal/>]拥有角色admin或user<br/>  
				   </shiro:hasAnyRoles>   
				</p>
			</div>
		</div>
		
		<div class="card card-block">
			<h3 class="card-title">8.lacksRole标签 </h3>
			<div class="card-text">
				<p>如果当前Subject没有角色将显示body体内容。</p>
				<pre>
&lt;shiro:lacksRole name="abc"&gt; 
    用户[&lt;shiro:principal/&gt;]没有角色abc  
&lt;/shiro:lacksRole&gt;
				</pre>
				<p>
					<shiro:lacksRole name="abc">  
					    用户[<shiro:principal/>]没有角色abc<br/>  
					</shiro:lacksRole>   
				</p>
				<p>
				其它还有：hasPermission标签、lacksPermission标签等
				</p>
			</div>
		</div>
		
	</div>
</body>
</html>