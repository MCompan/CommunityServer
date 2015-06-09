<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@page import="javafx.scene.control.Alert"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0"/>

<% request.setCharacterEncoding("utf-8"); %>
<%
String encType = "utf-8"; //인코딩타입
int maxSize = 5*1024*1024;  //최대 업로될 파일크기 5Mb

try{
	MultipartRequest upload = null;
	   
	upload = new MultipartRequest(request,"C:/Workspace/CommunityServer/WebContent/Ghost",maxSize,
			"utf-8",new DefaultFileRenamePolicy());
	
    String originalFileName = upload.getOriginalFileName("file");
    File originalFile = new File("C:/Workspace/CommunityServer/WebContent/Ghost/"+ originalFileName);
	String fileName = upload.getFilesystemName("file");
    File file = upload.getFile("file");
    String a = originalFileName;
    String b = fileName;
	if(originalFileName.contains(".ghost")) {
		if(!a.equals(b)) {
			originalFile.delete();
			file.renameTo(originalFile);
		}
	} else {
		file.delete();
		out.println("is not ghost file\n");
	}
}catch(Exception e){
	e.printStackTrace();
}

response.sendRedirect("../Main/Main.jsp");
%>