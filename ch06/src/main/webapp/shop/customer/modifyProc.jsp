<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String custId=request.getParameter("custid");
	String name=request.getParameter("name");
	String hp=request.getParameter("hp");
	String addr=request.getParameter("addr");
	
	try{
			Context initContext = new InitialContext();
			Context ctx = (Context)initContext.lookup("java:comp/env");
			
			DataSource ds = (DataSource)ctx.lookup("jdbc/shop");
			Connection conn=ds.getConnection();
			
			String sql="update `customer` set `name`=?,`hp`=?,`addr`=? where `custid`=?";
			PreparedStatement psmt= conn.prepareStatement(sql);
			
			psmt.setString(1,name);
			psmt.setString(2,hp);
			psmt.setString(3,addr);
			psmt.setString(4,custId);
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
	}catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("./list.jsp");
%>