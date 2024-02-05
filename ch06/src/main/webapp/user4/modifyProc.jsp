<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String uid  = request.getParameter("uid");
	String name  = request.getParameter("name");
	String gender  = request.getParameter("gender");
	String age  = request.getParameter("age");
	String hp  = request.getParameter("hp");
	String addr  = request.getParameter("addr");
	
	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		String sql = "UPDATE `User4` SET ";
				sql += "`name` = ?, ";
				sql += "`gender` = ?, ";
				sql += "`age` = ?, ";
				sql += "`hp` = ?, ";
				sql += "`addr` = ? ";
				sql += "WHERE `uid` = ?";
		
				PreparedStatement psmt = conn.prepareStatement(sql);
				psmt.setString(1, name);
				psmt.setString(2, gender);
				psmt.setString(3, age);
				psmt.setString(4, hp);
				psmt.setString(5, addr);
				psmt.setString(6, uid);
				psmt.executeUpdate();
				
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("/ch06/user4/list.jsp");
	
%>