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
	request.setCharacterEncoding("UTF-8");
	
	List<User5DTO> users = new ArrayList<>();

	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM `User5`");
		
		while(rs.next()){
			User5DTO dto = new User5DTO();
			dto.setSeq(rs.getInt(1));
			dto.setName(rs.getString(2));
			dto.setGender(rs.getString(3));
			dto.setAge(rs.getInt(4));
			dto.setAddr(rs.getString(5));
			
			users.add(dto);
		}
		rs.close();
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>user5::list</title>
	</head>
	<body>
		<h3>list</h3>
		<a href="/ch06/webapp/1.Jdbc.jsp">처음으로</a>
		<a href="/ch06/user5/register.jsp">등록하기</a>
		<table border="1">
			<tr>
				<td>번호</td>
				<td>이름</td>
				<td>성별</td>
				<td>나이</td>
				<td>주소</td>
				<td>관리</td>
			</tr>
			<% for(User5DTO dto : users) {%>
			<tr>
				<td><%= dto.getSeq() %></td>
				<td><%= dto.getName() %></td>
				<td><%= dto.getGender() %></td>
				<td><%= dto.getAge() %></td>
				<td><%= dto.getAddr() %></td>
				<td>
					<a href="/ch06/user5/modify.jsp?seq=<%= dto.getSeq()%>">수정</a>
					<a href="/ch06/user5/delete.jsp?seq=<%= dto.getSeq()%>">삭제</a>
				</td>
			</tr>
			<%} %>
		</table>
	</body>
</html>