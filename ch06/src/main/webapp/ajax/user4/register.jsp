<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>User4::등록</title>
		<script>
			window.onload = function() {
				
				const formUser4 = document.getElementsByTagName('form')[0];
				const btnSubmit = formUser4.submit;
				
				btnSubmit.onclick = function(e) {
					e.preventDefault();
					
					const uid = formUser4.uid.value;
					const name = formUser4.name.value;
					const gender = formUser4.gender.value;
					const age = formUser4.age.value;
					const hp = formUser4.hp.value;
					const addr = formUser4.addr.value;
					
					const jsonData = {
							"uid" : uid,
							"name" : name,
							"gender" : gender,
							"age" : age,
							"hp" : hp,
							"addr" : addr
					};
					
					const strJson = JSON.stringify(jsonData);
					console.log('strJson : '+ strJson);
					
					fetch('./proc/postUser4.jsp', {
						method: 'POST',
						headers: {
							'Content-Type' : 'application/json'
						},
						body: strJson
					})
						.then(response => response.json())
						.then((data)=>{
							console.log('data : '+ data);
							if(data.result > 0){
								alert('등록 성공!');
								location.href = './list.jsp';
							}else{
								alert('등록 실패!');
							}
						})
						.catch((err)=>{console.log(err)});
				}
				
				
			}
		</script>
	</head>
	<body>
	<h3>user4 등록</h3>
		<a href="/ch06/WEB-INF/3.ajax.jsp">처음으로</a>
		<a href="./list.jsp">목록보기</a>
		
		<form action="#">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid"></td>
				</tr>
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
					<td>휴대폰번호</td>
					<td><input type="text" name="hp"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr"></td>
				</tr>
				<tr>
				<td colspan="2" align="right">
					<input type="submit" name="submit" value="등록하기">
				</td>
			</tr>
			</table>
		</form>
	</body>
</html>