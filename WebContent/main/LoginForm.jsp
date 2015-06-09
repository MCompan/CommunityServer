<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<link rel="stylesheet" type="text/css" href="css/sign.css" />

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$(".email-signup").hide();
		$("#signup-box-link").click(function(){
		  $(".email-login").fadeOut(100);
		  $(".email-signup").delay(100).fadeIn(100);
		  $("#login-box-link").removeClass("active");
		  $("#signup-box-link").addClass("active");
		});
		$("#login-box-link").click(function(){
		  $(".email-login").delay(100).fadeIn(100);;
		  $(".email-signup").fadeOut(100);
		  $("#login-box-link").addClass("active");
		  $("#signup-box-link").removeClass("active");
		});
		
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
						window.location = "jsp.jsp"
					}else if(data == 1) {
						//Success Login
						window.location = "jsp.jsp"
					}else if(data == -1) {
						//Can not Connect
						$("#result").text("Can not Connect");
					}else if(data == -2) {
						//Wrong password
						alert("잘못된 비밀번호입니다");
					}else if(data == -3) {
						//No ID
						alert("잘못된 아이디입니다");
					}else if(data == -4) {
						//Wrong Email
						alert("잘못된 아이디입니다");
					}
					clearPassword();
				}
			 });
		});

		$("#signup").click(function() {
			var userEmail = $("#userEmail_signup").val();
			var userPassword = $("#userPassword_signup").val();
			var userConfirmPassword = $("#userConfirmPassword_signup").val();
			if(userEmail == "") { alert("이메일을 입력하세요"); clearPassword(); return; }
			if(userPassword == "") { alert("비밀번호를 입력하세요"); clearPassword(); return; }
			if(userPassword != userConfirmPassword) { alert("비밀번호를 확인하세요"); clearPassword(); return; }

			var query = {
					type:"registration",
					userID:userEmail,
					userEmail:userEmail,
					userPassword:userPassword};
			$.ajax({
				type:"post",
				url:"Processing.jsp",
				data:query,
				success:function(data){
					$("#result").text(data);
					if(data == 1) {
						//Success Registration
						$("#result").text("Success Registration");
						window.location = "jsp.jsp"
					}
					else if(data == -1) {
						//Can not Connect
						$("#result").text("Can not Connect");
					}
					else if(data == -2) {
						//Overlap Email
						alert("이미 있는 이메일입니다");
						$("#result").text("Overlap Email");
					}
					else if(data == -3) {
						//Wrong Access
						alert("잘못된 접근입니다");
						$("#result").text("Wrong Access");
					}
					else if(data == -4) {
						//null ID
						alert("이미 있는 이메일입니다");
					}
				}
			 });
		});
		
		function clearPassword() {
			$("#userPassword").val("");
			$("#userPassword_signup").val("");
			$("#userConfirmPassword_signup").val("");
		}
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

<body>

  <div class="login-box">
    <div class="lb-header">
      <a href="#" class="active" id="login-box-link">Login</a>
      <a href="#" id="signup-box-link">Sign Up</a>
    </div>
    <form class="email-login">
      <div class="u-form-group">
        <input type="text" id="userEmail"  placeholder="Email"/>
      </div>
      <div class="u-form-group">
        <input type="password" id="userPassword" placeholder="Password"/>
      </div>
    <div class="social-login">
      <a href="#" id="login">Log in</a>
      <a href="#">Login in with facebook</a>
    </div>
    </form>
    <form class="email-signup">
      <div class="u-form-group">
        <input type="text" id="userEmail_signup" placeholder="Email"/>
      </div>
      <div class="u-form-group">
        <input type="password" id="userPassword_signup" placeholder="Password"/>
      </div>
      <div class="u-form-group">
        <input type="password" id="userConfirmPassword_signup" placeholder="Confirm Password"/>
      </div>
      <div class="u-form-group">
        <button id="signup">Sign Up</button>
      </div>
    </form>
  </div>
  
</body>
</html>
