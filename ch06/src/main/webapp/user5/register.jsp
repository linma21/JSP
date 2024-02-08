<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>user5::register</title>
	</head>
	<body>
		<h3>user5 등록</h3>
		<a href="/ch06/WEB-INF/1.Jdbc.jsp">처음으로</a>
		<a href="/ch06/user5/list.jsp">목록보기</a>
		
		<form action="/ch06/user5/registerProc.jsp" method="post">
			<table>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name"></td>
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
					<td><input type="number" name="age"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr"></td>
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