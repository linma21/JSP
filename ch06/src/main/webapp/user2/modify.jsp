<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	
	String uid = request.getParameter("uid");

	try{
		Context initCtw = new InitialContext();
		Context ctx = (Context) initCtw.lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("jbdc/studydb");
		Connection conn = ds.getConnection();
		
		String sql = "UPDATE `User2` SET "+ 
									"`name`=?, ";
		PreparedStatement psmt = conn.prepareStatement(sql);
	}catch(Exception e){
		
	}
	
%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		
	</body>
</html>