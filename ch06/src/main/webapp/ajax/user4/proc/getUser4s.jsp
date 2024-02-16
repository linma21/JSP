<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.User4DTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<User4DTO> user4s = new ArrayList<>();

	try{
		Context ctx =(Context) new InitialContext().lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `User4`");
		
		while(rs.next()){
			User4DTO user = new User4DTO();
			user.setUid(rs.getString(1));
			user.setName(rs.getString(2));
			user.setGender(rs.getString(3));
			user.setAge(rs.getInt(4));
			user.setHp(rs.getString(5));
			user.setAddr(rs.getString(6));
			
			user4s.add(user);
		}
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	Gson gson = new Gson();
	String strJson = gson.toJson(user4s);
	System.out.println(strJson);
	out.print(strJson);

%>