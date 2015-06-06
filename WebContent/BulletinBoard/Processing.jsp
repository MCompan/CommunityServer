<%@page import="BulletinBoard.BoardDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "BulletinBoard.BoardProcessing" %>
<%@ page import = "Global.Management"%>
<%@ page import = "java.util.List" %>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="data" class="BulletinBoard.BoardDataBean">
	<jsp:setProperty name="data" property="*" />
</jsp:useBean>

<%
	BoardProcessing manager = BoardProcessing.getInstance();
	Management globalManager = Management.getInstance();
	
	String type = request.getParameter("type");
	if(type.equals("writing")) {
		int state = -1;
		String userEmail = null;
		
		try {
			userEmail = session.getAttribute("userEmail").toString();
		} catch(Exception e) { 
			e.printStackTrace();
			state = -3;	//Need Login to write
		}
		data.setContent(request.getParameter("content"));
		data.setSubject(request.getParameter("subject"));
		data.setUserNumber(globalManager.GetUser(userEmail));
		
		state = manager.Write(data, 1);
		out.println(state);
	} else if(type.equals("modify")) {
		int state = -1;
		
		BoardDataBean original = manager.GetWriting(Integer.parseInt(request.getParameter("num")), false);

		data = original;

		data.setNum(Integer.parseInt(request.getParameter("num")));
		data.setContent(request.getParameter("content"));
		data.setSubject(request.getParameter("subject"));
		
		state = manager.Write(data, 2);
		out.println(state);
	} else if(type.equals("delete")) {
		int state = -1;
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		state = manager.DeleteWriting(num);
		
		out.println(state);
	}

%>