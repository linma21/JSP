<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>메인</title>
	</head>
	<body>
		<%
			if (session.getAttribute("uid") == null){
				out.println("<a href='login.jsp'>로그인</a>");
		%>
		<%
			}else {
				String uid = (String)session.getAttribute("uid");
				out.println(uid + "님 반갑습니다.");
				out.println("<a href='logout.jsp'>로그아웃</a>");
			}
		%>
	</body>
</html>