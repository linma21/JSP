<%@page import="dto.User1DTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String uid = request.getParameter("uid");  // list에서 parameter로 넘긴 데이터 수신
	// 수정 데이터 조회
	String host = "jdbc:mysql://127.0.0.1:3306/studydb";
	String user = "chlvldzmf";
	String pass = "abc1234";
	User1DTO dto = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection(host, user, pass);
		PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `User1` WHERE `uid` = ?");
		psmt.setString(1, uid);
		
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			dto = new User1DTO();
			dto.setUid(rs.getString(1));
			dto.setName(rs.getString(2));
			dto.setBirth(rs.getString(3));
			dto.setHp(rs.getString(4));
			dto.setAge(rs.getInt(5));
		}
		rs.close();
		psmt.close();
		conn.close();
		
	}catch(Exception e ){
		e.printStackTrace();
	}

%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>user::수정</title>
	</head>
	<body>
		<h3>user1 수정</h3>
		
		<a href="../1.Jdbc.jsp">처음으로</a>
		<a href="./list.jsp">목록보기</a>
		<form action="./modifyProc.jsp" method="post">
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="uid" readonly value="<%= dto.getUid()%>"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"  value="<%= dto.getName()%>"></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type="date" name="birth" value="<%= dto.getBirth() %>"></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="hp" value="<%= dto.getHp()%>"></td>
			</tr>
			<tr>
				<td>나이</td>
				<td><input type="number" name="age" value="<%= dto.getAge()%>"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정하기">
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>