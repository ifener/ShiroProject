<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
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
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>

	<div class="container">
		<h1>登录成功</h1>
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
	</div>
</body>
</html>