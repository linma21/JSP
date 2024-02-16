<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="dto.User1DTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// request Body JSON 문자열 스트림 처리
	request.setCharacterEncoding("UTF-8");
	BufferedReader reader = request.getReader();
	StringBuilder requestBody = new StringBuilder();
	String line;
	while((line = reader.readLine()) != null){
		requestBody.append(line);
	}
	reader.close();
	
	// JSON 파싱
	Gson gson = new Gson();
	User1DTO user1 = gson.fromJson(requestBody.toString(), User1DTO.class);
	
	System.out.println(user1);
	
	// 데이터베이스 처리
	
	try{
		// 1단계 - JNDI 서비스 객체 생성
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		// 2단계 - connection 풀 객체 생성
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		String sql = "INSERT INTO `User1` VALUES (?,?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, user1.getUid());
		psmt.setString(2, user1.getName());
		psmt.setString(3, user1.getBirth());
		psmt.setString(4, user1.getHp());
		psmt.setInt(5, user1.getAge());
		
		// executeUpdate는 row count 반환
		int result = psmt.executeUpdate();
		System.out.println("result : "+result);
		psmt.close();
		conn.close();
		
		// JSON 출력
		JsonObject json = new JsonObject();
		json.addProperty("result", result);		
		out.print(json.toString());
		
	}catch(Exception e){
		e.printStackTrace();
	}

%>