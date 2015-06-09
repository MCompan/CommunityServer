<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<script src="../js/jquery-2.1.3.mis.js"></script>
<script src="../js/jquery.form.mis.js"></script>

<form id="upForm1" action="../Ghost/UploadProcessing.jsp" method="post" enctype="multipart/form-data">
<ul>
	<li>
		<label>Stage: </label>
		<select name="stage" <%if(session.getAttribute("userNumber")==null) {%> disabled="disabled" <%} %>>
    		<option value="" selected="selected">Stages</option>
    		<option value="1">1</option>
    		<option value="2">2</option>
    		<option value="3">3</option>
    		<option value="4">4</option>
    		<option value="5">5</option>
		</select>
	<li>
		<label>Ghost: </label>
		<input type="file" id="file" name="file" <%if(session.getAttribute("userNumber")==null) {%> disabled="disabled" <%} %>>
	<li>
		<input type="submit" id="up" value="Upload" <%if(session.getAttribute("userNumber")==null) {%> disabled="disabled" <%} %>>
</ul>
</form>
<div id="result"></div>
