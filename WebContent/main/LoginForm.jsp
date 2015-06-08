
<%@page import="java.io.Console"%>
<%@page import="com.sun.org.apache.xml.internal.resolver.helpers.Debug"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<link rel="stylesheet" href="css/style.css">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<link rel="stylesheet" type="text/css" href="css/styleMain.css" />

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		var cookie = document.cookie;
		if(cookie.length > 0) {
			var startEmailIndex = cookie.indexOf("userEmail");
			var endEmailIndex;
			if(startEmailIndex != -1) {
				startEmailIndex += "userEmail".length;
				endEmailIndex = cookie.indexOf(";", startEmailIndex);
				if(endEmailIndex == -1) {
					endEmailIndex = cookie.length;
				}
				$("#userEmail").val(cookie.substring(startEmailIndex+1, endEmailIndex));
			}
			var startPasswordIndex = cookie.indexOf("userPassword");
			var endPasswordIndex; 
			if(startPasswordIndex != -1) {
				startPasswordIndex += "userPassword".length;
				endPasswordIndex = cookie.indexOf(";", startPasswordIndex);
				if(endPasswordIndex == -1) {
					endPasswordIndex = cookie.length;
				}
				$("#userPassword").val(cookie.substring(startPasswordIndex+1, endPasswordIndex));
			}
		}
		$("#registration").click(function() {
			$("#meun").load("RegistrationForm.jsp");
		});
		$("#login").click(function() {
			var userEmail = $("#userEmail").val();
			var userPassword = $("#userPassword").val();
			if(userEmail == "" || userPassword == "") { return; } //No Input
			var query = {
					type:"login",
					userEmail:userEmail,
					userPassword:userPassword};
			$.ajax({
				type:"post",
				url:"Processing.jsp",
				data:query,
				success:function(data){
					if(data == 2) {
						$("#result").text("Success Login by Admin");
						$("#mainForm").load("ManagementForm.jsp");
					}else if(data == 1) {
						//Success Login
						$("#result").text("Success Login");
						$("#mainForm").load("ManagementForm.jsp");
					}else if(data == -1) {
						//Can not Connect
						$("#result").text("Can not Connect");
					}else if(data == -2) {
						//Wrong password
						$("#result").text("Wrong password");
					}else if(data == -3) {
						//No ID
						$("#result").text("No ID");
					}else if(data == -4) {
						//Wrong Email
						$("#result").text("Wrong Email");
					}
				}
			 });
		});
	});
</script>
<div id="fb-root"></div>
<script>
	window.fbAsyncInit = function() {
		FB.init({
			appId      : '1404481809875509',
			cookie     : true,  // enable cookies to allow the server to access 
                       // the session
			xfbml      : true,  // parse social plugins on this page
			version    : 'v2.3' // use version 2.3
		});
		FB.getLoginStatus(function(response) {
			statusChangeCallback(response);
			uid = response.authResponse.userID;
		});
	};
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) return;
		js = d.createElement(s); js.id = id;
		js.src = "//connect.facebook.net/en_US/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
	function checkLoginState() {
		statusChangeCallback(response);
		uid = response.authResponse.userID;
	}
	function statusChangeCallback(response) {
		var userID = response.authResponse.userID;
		var query = {
				type:"FB.login",
				userID:userID};
		if (response.status === 'connected' || response.status === 'not_authorized') {
			$.ajax({
				type:"post",
				url:"Processing.jsp",
				data:query,
				success:function(data){
					if(data == 2) {
						//Success Registration and Login with Facebook
						$("#result").text("Success Registration and Login with Facebook");
						$("#mainForm").load("ManagementForm.jsp");
					}else if(data == 1) {
						//Success Login
						$("#result").text("Success Login with Facebook");
						$("#mainForm").load("ManagementForm.jsp");
					}else if(data == -1) {
						//Can not Connect
						$("#result").text("Can not Connect");
					}
				}
			 });
		}else {
			// The person is not logged into Facebook, so we're not sure if
			// they are logged into this app or not.
			$("#result").text("Fail to login with Facebook");
		}
	}
</script>
<!-- 
<table border="2" style="font-size: large; border-color: blue; border-collapse: collapse;">
	<tr>
		<td colspan="3" align="center">Login
	</tr>
	<tr>
		<td align="right">Email
		<td colspan="2"><input type="text" id="userEmail" name="userEmail" value="" autofocus>
	</tr>
	<tr align="right">
		<td>Password
		<td colspan="2"><input type="password" id="userPassword" name="userPassword" value="">
	</tr>
	<tr align="center">
		<td><button id="registration">회원가입</button>
		<td align="char"><fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>
		<td><button id="login">로그인</button>
	</tr>
</table>
 -->

<body>
  <form method="post"  class="login">
  	<font size="40px" color="white">
  	<p>Login</p></font>
    <p>
      <label id="new">Email:</label>
      <input type="text" name="userEmail" id="userEmail" autofocus>
    </p>

    <p>
      <label id="new">Password:</label>
      <input type="password" name="userPassword" id="userPassword">
    </p>
<p></p>
    <p class="login-submit">
      <button id="login" class="login-button">Login</button>
    </p>
	<button id="registration" class ="btn">Registration</button>
	 <fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button> 
  </form>
</body>
</html>
