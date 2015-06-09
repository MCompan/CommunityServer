<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<link rel="stylesheet" type="text/css" href="../Main/css/table.css" />

<title>Notice</title>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import = "Global.Management" %>
<%@ page import = "NoticeBoard.NoticeProcessing" %>
<%@ page import = "NoticeBoard.NoticeDataBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<link rel="stylesheet" type="text/css" href="../main/css/table.css" />
<script src="../js/jquery-2.1.3.min.js"></script>

<%
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
NoticeProcessing manager = NoticeProcessing.getInstance();
Management globalManager = Management.getInstance();
List<NoticeDataBean> list = null;
int pageSize = 6;

String pageNum = request.getParameter("pageNum");
if(pageNum == null) { pageNum = "1"; }
int currentPage = Integer.parseInt(pageNum);

int count = manager.GetWritingCount();
if(count == (currentPage-1) * pageSize) { currentPage -= 1; }

int startRow = (currentPage - 1) * pageSize + 1;

if(count > 0) {
	list = manager.GetList(startRow, pageSize);
	if(list.isEmpty()) { count = 0; }
}
%>
<body id="noticeMain">
<font color="gray" size="10">Total Notices: <%=count %></font>
<br>
<br>
<div id="list" align="center">
	<%if(count == 0) {%>
		No articles
	<%} else {%>
	<table border="2" class="type10">
	 <thead>
		<th>No</th>
		<th>Subject</th>
		<th>Date</th>
	</thead>
		<%
		for(int i=0; i<list.size(); i++) {
			NoticeDataBean article = list.get(i);
			int num = article.getNum();
			String subject = article.getSubject();
			String date = dateFormat.format(article.getRegistrationDate());
	 	%>
	 	<tr>
	 		<td align="center"><%=num %></td>
	 		<td><a href ="../Main/Main.jsp?type=notice&num=<%=num %>"><%=subject %></a></td>
	 		<!-- <td><button class ="btn" id="number" value="../Notice/ViewNotice.jsp?num=<%=num %>"><%=subject %></button></td> -->
	 		<td><%=date %></td>
	 	</tr>
		<%} %>
	</table>
	<%} %>
</div>
</body>