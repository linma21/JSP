<%@page import="dto.User5DTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	BufferedReader reader = request.getReader();
	StringBuilder requestBody = new StringBuilder();

	String line;
	int result =0;
	
	while((line = reader.readLine()) != null){
		requestBody.append(line);
	}
	reader.close();
	
	Gson gson = new Gson();
	User5DTO user5 = gson.fromJson(requestBody.toString(), User5DTO.class);
	
	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement("UPDATE `User5` SET `name`=?, "
																	+"`gender`=?, "
																	+"`age`=?, "
																	+"`addr`=? "
																	+" WHERE `seq`=?");
		
		psmt.setString(1, user5.getName());
		psmt.setString(2, user5.getGender());
		psmt.setInt(3, user5.getAge());
		psmt.setString(4, user5.getAddr());
		psmt.setInt(5, user5.getSeq());
		result = psmt.executeUpdate();
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());
%>