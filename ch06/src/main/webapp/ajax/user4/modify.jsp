<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>AJAX:: USER4</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script>
			window.onload = function() {
				
				const formUser4 = document.getElementsByTagName('form')[0];
				const btnSubmit = formUser4.submit;
				
				btnSubmit.onclick = function(e) {
					e.preventDefault();
					
					const uid	 = formUser4.uid.value;
					const name	 = formUser4.name.value;
					const gender = formUser4.gender.value;
					const age	 = formUser4.age.value;
					const hp	 = formUser4.hp.value;
					const addr	 = formUser4.addr.value;
					
					console.log("uid : "+uid);
					
					const jsonData = {
							"uid" : uid,
							"name" : name,
							"gender" : gender,
							"age" : age,
							"hp" : hp,
							"addr" : addr	
					};
					
					$.ajax({
		 				method: 'POST',
		 				url: './proc/putUser4.jsp',
		 				data: jsonData,
		 				success: function(data) {
		 					
		 					console.log(data);
		 					
		 					if(data.result > 0){
		 						alert('수정완료!');
		 						location.href = './list.jsp';
		 					}
						}
					});
				}
				
				const url = location.href;
				
				const params = url.split('?')[1];				
				const value = params.split('=')[1];
				console.log(value);
				
				const xhr = new XMLHttpRequest();
		 		xhr.open('GET', './proc/getUser4.jsp?uid='+value);
		 		xhr.send();
		 		
		 		// 응답 처리
		 		xhr.onreadystatechange = function () {
					
		 			// 응답 완료
		 			if(xhr.readyState == XMLHttpRequest.DONE){
		 				
		 				// 요청 성공
		 				if(xhr.status == 200){
		 					const resData = JSON.parse(xhr.responseText);
		 					console.log(resData);
		 					
		 					formUser4.uid.value	 = resData.uid;
		 					formUser4.name.value	 = resData.name;
		 					formUser4.gender.value = resData.gender;
		 					formUser4.addr.value = resData.addr;
		 					formUser4.hp.value	 = resData.hp;
		 					formUser4.age.value	 = resData.age;
		 					
		 				}else{
		 					// 요청 실패
		 					console.log('요청 실패...');
		 				}
		 			}
				}
			}
		</script>
	</head>
	<body>
	<h3>user4 수정</h3>
		<a href="/ch06/WEB-INF/3.ajax.jsp">처음으로</a>
		<a href="./list.jsp">목록보기</a>
		
		<form action="#">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" readonly></td>
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