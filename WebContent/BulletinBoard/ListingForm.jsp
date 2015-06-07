<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "BulletinBoard.BoardDataBean" %>
<%@ page import = "BulletinBoard.BoardProcessing" %>
<%@ page import = "Global.Management" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$("#write").click(function() {
			$("#boardForm").load("../BulletinBoard/WritingForm.jsp");
		});
	});
</script>

<%
BoardProcessing manager = BoardProcessing.getInstance();
Management globalManager = Management.getInstance();
List<BoardDataBean> list = null;
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
Articles, Total: <%=count %>
<div id="list">
	<%if(count == 0) {%>
		No articles
	<%} else {%>
	<table border="2" style="font-size: large; border-color: blue; border-collapse: collapse;">
		<tr>
			<td>No
			<td>Subject
			<td>Email
			<td>Read Count
		<%
		for(int i=0; i<list.size(); i++) {
			BoardDataBean article = list.get(i);
			int num = article.getNum();
			String subject = article.getSubject();
			String user = globalManager.GetUser(article.getUserNumber());
			int readCount = article.getReadCount();
	 	%>
	 	<tr>
	 		<td align="center"><%=num %>
	 		<td><a href ="../BulletinBoard/ViewingForm.jsp?num=<%=num %>"><%=subject %></a>
	 		<td><%=user %>
	 		<td align="center"><%=readCount %>
		<%} %>
	</table>
	<%} %>
	
<button id="write">글쓰기</button>
</div>