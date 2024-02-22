<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>user5::list</title>
	</head>
	<body>
		<h3>list</h3>
		<a href="/ch10/index.jsp">처음으로</a>
		<a href="/ch10/user5/register.do">등록하기</a>
		<table border="1">
			<tr>
				<td>번호</td>
				<td>이름</td>
				<td>성별</td>
				<td>나이</td>
				<td>주소</td>
				<td>관리</td>
			</tr>
			<c:forEach var="user" items="${users}">
				<tr>
					<td>${user.seq}</td>
					<td>${user.name}</td>
					<td>${user.gender}</td>
					<td>${user.age}</td>
					<td>${user.addr}</td>
					<td>
						<a href="/ch10/user5/modify.do?seq=${user.seq}">수정</a>
						<a href="/ch10/user5/delete.do?seq=${user.seq}">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</body>
</html>