<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "BulletinBoard.BoardDataBean" %>
<%@ page import = "BulletinBoard.BoardProcessing" %>
<%@ page import = "BulletinBoard.CommentsDataBean" %>
<%@ page import = "BulletinBoard.CommentsProcessing" %>
<%@ page import = "Global.Management" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$("#modify").click(function() {
			query = {
				type:"modify",
				num:$("#num").val(),
				subject:$("#subject").val(),
				content:$("#content").val()
			};
			$.ajax({
				type:"post",
				url:"../BulletinBoard/Processing.jsp",
				data:query,
				success:function(data){
					if(data == -1) {
						$("#boardResult").text("Fail to connect");
					} else if(data == 1) {
						$("#boardResult").text("Success to deletion");
					}
				}
			});
			window.history.back();
		});
		$("#delete").click(function() {
			query = {
				type:"delete",
				num:$("#num").val(),
			};
			$.ajax({
				type:"post",
				url:"../BulletinBoard/Processing.jsp",
				data:query,
				success:function(data){
					if(data == -1) {
						$("#boardResult").text("Fail to connect");
					} else if(data == 1) {
						$("#boardResult").text("Success to deletion");
					}
				}
			});
			window.history.back();
		});
		$("#back").click(function() {
			window.history.back();
		});
		$("#commentSubmit").click(function() {
			query = {
					type:"commentSubmit",
					userNumber:$("#userNumber").val(),
					articleNumber:$("#num").val(),
					content:$("#comment").val()
			};
			$.ajax({
				type:"post",
				url:"../BulletinBoard/Processing.jsp",
				data:query,
				success:function(data){
					if(data == -1) {
						$("#boardResult").text("Fail to connect");
					} else if(data == 1) {
						$("#boardResult").text("Success to deletion");
					}
				}
			});
			window.location.reload(true);
		});
		$("#commentDelete").click(function() {
			query = {
					type:"commentDelete",
					userNumber:$("#userNumber").val(),
					articleNumber:$("#num").val(),
					content:$("#comment").val()
			};
			$.ajax({
				type:"post",
				url:"../BulletinBoard/Processing.jsp",
				data:query,
				success:function(data){
					if(data == -1) {
						$("#boardResult").text("Fail to connect");
					} else if(data == 1) {
						$("#boardResult").text("Success to deletion");
					}
				}
			});
			window.location.reload(true);
		});
	});
</script>

<%
BoardProcessing manager = BoardProcessing.getInstance();
Management globalManager = Management.getInstance();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 

BoardDataBean article = manager.GetWriting(Integer.parseInt(request.getParameter("num")), true);

int num = article.getNum();
String subject = article.getSubject();
String email = globalManager.GetUser(article.getUserNumber());
String date = dateFormat.format(article.getRegistrationDate());
int readCount = article.getReadCount();
String content = article.getContent();

boolean isWriter = false;
try{
	if(email.equals(session.getAttribute("userEmail").toString())) {
		isWriter = true;
	}
}catch(Exception e) {}
%>

<%
	CommentsProcessing commentManager = CommentsProcessing.getInstance();
	List<CommentsDataBean> comments = null;
	comments = commentManager.GetCommentList(num);
	int userNumber = -1;
	
	try{
		userNumber = Integer.parseInt(session.getAttribute("userNumber").toString());
	}catch(Exception e) {}
%>

<input type="hidden" id="num" value="<%=num %>">
<input type="hidden" id="userNumber" value="<%=userNumber %>">

<table border="2" style="font-size: large; border-color: blue; border-collapse: collapse;">
	<tr>
		<td>No. <label id="num"><%=num %></label>
		<td colspan="2">Subject: 
			<input type="text" <%if(!isWriter) {%>readonly="readonly"<%} %> id="subject" value="<%=subject %>">
	<tr>
		<td colspan="2">Email: <%=email %>
		<td>Read Count: <%=readCount %>
	<tr>
		<td colspan="3">Written at: <%=date %>
	<tr>
		<td colspan="3">
			<textarea id="content" <%if(!isWriter) {%>readonly="readonly"<%} %> rows="10" cols="50"><%=content %></textarea>
	<tr>
		<td><button id="modify" <%if(!isWriter) {%> disabled="disabled" <%} %>>수정</button> 
		<td><button id="delete" <%if(!isWriter) {%> disabled="disabled" <%} %>>삭제</button>
		<td><button id="back">뒤로</button>
</table>

<br>
<br>
<table>
	<tr>
		<td><label>댓글</label></td>
		<td><input type="text" id="comment" placeholder="comment" style="width: 600px" <%if(userNumber <= 0) {%> disabled="disabled" <%} %>></td>
		<td><button id="commentSubmit" <%if(userNumber <= 0) {%> disabled="disabled" <%} %>>입력</button></td>
</table>
<br>

<%	
	if (comments != null) {
%>
<table border="1">
	<tr>
		<th>Email
		<th>Comment
		<th colspan="2">Date
<%
		for (int i = 0; i < comments.size(); i++) {
			CommentsDataBean commentData = comments.get(i);
			int commentNumber = commentData.getNum();
			String commentEmail = globalManager.GetUser(commentData.getUserNumber());
%>
	<tr>
		<td style="width:150px;"><%=commentEmail %>
		<td style="width:350px;"><%=commentData.getContent() %></td>
		<td style="width:150px;"><%=dateFormat.format(commentData.getRegistrationDate()) %></td>
		<td><button id="commentDelete" <%if(userNumber != commentData.getUserNumber()) {%> disabled="disabled" <%} %> onclick="../BulletinBoard/Processing.jsp?type=commentDelete&num=<%=commentNumber %>">delete</button></td>
<%
		}
%>
</table>
<%
	}
%>
