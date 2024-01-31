<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>1.forwardTag</title>
		<!-- 
			날짜 : 24/01/31
			이름 : 최이진
			내용 : JSP 액션태그 forward 실습
		 -->
	</head>
	<body>
		<h3>1.forward 액션태그</h3>
		
		<jsp:forward page="./proc/target.jsp"></jsp:forward>
		
		<%
		//	pageContext.forward("./proc/target.jsp");
		%>
		
	</body>
</html>