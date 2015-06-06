<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html lang="en"> <!--<![endif]-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<link rel="stylesheet" href="css/style.css">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$("#submit").click(function() {
			var userEmail = $("#userEmail").val();
			var userPassword = $("#userPassword").val();
			if(userEmail == "" || userPassword == "") { return; } //No Input
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
						window.location.href = "Main.jsp";
					}
					else if(data == -1) {
						//Can not Connect
						$("#result").text("Can not Connect");
					}
					else if(data == -2) {
						//Overlap Email
						$("#result").text("Overlap Email");
					}
					else if(data == -3) {
						//Wrong Access
						$("#result").text("Wrong Access");
					}
				}
			 });
		});
		$("#cancel").click(function() {
			window.location.href = "Main.jsp";
		});
	});
</script>
<!-- 
<table border="2" style="font-size: large; border-color: blue; border-collapse: collapse;" >
	<tr>
		<td colspan="2" align="center">Registration
	</tr>
	<tr>
		<td align="right">Email
		<td><input type="text" id="userEmail" name="userEmail" autofocus>
	</tr>
	<tr align="right">
		<td>Password
		<td><input type="password" id="userPassword" name="userPassword">
	</tr>
	<tr align="center">
		<td><button id="submit">완료</button>
		<td><button id="cancel">취소</button>
	</tr>
</table>
-->
<body>
  <form method="post" class="login">
  	<p>Registration</p>
    <p>
      <label for="login">Email:</label>
      <input type="text" name="userEmail" id="userEmail" value="" autofocus>
    </p>

    <p>
      <label for="password">Password:</label>
      <input type="password" name="userPassword" id="userPassword" value="">
    </p>

    <p class="login-submit">
      <button id="submit" class="login-button"></button>
    </p>
	<button id="cancel">Cancel</button>
  </form>
</body>
