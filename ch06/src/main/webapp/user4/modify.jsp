<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="dto.User4DTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String uid = request.getParameter("uid");
	User4DTO dto = null;
	
	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `User4` WHERE `uid`=?");
		psmt.setString(1, uid);
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			dto = new User4DTO();
			dto.setUid(rs.getString(1));
			dto.setName(rs.getString(2));
			dto.setGender(rs.getString(3));
			dto.setAge(rs.getInt(4));
			dto.setHp(rs.getString(5));
			dto.setAddr(rs.getString(6));
		}
		rs.close();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}

%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>user4::modify</title>
	</head>
	<body>
				<h3>user4 수정</h3>
		<a href="/ch06/WEB-INF/1.Jdbc.jsp">처음으로</a>
		<a href="/ch06/user4/list.jsp">목록보기</a>
		
		<form action="/ch06/user4/modifyProc.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" readonly value="<%=dto.getUid()%>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=dto.getName()%>"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<select name="gender"  value="<%=dto.getGender()%>">
							<option value="M">남성</option>						
							<option value="F">여성</option>						
						</select>
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" name="age"  value="<%=dto.getAge()%>"></td>
				</tr>
				<tr>
					<td>휴대폰번호</td>
					<td><input type="text" name="hp"  value="<%=dto.getHp()%>"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="<%=dto.getAddr()%>"></td>
				</tr>
				<tr>
				<td colspan="2" align="right">
					<input type="submit" value="등록하기">
				</td>
			</tr>
			</table>
		</form>
	</body>
</html>