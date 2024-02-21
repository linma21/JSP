<%@page import="com.google.gson.Gson"%>
<%@page import="dto.User5DTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String seq = request.getParameter("seq");
	User5DTO user5 = null;
	
	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		
		// 2단계 - connection 풀 객체 생성
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
	
		PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `User5` WHERE `seq`=?");
		psmt.setString(1, seq);
		
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			user5 = new User5DTO();
			user5.setSeq(rs.getInt(1));
			user5.setName(rs.getString(2));
			user5.setGender(rs.getString(3));
			user5.setAge(rs.getInt(4));
			user5.setAddr(rs.getString(5));
		}
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	Gson gson = new Gson();
	String strJson = gson.toJson(user5);
	out.print(strJson);
%>