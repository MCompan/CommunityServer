<%@page import="com.sun.org.apache.xml.internal.resolver.helpers.Debug"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import = "MemberManagement.MemberManagementProcessing" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="member" class="MemberManagement.MemberDataBean">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
	String type = request.getParameter("type");
	if(type.equals("registration")) {
		MemberManagementProcessing manager = MemberManagementProcessing.getInstance();
		
		member.setUserNumber(-1);
		int state = -1;
		//state = manager.Registration(member);
		
		out.println(state);
	}
	else if(type.equals("login")) {
		MemberManagementProcessing manager = MemberManagementProcessing.getInstance();
		
		int state = -1;
		//state = manager.Login(member);
		
		if(request.getParameter("userEmail").equals("admin") &&
			request.getParameter("userPassword").equals("123")) {
			state = 2;
		}
		if(state == 1) {
			session.setAttribute("userEmail", request.getParameter("userEmail"));
			
			Cookie emailCookie = new Cookie("userEmail", request.getParameter("userEmail"));
			emailCookie.setMaxAge(60*10);
			Cookie passwordCookie = new Cookie("userPassword", request.getParameter("userPassword"));
			passwordCookie.setMaxAge(60*10);
			response.addCookie(emailCookie);
			response.addCookie(passwordCookie);
		}
		
		out.println(state);
	}
	else if(type.equals("changeEmail")) {
		MemberManagementProcessing manager = MemberManagementProcessing.getInstance();
		
		member.setUserEmail(session.getAttribute("userEmail").toString());
		int state = -1;
		//state = manager.ChangeEmail(member, request.getParameter("newEmail"));
		
		out.println(state);
	}
	else if(type.equals("withdrawal")) {
		MemberManagementProcessing manager = MemberManagementProcessing.getInstance();

		member.setUserEmail(session.getAttribute("userEmail").toString());
		int state = -1;
		//state = manager.Withdrawal(member);
		
		out.println(state);
	}
	else if(type.equals("logout")) {
		int state = 1;
		
		session.invalidate();
		
		out.println(state);
	}
%>