<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "FriendsManagement.FriendsDataBean" %>
<%@ page import = "FriendsManagement.FriendsProcessing" %>
<%@ page import = "Global.Management" %>

<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<%
	FriendsProcessing manager = FriendsProcessing.getInstance();
	FriendsDataBean friend = null;
	
	List<String> friends = manager.GetFriends(1);
	
	//친구추가 (1:접속중인 유저(세션값이용), "123":추가할 유저)
	manager.AddFriend(1, "123");
	
	//친구삭제 (인자는 친구추가와 동일)
	manager.DeleteFriend(1, "123");
%>




<!-- 친구목록 리스팅 -->
<div id="list">
<table>
	<%
	for(int i=0; i<friends.size(); i++) {
		String fr = friends.get(i);
	%>
	<tr>
		<td> <%=fr %>
	<%
	}
	%>
</table>
</div>