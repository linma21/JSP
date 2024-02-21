<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//String success = request.getParameter("success");
	String sessUid = (String)session.getAttribute("sessUid");
%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>3.Listener Test</title>
		<!-- 
			날짜 : 24/02/21
			이름 : 최이진
			내용 : 리스너 실습
		 -->
	</head>
	<body>
		<h3>Listener</h3>
		<% if(sessUid == null){ %>
		<form action="/ch09/login.do" method="post">
			<input type="text" name="uid"><br>
			<input type="password" name="pass"><br>
			<input type="submit" value="전송"><br>
		</form>
		<% }else { %>
			<p>
				<%= sessUid %>님 반갑습니다.
			</p>
			<a href="/ch09/logout.do">로그아웃</a>
		<% } %>
	</body>
</html>