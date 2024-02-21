<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.User5DTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	List<User5DTO> users = new ArrayList<>();
	try{
		Context ctx =(Context) new InitialContext().lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `User5`");
		
		while(rs.next()){
			User5DTO user = new User5DTO();
			user.setSeq(rs.getInt(1));
			user.setName(rs.getString(2));
			user.setGender(rs.getString(3));
			user.setAge(rs.getInt(4));
			user.setAddr(rs.getString(5));
			
			users.add(user);
		}
		
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	Gson gson = new Gson();
	String strJson = gson.toJson(users);
	System.out.println(strJson);
	out.print(strJson);
	
%>