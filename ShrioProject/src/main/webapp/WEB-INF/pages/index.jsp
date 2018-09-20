<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Index Page</title>
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
		<h1>CAS客户端</h1>
		<h3>1、首先使用localhost.keystore导出数字证书（公钥）到D:\localhost.cer</h3>
		<pre>
keytool -export -alias localhost -file D:\localhost.cer -keystore D:\localhost.keystore 
		</pre>
		<h3>2、因为CAS client需要使用该证书进行验证，需要将证书导入到JDK中： </h3>
		<pre>
cd C:\Program Files\Java\jdk1.8.0_151\jre\lib\security  
keytool -import -alias localhost -file D:\localhost.cer -noprompt -trustcacerts -storetype jks -keystore cacerts -storepass 123456   
		</pre>
		<p>如果导入失败，可以先把security 目录下的cacerts删掉</p>
		<p>删除：keytool -delete -alias localhost -keystore cacerts -storepass ssl861110</p>
	</div>
</body>
</html>