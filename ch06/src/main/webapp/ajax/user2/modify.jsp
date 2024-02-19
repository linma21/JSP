<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>AJAX::User2</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script>
			window.onload = function() {
				
				// 사용자 등록
				const formUser2 = document.getElementsByTagName('form')[0];
				const btnSubmit = formUser2.submit;
				
				btnSubmit.onclick = (e)=>{
					e.preventDefault();
					
					const uid = formUser2.uid.value; 
					const name = formUser2.name.value; 
					const birth = formUser2.birth.value; 
					const addr = formUser2.addr.value;
					
					const jsonData = {
			 			"uid":uid,	
			 			"name":name,	
			 			"birth":birth,	
			 			"addr":addr,	
					};
					
					$.ajax({
						method : 'POST',
						url: './proc/putUser2.jsp',
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
				xhr.open('GET', './proc/getUser2.jsp?uid='+value);
				xhr.send();
				
				xhr.onreadystatechange = function() {
					if(xhr.readyState == XMLHttpRequest.DONE){
						if(xhr.status == 200){
							const resData = JSON.parse(xhr.responseText);
							console.log(resData);
							
							formUser2.uid.value		= resData.uid;
							formUser2.name.value	= resData.name;
							formUser2.birth.value	 = resData.birth;
							formUser2.addr.value	 = resData.addr;
							console.log(resData.uid);
						}else{
							console.log('요청실패...');
						}
					}
				}
			}
		</script>
	</head>
	
	<body>
		<h3>user2 수정</h3>
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
					<td>생년월일</td>
					<td><input type="date" name="birth"></td>
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