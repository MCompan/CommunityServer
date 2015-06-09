<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>
<%@ page import="NoticeBoard.NoticeDataBean" %>
<%@ page import="NoticeBoard.NoticeProcessing" %>

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
$(document).ready(function() {
	$("#submit").click(function() {
		var subject = $("#subject").val();
		var content = $("#content").val();
		var query = {
				type:"writing",
				subject:subject,
				content:content
		};
		$.ajax({
			type:"post",
			url:"../Main/AdminForm.jsp",
			data:query,
			success:function(data) {
			}
		});
		window.location = "../Main/Main.jsp";
	});
	$("#cancel").click(function() {
		window.location = "../Main/Main.jsp";
	});
	$("#deleteSubmit").click(function() {
		var num = $("#deleteNum").val();
		var query = {
				type:"delete",
				num:num
		};
		$.ajax({
			type:"post",
			url:"../Main/AdminForm.jsp",
			data:query,
			success:function(data) {
			}
		});
		window.location = "../Main/Main.jsp";
	});
});
</script>

<%
	String type = request.getParameter("type");
	if(type != null) {
		NoticeProcessing manager = NoticeProcessing.getInstance();
		NoticeDataBean data = new NoticeDataBean();
		switch(type) {
		case "writing":
			data.setSubject(request.getParameter("subject"));
			data.setContent(request.getParameter("content"));
			manager.Writing(data);
			break;
		case "delete":
			int num = Integer.parseInt(request.getParameter("num"));
			manager.DeleteWriting(num);
			break;
		}
	}
%>

<table>
	<tr>
		<td>Subject
		<td><input type="text" id="subject">
	<tr>
		<td>Content
		<td width="50px"><textarea id="content" rows="10" cols="50"></textarea>
	<tr>
		<td><button id="submit">글쓰기</button>
		<td><button id="cancel">취소</button>
</table>
<br><br>
<label>글 삭제</label> <input type="number" id="deleteNum" placeholder="article number"> <input type="button" id="deleteSubmit" value="Delete">