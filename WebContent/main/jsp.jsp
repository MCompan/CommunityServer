<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<title>title</title>
<link rel="stylesheet" type="text/css" href="reset.css" />
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
	<body>
	<div id="wrap">
		<div id="header">
			<ul id="nav">
				<li><label class="btn">Main</label></li>
				<li><label class="btn">Notice Board</label></li>
				<li><label class="btn">Ranking</label></li>
				<li><label class="btn">Information</label></li>
				
    			 <!--  <li><input type="button" value="Main" class="btn"></input></li>
      			<li><input type="button" value="Notice Board" class="btn"></input></li>
     			 <li><input type="button" value="Ranking" class="btn"></input></li>
      			<li><input type="button" value="My Information" class="btn"></input></li> -->
    		</ul>
     	</div>
     </div>
     <!-- 헤더 -->
    <div id="content">
    <div id="inner">
      <div class="left float-l">
        <div class="blog">
        
        </div>
        <div class="blog">
        
        </div>
      </div>
      <div class="right folat-r">
        <div id="top">
          <ul id="meun">
            <jsp:include page="Main.jsp" flush="false"/>
          </ul>
        </div>
      </div>
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