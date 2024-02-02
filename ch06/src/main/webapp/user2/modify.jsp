<%@page import="java.sql.DriverManager"%>
<%@page import="dto.User2DTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String uid = request.getParameter("uid");
	User2DTO dto = null;
	
	try{
        Context initCtx = new InitialContext();
        Context ctx = (Context) initCtx.lookup("java:comp/env");

        DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
        Connection conn = ds.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `User2` WHERE `uid`=?");
		psmt.setString(1, uid);
		
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			dto= new User2DTO();
		dto.setUid(rs.getString(1));
		dto.setName(rs.getString(2));
		dto.setBirth(rs.getString(3));
		dto.setAddr(rs.getString(4));
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
		<title>Insert title here</title>
	</head>
	<body>
		<h3>user2 수정</h3>
		<a href="../1.Jdbc.jsp">처음으로</a>
		<a href="./list.jsp">목록보기</a>
		
		<form action="./modifyProc.jsp" method="post">
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
					<td>생년월일</td>
					<td><input type="date" name="birth" value="<%=dto.getBirth()%>"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="<%=dto.getAddr()%>"></td>
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