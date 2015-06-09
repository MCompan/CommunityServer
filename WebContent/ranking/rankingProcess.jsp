<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "Ranking.RankingDataBean" %>
<%@ page import = "Ranking.RankingProcessing" %>
<%@ page import = "Global.Management" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="data" class="Ranking.RankingDataBean">
	<jsp:setProperty name="data" property="*" />
</jsp:useBean>

<%
	RankingDataBean test = new RankingDataBean();
	RankingProcessing manager = RankingProcessing.getInstance();
	Management globalManager = Management.getInstance();
	String stage = request.getParameter("stage");
	String record = request.getParameter("record");
	String userEmail = null;
	try {
		userEmail = session.getAttribute("userEmail").toString();
	} catch(Exception e) { 
		e.printStackTrace();
	}
	//System.out.println(Integer.parseInt(request.getParameter("stage")));
	//System.out.println(Integer.parseInt(request.getParameter("record")));
	test.setStage(Integer.parseInt(request.getParameter("stage")));
	test.setRecording( Integer.parseInt(request.getParameter("record")));
	test.setUserNumber(globalManager.GetUser(userEmail));
	
	manager.SetRanking(test);
%>