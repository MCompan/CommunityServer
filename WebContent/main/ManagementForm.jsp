<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>
<!-- <link rel="stylesheet" type="text/css" href="css/table.css" /> -->
<link rel="stylesheet" type="text/css" href="css/style.css" />

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
  <link rel="stylesheet" type="text/css" href="css/styleMain.css" />
<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$("#Logout").click(function() {
			var query = {
				type:"logout",}
			$.ajax({
				type:"post",
				url:"Processing.jsp",
				data:query,
				success:function(data){
					if(data == 1) {
						//Success Logout
						$("#result").text("Success Logout");
					}
					else if(data == -1) {
						//Can not Connect
						$("#result").text("Can not Logout");
					}
				}
			 });
			window.location.href = "jsp.jsp";
		});

		$("#ChangeEmail").click(function() {
			var newEmail = $("#newEmail").val();
			if(newEmail == "") { 
				$("#result").text("Need fill new Email");
				return; 
			} //No Input
			var query = { 
					type:"changeEmail",
					newEmail:newEmail};
			$.ajax({
				type:"post",
				url:"Processing.jsp",
				data:query,
				success:function(data){
					if(data == 1) {
						//Success Change
						$("#result").text("Success Change Email");
						window.location.href = "jsp.jsp";
					} else if(data == -1) {
						//Can not Connect
						$("#result").text("Can not Connect");
					} else if(data == -2) {
						//Overlap Email
						$("#result").text("Overlap Email");
					} else if(data == -3) {
						//Can not process with Facebook account
						$("#result").text("Can not process with Facebook account");
					}
				}
			 });
		});

		$("#Withdrawal").click(function() {
			var query = {
					type:"withdrawal",}
			$.ajax({
				type:"post",
				url:"Processing.jsp",
				data:query,
				success:function(data){
					if(data == 1) {
						//Success Withdrawal
						$("#result").text("Success Withdrawal");
						window.location.href = "jsp.jsp";
					} else if(data == -1) {
						//Can not Connect
						$("#result").text("Can not Connect");
					} else if(data == -2) {
						//Can not process with Facebook account
						$("#result").text("Can not process with Facebook account");
					}
				}
			 });
		});
	});
</script>
<% String email = (String)session.getAttribute("userEmail"); %>
<table class="type09">
 <thead>
    <tr>
        <th colspan="2"><font size="5"><%=email %>님 어서오세요</font></th>
    </tr>
 </thead>
 
    <tr>
    	<td colspan="2"><input type="text" id="newEmail"></td>
    </tr>
    <tr>
    	<td colspan="2"><button id="ChangeEmail" class="btn" class="btn"><font size="6">변경</font></button></td>
    </tr>
    <tr>
		<td colspan="2"><label id="Logout" class="btn">로그아웃</label></td>
    </tr>
    <tr>
    	 <td colspan="2"><label id="Withdrawal" class="btn">계정삭제</label></td>
    </tr>
    </tbody>
</table>   

 <font color="white">result:</font>
	<div id="result" ></div>
	
<!-- 
<table border="2" style="font-size: large; border-color: blue; border-collapse: collapse;">

	<tr>
		<td colspan="3" align="center">Management
	</tr>
	<tr align="center">
		<td colspan="2"><button id="Logout">로그아웃</button>
	</tr>
	<tr>
		<td><input type="text" id="newEmail">
		<td><button id="ChangeEmail">이메일 변경</button>
	</tr>
	<tr align="center">
		<td colspan="2"><button id="Withdrawal">계정 삭제</button>
	</tr>
</table> -->