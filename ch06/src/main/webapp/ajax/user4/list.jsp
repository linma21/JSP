<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>User4::목록</title>
		<script>
			window.onload = function() {
				
				const table = document.getElementById('list');
				
				fetch('./proc/getUser4s.jsp')
					.then(response=>response.json())
					.then((data)=>{
						console.log(data);
						for(const user of data){
							const tr = document.createElement('tr');
							const td1 = document.createElement('td');
							const td2 = document.createElement('td');
							const td3 = document.createElement('td');
							const td4 = document.createElement('td');
							const td5 = document.createElement('td');
							const td6 = document.createElement('td');
							const td7 = document.createElement('td');
							
							const a1 = document.createElement('a');
							const a2 = document.createElement('a');
							
							td1.textContent = user.uid;
							td2.textContent = user.name;
							td3.textContent = user.gender;
							td4.textContent = user.age;
							td5.textContent = user.hp;
							td6.textContent = user.addr;
							
							a1.textContent = '수정';
							a1.href ='./modify.jsp?uid='+user.uid;
							a2.textContent = '삭제';
							a2.href ='./delete.jsp?uid='+user.uid;
							a2.onclick = function(e) {
								e.preventDefault();
								
								const parent = e.target.closest('tr');
								const url = this.href;
								const params = url.split('?')[1];
								const value = params.split('=')[1];
								
								fetch('./proc/deleteUser4.jsp?uid='+value)
									.then(response=>response.json())
									.then((data)=>{
										console.log(data);
										if(data.result > 0){
											alert('삭제 완료!');
											parent.remove();
										}
									})
									.catch((err)=>{console.log(err)});
							}
							
							td7.appendChild(a1);
							td7.appendChild(a2);
							
							tr.appendChild(td1);
							tr.appendChild(td2);
							tr.appendChild(td3);
							tr.appendChild(td4);
							tr.appendChild(td5);
							tr.appendChild(td6);
							tr.appendChild(td7);
							
							table.appendChild(tr);
						}
					})
					.catch((err)=>{console.log(err);});
			}
		</script>
	</head>
	<body>
		<h3>User4::목록</h3>
		<a href="../../3.ajax.jsp">처음으로</a>
		<a href="./register.jsp">등록하기</a>
		<table border="1" id="list">
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>성별</td>
				<td>나이</td>
				<td>휴대폰번호</td>
				<td>주소</td>
				<td>관리</td>
			</tr>
		</table>
	</body>
</html>