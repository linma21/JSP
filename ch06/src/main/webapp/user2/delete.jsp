<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String uid = request.getParameter("uid");
	
	try{
		Context initCtx = new InitialContext();
		Context ctx = (Context) initCtx.lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement("DELETE `User2` WHERE `uid`=?");
		psmt.setString(1, uid);
		
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}

%>