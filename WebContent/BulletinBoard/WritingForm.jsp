<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<script src="../js/jquery-2.1.3.min.js"></script>
<script>
	$(document).ready(function() {
		$("#submit").click(function() {
			var subject = $("#subject").val();
			var content = $("#content").val();
			var query = {
					type:"writing",
					subject:subject,
					content:content
			};
			$.ajax({
				type:"post",
				url:"Processing.jsp",
				data:query,
				success:function(data) {
					if(data == -3) {
						$("#boardResult").text("Need to login");
					} else if(data == -2){
						$("#boardResult").text("Wrong Access");
					} else if(data == -1) {
						$("#boardResult").text("Fail to connect");
					} else if(data == 1) {
						$("#boardResult").text("Success to writing");
					}
				}
			});
			$("#boardForm").load("ListingForm.jsp");
		});
		$("#cancel").click(function() {
			$("#boardForm").load("ListingForm.jsp");
		});
	});
</script>

<table>
	<tr>
		<td>Subject
		<td><input type="text" id="subject">
	<tr>
		<td>Content
		<td width="50px"><textarea id="content" rows="10" cols="50"></textarea>
	<tr>
		<td><button id="submit">완료</button>
		<td><button id="cancel">취소</button>
</table>