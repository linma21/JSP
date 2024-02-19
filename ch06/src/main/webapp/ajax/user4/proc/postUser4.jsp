<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="dto.User4DTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	BufferedReader reader = request.getReader();
	StringBuilder requestBody = new StringBuilder();
	String line;
	
	while((line = reader.readLine()) != null){
		requestBody.append(line);
	}
	reader.close();
	
	Gson gson = new Gson();
	User4DTO user4 = gson.fromJson(requestBody.toString(), User4DTO.class);
	
	System.out.println(user4);

	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		String sql = "INSERT INTO `User4` VALUES (?,?,?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, user4.getUid());
		psmt.setString(2, user4.getName());
		psmt.setString(3, user4.getGender());
		psmt.setInt(4, user4.getAge());
		psmt.setString(5, user4.getHp());
		psmt.setString(6, user4.getAddr());
		
		int result = psmt.executeUpdate();
		
		psmt.close();
		conn.close();
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		out.print(json.toString());
	}catch(Exception e){
		e.printStackTrace();
	}
%>