<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="dto.ProductDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String proNo = request.getParameter("proNo");
	ProductDTO dto = new ProductDTO();
	
	try{
		Context initCtx = new InitialContext();
		Context ctx = (Context) initCtx.lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("jdbc/shop");
		Connection conn = ds.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `Product` WHERE `proNo`=?");
		psmt.setString(1, proNo);
		
		ResultSet rs = psmt.executeQuery();

		
		if(rs.next()){
			dto.setProNo(rs.getInt(1));
			dto.setProdName(rs.getString(2));
			dto.setStock(rs.getInt(3));
			dto.setPrice(rs.getInt(4));
			dto.setCompany(rs.getString(5));
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
		<title>product::modify</title>
	</head>
	<body>
		<h3>product 수정</h3>
		
		<a href="../../2.DBCP.jsp">처음으로</a>
		<a href="./list.jsp">목록보기</a>
		<form action="/ch06/product/modifyProc.jsp" method="post">
		<table border="1">
			<tr>
				<td>제품번호</td>
				<td><input type="number" name="proNo" readonly value="<%=dto.getProNo()%>"></td>
			</tr>
			<tr>
				<td>제품이름</td>
				<td><input type="text" name="prodName" value="<%=dto.getProdName()%>"></td>
			</tr>
			<tr>
				<td>재고량</td>
				<td><input type="number" name="stock" value="<%=dto.getStock()%>"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="number" name="price" value="<%=dto.getPrice()%>"></td>
			</tr>
			<tr>
				<td>회사</td>
				<td><input type="text" name="company" value="<%=dto.getCompany()%>"></td>
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