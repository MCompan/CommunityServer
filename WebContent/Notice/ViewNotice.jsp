<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>Notice</title>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import = "Global.Management" %>
<%@ page import = "NoticeBoard.NoticeProcessing" %>
<%@ page import = "NoticeBoard.NoticeDataBean" %>
<script src="../js/jquery-2.1.3.min.js"></script>
<script>
$(document).ready(function() {
	$("#back").click(function() {
			window.history.back();
		});
	});
	
</script>

<%
NoticeProcessing manager = NoticeProcessing.getInstance();
Management globalManager = Management.getInstance();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 

NoticeDataBean article = manager.GetWriting(Integer.parseInt(request.getParameter("num")));

int num = article.getNum();
String subject = article.getSubject();
String date = dateFormat.format(article.getRegistrationDate());
String content = article.getContent();
%>
<body>
	<table border="2" style="font-size: large; border-color: blue; border-collapse: collapse;">
	<tr>
		<td>No. <label id="num"><%=num %></label>
		<td colspan="2">Subject: 
			<input type="text" readonly="readonly" id="subject" value="<%=subject %>">
	<tr>
		<td colspan="3">Written at: <%=date %>
	<tr>
		<td colspan="3">
			<textarea id="content" readonly="readonly" rows="10" cols="50"><%=content %></textarea>
	<tr>
		<td><button id="back">뒤로</button>
</table>
</body>