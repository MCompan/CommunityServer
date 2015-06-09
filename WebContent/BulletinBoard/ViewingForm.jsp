<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "BulletinBoard.BoardDataBean" %>
<%@ page import = "BulletinBoard.BoardProcessing" %>
<%@ page import = "Global.Management" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$("#modify").click(function() {
			query = {
				type:"modify",
				num:num,
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
				num:num
			};
			$.ajax({
				type:"post",
				url:"Processing.jsp",
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
