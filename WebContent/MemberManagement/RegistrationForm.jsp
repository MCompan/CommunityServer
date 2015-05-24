<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

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
