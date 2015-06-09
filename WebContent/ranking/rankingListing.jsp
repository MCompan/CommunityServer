<%@page import="java.util.ArrayList"%>
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


<script src="../js/jquery-2.1.3.min.js"></script>
<script>
   $(document).ready(function() {
      $("#commit").click(function() {
         var stage = $("#stage").val();
         var record = $("#record").val();
         var query = {
               stage : stage,
               record : record   
         }
         $.ajax({
         type : "post", 
         data : query,
         url : "../ranking/rankingProcess.jsp",
         success:function(data){

         }
         });
      });
   });
</script>

<%
   RankingProcessing manager = RankingProcessing.getInstance();
   Management globalManager = Management.getInstance();
   List<RankingDataBean> list = null;
   List<RankingDataBean> list1 = new ArrayList<RankingDataBean>();
   List<RankingDataBean> list2 = new ArrayList<RankingDataBean>();
   List<RankingDataBean> list3 = new ArrayList<RankingDataBean>();
   List<RankingDataBean> list4 = new ArrayList<RankingDataBean>();
   List<RankingDataBean> list5 = new ArrayList<RankingDataBean>();
   RankingDataBean temp = new RankingDataBean();

   list = manager.GetRanking();
   
   
   for(int i=0; i<list.size(); i++) {
      RankingDataBean article = list.get(i);
      temp = article;
      int stage = article.getStage();
      if(stage==1){
         list1.add(temp);
      }
      else if(stage==2){
         list2.add(temp);
      }
      else if(stage==3){
         list3.add(temp);
      }
      else if(stage==4){
         list4.add(temp);
      }
      else if(stage==5){
         list5.add(temp);
      }      
   }
    
%>
<%
	int r1=0;
	int r2=0;
	int r3=0;
	int r4=0;
	int r5=0;
	String id = "";
	id = (String)session.getAttribute("userEmail");
if(id==null||id.equals("")){
	
	}
else{
	List<RankingDataBean> listUser = manager.GetUserRanking(id);
	%><table>
  <tr>
    <td>Stage1</td>
    <td>Stage2</td>
    <td>Stage3</td>
    <td>Stage4</td>
    <td>Stage5</td>
  </tr>
  <%if(listUser!=null){ %>
  <tr>
  	<%for(int i=0;i<listUser.size();i++){
  		RankingDataBean temp1 = listUser.get(i);
  	
  		if(temp1.getStage()==1){
  			r1=temp1.getRecording();
	  	}
	  	else if(temp1.getStage()==1){
	  		r2=temp1.getRecording();
  		}
		else if(temp1.getStage()==1){
			r3=temp1.getRecording();
  		}
		else if(temp1.getStage()==1){
			r4=temp1.getRecording();
  		}
		else if(temp1.getStage()==1){
			r5=temp1.getRecording();
  		}
  	}
    %>
    <td><%=r1 %></td> 
    <td><%=r2 %></td>
    <td><%=r3 %></td>
    <td><%=r4 %></td>
    <td><%=r5 %></td>
    <%} %>
  </tr>
</table>
<%} %>

<table>
   <thead>
      <tr><th colspan ="2">1</th>
      <th colspan ="2">2</th>
      <th colspan ="2">3</th>
      <th colspan ="2">4</th>
      <th colspan ="2">5</th>
      </tr>
      <tr>
         <th>User</th>
         <th>Recording</th>
         <th>User</th>
         <th>Recording</th>
         <th>User</th>
         <th>Recording</th>
         <th>User</th>
         <th>Recording</th>
         <th>User</th>
         <th>Recording</th>
      </tr>
   </thead>
      <%
      for(int i=0; i<5; i++) {
    	  RankingDataBean article = null;
    	  int recording1 = 0;
    	  int recording2= 0;
    	  int recording3= 0;
    	  int recording4= 0;
    	  int recording5= 0;
    	  String user1= null;
    	  String user2= null;
    	  String user3= null;
    	  String user4= null;
    	  String user5= null;
    	 if(i<list1.size()){
         	article = list1.get(i);
         	user1 = globalManager.GetUser(article.getUserNumber());
         	recording1 = article.getRecording();
      	}
      if(i<list2.size()){
         article = list2.get(i);
         user2 = globalManager.GetUser(article.getUserNumber());
         recording2 = article.getRecording();
      }
      if(i<list3.size()){
         article = list3.get(i);
         user3 = globalManager.GetUser(article.getUserNumber());
         recording3 = article.getRecording();
      }
      if(i<list4.size()){
         article = list4.get(i);
         user4 = globalManager.GetUser(article.getUserNumber());
         recording4 = article.getRecording();
      }
      if(i<list5.size()){   
      	article = list5.get(i);
         user5 = globalManager.GetUser(article.getUserNumber());
         recording5 = article.getRecording();
      }
       %>
       <tr>
          <td><%if(i<list1.size())%><%=user1 %></td><td><%if(i<list1.size())%><%=recording1 %></td>
         <td><%if(i<list2.size())%><%=user2 %></td><td><%if(i<list2.size())%><%=recording2 %></td>
         <td><%if(i<list3.size())%><%=user3 %></td><td><%if(i<list3.size())%><%=recording3 %></td>
         <td><%if(i<list4.size())%><%=user4 %></td><td><%if(i<list4.size())%><%=recording4 %></td>
         <td><%if(i<list5.size())%><%=user5 %></td><td><%if(i<list5.size())%><%=recording5 %></td>
       </tr>
       <%} %>
</table>
<p/>

<input type="text" id="stage">
<input type="text" id="record">
<button id = "commit">commit</button>