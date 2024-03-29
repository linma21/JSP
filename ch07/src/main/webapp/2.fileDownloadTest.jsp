<%@page import="java.util.ArrayList"%>
<%@page import="ch07.dto.FileDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<FileDTO> files = new ArrayList<>();

	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `fileTest`");
		
		while(rs.next()){
			FileDTO file = new FileDTO();
			file.setFno(rs.getInt(1));
			file.setTitle(rs.getString(2));
			file.setoName(rs.getString(3));
			file.setsName(rs.getString(4));
			file.setRdate(rs.getString(5));
			
			files.add(file);
		}
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>FileDownload</title>
	</head>
	<body>
		<h3>FileDownload Page</h3>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>원본파일명</th>
				<th>저장파일명</th>
				<th>날짜</th>
				<th>관리</th>
			</tr>
			<% for(FileDTO file : files) { %>
			<tr>
				<td><%= file.getFno() %></td>
				<td><%= file.getTitle() %></td>
				<td><%= file.getoName() %></td>
				<td><%= file.getsName() %></td>
				<td><%= file.getRdate() %></td>
				<td>
				<a href="./proc/fileDownloadProc.jsp?fno=<%= file.getFno() %>">다운로드</a>
				<a href="./proc/fileDelete.jsp?fno=<%= file.getFno() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>