<%@page import="sub1.UserDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 자동 로그인 여부에 따라 로그인 처리
	Cookie[] cookies = request.getCookies();

	if(cookies != null) {
	for(Cookie cookie : cookies){
		
		if(cookie.getName().equals("cid")){
			String uid = cookie.getValue();
			
			// DB 처리
			
			// 사용자 생성
			UserDTO user = new UserDTO();
			user.setUid(uid);
			user.setName("홍길동");
			
			// 세션 기록
			session.setAttribute("sessUser", user);
			
			// 로그인 성공 페이지 이동
			response.sendRedirect("./proc/loginSuccess.jsp");
			return;
		}
	}
}
%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>2.Session</title>
		<!-- 
			날짜 : 24/02/01
			이름 : 최이진
			내용 : 세션 실습
		 -->
	</head>
	<body>
	 <h3>2.세션</h3>
		
		<form action="./proc/loginProc.jsp" method="post">
			<input type="text" name="uid"><br>
			<input type="text" name="pass"><br>
			<label><input type="checkbox" name="auto" value="1">자동로그인</label>
			<input type="submit" value="로그인"><br>
		</form>
	</body>
</html>