<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "BulletinBoard.BoardDataBean" %>
<%@ page import = "BulletinBoard.BoardProcessing" %>
<%@ page import = "Global.Management" %>
<link rel="stylesheet" type="text/css" href="../Main/css/table.css" />
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$("#write").click(function() {
			$("#meun").load("../BulletinBoard/WritingForm.jsp");
		});
	});
</script>

<%
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
BoardProcessing manager = BoardProcessing.getInstance();
Management globalManager = Management.getInstance();
List<BoardDataBean> list = null;
int pageSize = 50;

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
<font color="gray" size="8">Total Articles: <%=count %></font>
<br>
<br>
<div id="list" align="center">
	<%if(count == 0) {%>
		No articles
	<%} else {%>
	<table class="type10">
		<thead>
		<tr>
			<th>No
			<th>Subject
			<th>Email
			<th>Read Count
			<th>Date</th>
		</tr>
		</thead>
		<%
		for(int i=0; i<list.size(); i++) {
			BoardDataBean article = list.get(i);
			int num = article.getNum();
			String subject = article.getSubject();
			String user = globalManager.GetUser(article.getUserNumber());
			int readCount = article.getReadCount();
			String date = dateFormat.format(article.getRegistrationDate());
	 	%>
	 	<tr>
	 		<td align="center"><%=num %>
	 		<!-- <td><a href ="../BulletinBoard/ViewingForm.jsp?num=<%=num %>"><%=subject %></a> -->
	 		<td><a href ="Main.jsp?num=<%=num %>"><%=subject %></a>
	 		<td><%=user %>
	 		<td align="center"><%=readCount %>
	 		<td><%=date %></td>
		<%} %>
	</table>
	<%} %>
</div>
<br>
<button id="write" <%if(session.getAttribute("userNumber")==null) {%> disabled="disabled" <%} %> >글쓰기</button>