<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String uid = request.getParameter("uid");
	int result = 0;
	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		// 2단계 - connection 풀 객체 생성
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement("DELETE FROM `User4` WHERE `uid`=?");
		psmt.setString(1, uid);
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());
%>