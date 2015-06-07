<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<title>title</title>
<link rel="stylesheet" type="text/css" href="css/reset.css" />
<link rel="stylesheet" type="text/css" href="css/styleMain.css" />

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
$(document).ready(function() {
	$("#mainClick").click(function(){
		window.location.href = "jsp.jsp";
		
	}); 
	$("#BulletinBoardClick").click(function(){
		$("#meun").load("../BulletinBoard/ListingForm.jsp");
	}); 
	$("#RankingClick").click(function(){
		alert("test");
	}); 
	$("#information").click(function(){
		alert("test");
	}); 
});
</script>

</head> 
	<body>
	<div id="wrap">
		<div id="header">
			<ul id="nav">
				<li><label class="btn" id="mainClick">Main</label></li>
				<li><label class="btn" id="BulletinBoardClick">Bulletin Board</label></li>
				<li><label class="btn" id="RankingClick">Ranking</label></li>
				<li><label class="btn" id="information">Information</label></li>
				
    			 <!-- <li><input type="button" id="mainClick" value="Main" class="btn"></input></li>
      			<li><input type="button" value="Notice Board" class="btn"></input></li>
     			 <li><input type="button" value="Ranking" class="btn"></input></li>
      			<li><input type="button" value="My Information" class="btn"></input></li>  -->
    		</ul>
     	</div>
     </div>
     <!-- 헤더 -->
    <div id="content">
    <div id="inner">
      <div class="right folat-r">
        <div id="top">
          <ul id="meun">
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
				
          </ul>
        </div>
      </div>
      <jsp:include page="../Notice/noticeForm.jsp"></jsp:include>
    </div>
  </div>
     
     
    
    
   <!-- 메인화면 -->
   
   <div id="wrap">
     <div id="footer">
    <div id="ftlink"> <a href="#">Home</a> | <a href="#">About Us</a> | <a href="#">Production</a> | <a href="#">Submission</a> | <a href="#">Contact</a> </div>
    <p id="copyright">Time To Travel</p>
  </div>
  </div>
  <!-- /footer -->
</body>