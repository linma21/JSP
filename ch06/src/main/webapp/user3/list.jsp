<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.User3DTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<User3DTO> users = new ArrayList<>();
	
	
	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		
		Connection conn = ds.getConnection();
		
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM `User3`");
		
		while(rs.next()){
			User3DTO dto = new User3DTO();
			dto.setUid(rs.getString(1));
			dto.setName(rs.getString(2));
			dto.setBirth(rs.getString(3));
			dto.setHp(rs.getString(4));
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
		<title>User3 :: list</title>
	</head>
	<body>
		<h3>list</h3>
		<a href="/ch06/webapp/1.Jdbc.jsp">처음으로</a>
		<a href="/ch06/user3/register.jsp">등록하기</a>
		<table border="1">
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>생년월일</td>
				<td>휴대폰번호</td>
				<td>주소</td>
				<td>관리</td>
			</tr>
			<% for(User3DTO dto : users) {%>
			<tr>
				<td><%= dto.getUid() %></td>
				<td><%= dto.getName() %></td>
				<td><%= dto.getBirth() %></td>
				<td><%= dto.getHp() %></td>
				<td><%= dto.getAddr() %></td>
				<td>
					<a href="/ch06/user3/modify.jsp?uid=<%= dto.getUid()%>">수정</a>
					<a href="/ch06/user3/delete.jsp?uid=<%= dto.getUid()%>">삭제</a>
				</td>
				<%} %>
			</tr>
		</table>
	</body>
</html>