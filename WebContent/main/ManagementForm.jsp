<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "Ranking.RankingDataBean" %>
<%@ page import = "Ranking.RankingProcessing" %>
<%@ page import = "Global.Management" %>
<% request.setCharacterEncoding("utf-8"); %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<link rel="stylesheet" type="text/css" href="css/management.css" />
<link rel="stylesheet" type="text/css" href="css/table.css" />

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
					window.location.href = "Main.jsp";
				}
			 });
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
						alert("Can not Connect");
						$("#result").text("Can not Connect");
					} else if(data == -2) {
						//Overlap Email
						alert("Overlap Email");
						$("#result").text("Overlap Email");
					} else if(data == -3) {
						//Can not process with Facebook account
						alert("Can not Connect");
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
<%
	String email = (String)session.getAttribute("userEmail"); 
	RankingProcessing manager = RankingProcessing.getInstance();
	Management globalManager = Management.getInstance();
%>

  <div class="management-box">
    <div class="lb-header">
      <a href="#" class="active" id="ranking-box-link">My Ranking</a>
      <a href="#" id="account-box-link">Account</a>
    </div>
	<div class="ranking-table">
  <div align="center"><font size="5">Welcome,</font> <font size="5" color="blue"><%=email %></font><font size="5">!</font></div>
<br>
<%
	String r1 = "";
	String r2 = "";
	String r3 = "";
	String r4 = "";
	String r5 = "";
	String id = "";
	id = (String) session.getAttribute("userEmail");
	if (id == null || id.equals("")) {

	} else {
		List<RankingDataBean> listUser = manager.GetUserRanking(id);
%>
<div align="center">
<table>
  <tr>
    <th>Stage1</th>
    <th>Stage2</th>
    <th>Stage3</th>
    <th>Stage4</th>
    <th>Stage5</th>
  </tr>
  <%if(listUser!=null){ %>
  <tr>
	<%
		for (int i = 0; i < listUser.size(); i++) {
					RankingDataBean temp1 = listUser.get(i);

					if (temp1.getStage() == 1) {
						r1 = globalManager.msToString(temp1.getRecording());
					} else if (temp1.getStage() == 2) {
						r2 = globalManager.msToString(temp1.getRecording());
					} else if (temp1.getStage() == 3) {
						r3 = globalManager.msToString(temp1.getRecording());
					} else if (temp1.getStage() == 4) {
						r4 = globalManager.msToString(temp1.getRecording());
					} else if (temp1.getStage() == 5) {
						r5 = globalManager.msToString(temp1.getRecording());
					}
				}
	%>
	<td><%=r1 %></td> 
    <td><%=r2 %></td>
    <td><%=r3 %></td>
    <td><%=r4 %></td>
    <td><%=r5 %></td>
    <%} %>
  </tr>
</table>
</div>
<br>
<%} %>
	</div>
    <div class="account-table">
      <div class="u-form-group">
        <input type="text" id="newEmail" placeholder="New Email"/>
      </div>
      <div class="u-form-group">
        <button id="ChangeEmail">Change Email</button>
      </div>
      <div class="u-form-group">
        <button id="Withdrawal">Withdrawal</button>
        <br>
        <br>
      </div>
      </div>
      <div class="u-form-group2">
        <button id="Logout">LOG OUT</button>
      </div>
  </div>