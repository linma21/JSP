<%@page import="dto.User4DTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<User4DTO> users = new ArrayList<>();
	
	
	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		
		Connection conn = ds.getConnection();
		
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM `User4`");
		
		while(rs.next()){
			User4DTO dto = new User4DTO();
			dto.setUid(rs.getString(1));
			dto.setName(rs.getString(2));
			dto.setGender(rs.getString(3));
			dto.setAge(rs.getInt(4));
			dto.setHp(rs.getString(5));
			dto.setAddr(rs.getString(6));
			
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
		<title>User4 :: list</title>
	</head>
	<body>
		<h3>list</h3>
		<a href="/ch06/webapp/1.Jdbc.jsp">처음으로</a>
		<a href="/ch06/user4/register.jsp">등록하기</a>
		<table border="1">
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>생년월일</td>
				<td>휴대폰번호</td>
				<td>주소</td>
				<td>관리</td>
			</tr>
			<% for(User4DTO dto : users) {%>
			<tr>
				<td><%= dto.getUid() %></td>
				<td><%= dto.getName() %></td>
				<td><%= dto.getGender() %></td>
				<td><%= dto.getAge() %></td>
				<td><%= dto.getHp() %></td>
				<td><%= dto.getAddr() %></td>
				<td>
					<a href="/ch06/user4/modify.jsp?uid=<%= dto.getUid()%>">수정</a>
					<a href="/ch06/user4/delete.jsp?uid=<%= dto.getUid()%>">삭제</a>
				</td>
				<%} %>
			</tr>
		</table>
	</body>
</html>