<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>User4::list</title>
	</head>
	<body>
		<h3>User4 목록</h3>
		<a href="/ch10/index.jsp">처음으로</a>
		<a href="/ch10/user4/register.do">등록하기</a>
		<table border="1">
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>성별</td>
				<td>나이</td>
				<td>휴대폰번호</td>
				<td>주소</td>
				<td>관리</td>
			</tr>
			<c:forEach var="user" items="${users}" >
			<tr>
				<td>${user.uid}</td>
				<td>${user.name}</td>
				<td>${user.gender}</td>
				<td>${user.age}</td>
				<td>${user.hp}</td>
				<td>${user.addr}</td>
				<td>
					<a href="/ch10/user4/modify.do?uid=${user.uid}">수정</a>
					<a href="/ch10/user4/delete.do?uid=${user.uid}">삭제</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</body>
</html>