<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>
<head>
	<title> TITLE </title>
</head>
<body>
	<div id="mainForm">
	        <%String id="";
        	try{
        	id=(String)session.getAttribute("userEmail");
        	if(id==null||id.equals("")){        
        	%>
		<jsp:include page="LoginForm.jsp"></jsp:include>
	<% }else{ %>
		<jsp:include page="ManagementForm.jsp"></jsp:include>
	<%} }catch(Exception e){
		e.printStackTrace();
	}
	%>
	</div>
	
	result:
	<div id="result" ></div>
</body>
</html>