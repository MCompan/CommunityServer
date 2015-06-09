<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<title>Time to Travel</title>
<link rel="stylesheet" type="text/css" href="css/main.css" />

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
$(document).ready(function() {	
	$("#mainClick").click(function(){
		window.location.href = "Main.jsp";
	}); 
	$("#NoticeBoardClick").click(function(){
		$("#meun").load("../Notice/noticeForm.jsp");
	}); 
	$("#BulletinBoardClick").click(function(){
		$("#meun").load("../BulletinBoard/ListingForm.jsp");
	}); 
	$("#RankingClick").click(function(){
		$("#meun").load("../Ranking/rankingListing.jsp");
	}); 
	$("#ghost").click(function(){
		$("#meun").load("../Ghost/GhostForm.jsp");
	}); 
});
</script>
</head>

	<body>
	<div id="main_all">
	<div id="header">
		<div id="wrap">
			<div id="menu_wrapper">
				<ul id="nav">
					<li><label id="mainClick">Main</label></li>
					<li><label id="NoticeBoardClick">Notice Board</label></li>
					<li><label id="BulletinBoardClick">Bulletin Board</label></li>
					<li><label id="RankingClick">Ranking</label></li>
					<li><label id="ghost">Ghost</label></li>
				</ul>
			</div>
		</div>
	</div>
 	<br></br>
     <!-- 헤더 -->
          <ul id="meun">
          	<%
        	try{
        	String type = request.getParameter("type");
        	String number = request.getParameter("num");
        		if(type != null) {
	        		if(number != null){
        	%>
		        	<jsp:include page="../Notice/ViewNotice.jsp" >
		        		<jsp:param name="num" value = "<%=number %>"/>
		        	</jsp:include>
			<%
	        		}
	        	}
        		else if(number != null){
        	%>
		        	<jsp:include page="../BulletinBoard/ViewingForm.jsp" >
		        		<jsp:param name="num" value = "<%=number %>"/>
		        	</jsp:include>
        	<%
        		} else {
		        	String id = "";
					id=(String)session.getAttribute("userEmail");
					if(id==null||id.equals("")){      
			%>
						<jsp:include page="LoginForm.jsp"></jsp:include>
			<% 		}else{ %>
						<jsp:include page="ManagementForm.jsp"></jsp:include>
			<%		} 
		        }
        	}catch(Exception e){
        		e.printStackTrace();
        	}
        	%>
          </ul>
     
     
    
    
   <!-- 메인화면 -->
   <br></br>
   <hr></hr>
   <font color="grey" size="2">
   source: <a href="https://github.com/MCompan/CommunityServer">https://github.com/MCompan/CommunityServer</a>
   <br></br>
   Time To Travel
   </font>
  <!-- /footer -->
  </div>
</body>