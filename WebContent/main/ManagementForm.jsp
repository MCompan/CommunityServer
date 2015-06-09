<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<link rel="stylesheet" type="text/css" href="css/sign.css" />

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$(".account-table").hide();
		$("#ranking-box-link").click(function(){
		  $(".account-table").fadeOut(100);
		  $(".ranking-table").delay(100).fadeIn(100);
		  $("#ranking-box-link").addClass("active");
		  $("#account-box-link").removeClass("active");
		});
		$("#account-box-link").click(function(){
		  $(".account-table").delay(100).fadeIn(100);;
		  $(".ranking-table").fadeOut(100);
		  $("#ranking-box-link").removeClass("active");
		  $("#account-box-link").addClass("active");
		});
		
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
			window.location.href = "Main.jsp";
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
						window.location.href = "Main.jsp";
						$("#result").text("Success Change Email");
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
						window.location.href = "Main.jsp";
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

  <div class="management-box">
    <div class="lb-header">
      <a href="#" class="active" id="ranking-box-link">My Ranking</a>
      <a href="#" id="account-box-link">Account</a>
    </div>
	<div class="ranking-table">
		
	</div>
    <div class="account-table">
      <div class="u-form-group">
        <input type="text" id="userEmail_signup" placeholder="New Email"/>
      </div>
      <div class="u-form-group">
        <button id="ChangeEmail">Confirm</button>
      </div>
    </div>
      <div class="u-form-group2">
        <button id="logout">LOG OUT</button>
      </div>
  </div>

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