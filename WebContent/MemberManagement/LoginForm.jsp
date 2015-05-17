<%@page import="java.io.Console"%>
<%@page import="com.sun.org.apache.xml.internal.resolver.helpers.Debug"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$("#registration").click(function() {
			$("#mainForm").load("RegistrationForm.jsp");
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
				url:"MemberManagementProcess.jsp",
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
	function statusChangeCallback(response) {
		var userID = response.authResponse.userID;
		var query = {
				type:"FB.login",
				userID:userID};
		if (response.status === 'connected' || response.status === 'not_authorized') {
			$.ajax({
				type:"post",
				url:"MemberManagementProcess.jsp",
				data:query,
				success:function(data){
					if(data == 1) {
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


<%!
Cookie[] cookies;
Cookie emailCookie;
Cookie passwordCookie;
String getEmailCookie() {
	try{
		if(emailCookie.getName().equals("userEmail")) {
			return emailCookie.getValue();
		}
	}catch(Exception e) {}
	return "";
}
String getPasswordCookie() {
	try{
		if(passwordCookie.getName().equals("userPassword")) {
			return passwordCookie.getValue();
		}
	}catch(Exception e) {}
	return "";
}
%>
<%
try {
	cookies = request.getCookies();
	for(int i = 0; i < cookies.length; i++) {
		if(cookies[i].getName().equals("userEmail")) {
			emailCookie = cookies[i];
		}
		else if(cookies[i].getName().equals("userPassword")) {
			passwordCookie = cookies[i];
		}
	}
}catch(Exception e) {}
%>

<table border="2" style="font-size: large; border-color: blue; border-collapse: collapse;">
	<tr>
		<td colspan="3" align="center">Login
	</tr>
	<tr>
		<td align="right">Email
		<td colspan="2"><input type="text" id="userEmail" name="userEmail" value="<%=getEmailCookie()%>" autofocus>
	</tr>
	<tr align="right">
		<td>Password
		<td colspan="2"><input type="text" id="userPassword" name="userPassword" value="<%=getPasswordCookie()%>">
	</tr>
	<tr align="center">
		<td><button id="registration">회원가입</button>
		<td align="char"><div class="fb-login-button" data-max-rows="1" data-size="medium" data-show-faces="false" data-auto-logout-link="false"></div>
		<td><button id="login">로그인</button>
	</tr>
</table>