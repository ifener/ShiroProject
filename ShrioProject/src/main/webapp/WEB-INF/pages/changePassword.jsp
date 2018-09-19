<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link href="${ctx}/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
<link href="${ctx}/css/bootstrap/bootstrap-theme.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bootstrap/bootstrap.min.js"></script>
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
		<form class="form-horizontal" action="changePassword" method="post">
			<div class="form-group">
				<label for="lastname" class="col-sm-2 control-label">用户名</label>
				<div class="col-sm-10">
					<div class="input-group">
						<span class="input-group-addon glyphicon glyphicon-eye-close"></span>
						<input type="text" class="form-control" value="<shiro:principal />" name="username" />
						
					</div>
				</div>
			</div>
			<div class="form-group">
				<label for="lastname" class="col-sm-2 control-label">密码</label>
				<div class="col-sm-10">
					<div class="input-group">
						<span class="input-group-addon glyphicon glyphicon-eye-close"></span>
						<input type="text" class="form-control" name="password"
						placeholder="请输入密码">
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<c:if test="${message!=null}"><p>${message}</p></c:if>
					<button type="submit" class="btn btn-default">修改密码</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>