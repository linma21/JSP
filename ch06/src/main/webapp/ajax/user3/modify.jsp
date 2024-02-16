<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>AJAX::User3</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script>
			window.onload = function() {
				
				const formUser3 = document.getElementsByTagName('form')[0];
				const btnSubmit = formUser3.submit;
				
				btnSubmit.onclick= (e)=>{
					e.preventDefault();
					
					const uid	 = formUser3.uid.value;
					const name	 = formUser3.name.value;
					const birth	 = formUser3.birth.value;
					const hp	 = formUser3.hp.value;
					const addr	 = formUser3.addr.value;
					
					const jsonData = {
				 		"uid"	:uid,	
				 		"name"	:name,	
				 		"birth"	:birth,	
				 		"hp"	:hp,	
				 		"addr"	:addr	
					};
					
					$.ajax({
						method : 'POST',
						url: './proc/putUser3.jsp',
						data: jsonData,
						success: function(data) {
							console.log(data);
							if(data.result > 0){
								alert('수정 완료!');
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
				xhr.open('GET', './proc/getUser3.jsp?uid='+value);
				xhr.send();
				
				xhr.onreadystatechange = function() {
					if(xhr.readyState == XMLHttpRequest.DONE){
						if(xhr.status == 200){
							const resData = JSON.parse(xhr.responseText);
							console.log(resData);
							
							formUser3.uid.value		=resData.uid;
							formUser3.name.value	=resData.name;
							formUser3.birth.value	=resData.birth;
							formUser3.hp.value		=resData.hp;
							formUser3.addr.value	=resData.addr;
						}else{
							console.log('요청실패...');
						}
					}
				}
			}	
		</script>
	</head>
	<body>
		<h3>User3 수정</h3>
		<a href="/ch06/WEB-INF/1.Jdbc.jsp">처음으로</a>
		<a href="./list.jsp">목록보기</a>
		
		<form action="#">
			<table border ="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" readonly></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="date" name="birth"></td>
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
					<input type="submit" name="submit" value="수정하기">
				</td>
			</tr>
			</table>
		</form>
	</body>
</html>