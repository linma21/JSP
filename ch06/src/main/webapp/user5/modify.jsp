<%@page import="dto.User5DTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String seq = request.getParameter("seq");
	User5DTO user = null;
	try{
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `User5` WHERE `seq`=?");
		psmt.setString(1, seq);
		
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			user = new User5DTO();
			user.setSeq(rs.getInt(1));
			out.println(rs.getInt(1));
			user.setName(rs.getString(2));
			user.setGender(rs.getString(3));
			user.setAge(rs.getInt(4));
			user.setAddr(rs.getString(5));
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
		<title>user5::modify</title>
	</head>
	<body>
		<h3>user5 수정</h3>
		<a href="/ch06/WEB-INF/1.Jdbc.jsp">처음으로</a>
		<a href="/ch06/user5/list.jsp">목록보기</a>
		
		<form action="/ch06/user5/modifyProc.jsp" method="post">
			<table>
				<tr>
					<td>사용자번호</td>
					<td><input type="number" name="seq" readonly value="<%=user.getSeq()%>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=user.getName() %>"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<select name="gender">
							<option value="M">남성</option>						
							<option value="F">여성</option>						
						</select>
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" name="age" value="<%=user.getAge() %>"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="<%=user.getAddr() %>"></td>
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