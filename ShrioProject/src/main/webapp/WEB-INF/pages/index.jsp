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
		<h1>生成证书</h1>
		<p>
			keytool -genkey -keystore "D:\ssl.keystore" -alias localhost -keyalg RSA
		</p>
		<h1>CAS客户端</h1>
		<h3>1、首先使用localhost.keystore导出数字证书（公钥）到D:\ssl.cer</h3>
		<pre>
keytool -export -alias localhost -file D:\ssl.cer -keystore D:\ssl.keystore 
		</pre>
		<h3>2、因为CAS client需要使用该证书进行验证，需要将证书导入到JDK中： </h3>
		<pre>
cd C:\Program Files\Java\jdk1.8.0_151\jre\lib\security
keytool -import -alias localhost -file D:\ssl.cer -noprompt -trustcacerts -storetype jks -keystore cacerts -storepass ssl861110   
		</pre>
		<p>如果导入失败，可以先把security 目录下的cacerts删掉</p>
		<p>删除：keytool -delete -alias localhost -keystore cacerts -storepass ssl861110</p>
		
		<h3>3.配置Tomcat</h3>
		<pre>
&lt;Connector SSLEnabled="true" clientAuth="false" 
    keystoreFile="D:\02.Tomcat\ssl.keystore" 
    keystorePass="ssl861110" maxThreads="200" port="8443" 
    protocol="org.apache.coyote.http11.Http11NioProtocol" 
    scheme="https" secure="true" sslProtocol="TLS"/&gt;
		</pre>
		<h3>4.常见的错误</h3>
		<ol>
			<li>
				<dl>
					<dt>No Name Matching localhost Found Error</dt>
					<dd>
						这是由于创建证书的时候询问您的名字与姓氏是什么?(What is your first and last name?)的时候要填写localhost,如果是域名要填写域名
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>InvalidAlgorithmParameterException: the trustAnchors parameter must be non-empty</dt>
					<dd>
						<p>这也是由于证书不正确引起的，在创建及导入证书的时候别名要用localhost或者域名</p>
						<p>
							
							keytool -genkey -keystore "D:\ssl.keystore" -alias <span style="color:red;font-weight:bold;">localhost</span> -keyalg RSA<br />
							keytool -export -alias <span style="color:red;font-weight:bold;">localhost</span> -file D:\ssl.cer -keystore D:\ssl.keystore<br />
							keytool -import -alias <span style="color:red;font-weight:bold;">localhost</span> -file D:\ssl.cer -noprompt -trustcacerts -storetype jks -keystore cacerts -storepass ssl861110
						</p>
				    </dd>
				</dl>
			</li>
		</ol>
	</div>
</body>
</html>