<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AJAX::User5</title>
    <script>
        window.onload = function() {
            // 페이지 로딩 시 실행되는 함수
            const formUser5 = document.getElementsByTagName('form')[0];
            const btnSubmit = formUser5.submit;

            const url = location.href;
            const params = url.split('?')[1];
            const value = params.split('=')[1];

            // 사용자 정보를 가져오는 AJAX 요청
            fetch('./proc/getUser5.jsp?seq='+value)
                .then(response => response.json())
                .then((data)=>{
                    console.log(data);

                    // 폼 필드에 데이터 채우기
                    formUser5.seq.value = data.seq;
                    formUser5.name.value = data.name;
                    formUser5.gender.value = data.gender;
                    formUser5.age.value = data.age;
                    formUser5.addr.value = data.addr;
                })
                .catch((err)=>{console.log(err);})

            // 수정 버튼 클릭 시 실행되는 함수
            btnSubmit.onclick = function(e) {
                e.preventDefault();

                const seq	 = formUser5.seq.value;
                const name	 = formUser5.name.value;
                const gender = formUser5.gender.value;
                const age	 = formUser5.age.value;
                const addr	 = formUser5.addr.value;

                console.log("seq : "+seq);

                const jsonData = {
                        "seq": seq,
                        "name": name,
                        "gender": gender,
                        "age": age,
                        "addr": addr
                };

                const strJson = JSON.stringify(jsonData);

                // 사용자 정보를 업데이트하는 AJAX 요청
                fetch('./proc/putUser5.jsp', {
                    method : 'POST',
                    headers : { 'Content-Type' : 'application/json'},
                    body : strJson
                })
                    .then(response=>response.json())
                    .then((data)=>{
                        console.log(data);
                        if(data.result > 0){
                            alert('수정 성공');
                            location.href = './list.jsp';
                        }else{
                            alert('수정 실패');
                        }
                    })
                    .catch((err)=>{console.log(err);})
            }
        }
    </script>
</head>
<body>
    <h3>user5 수정</h3>
    <a href="/ch06/WEB-INF/3.ajax.jsp">처음으로</a>
    <a href="./list.jsp">목록보기</a>
    
    <!-- 사용자 정보 입력 폼 -->
    <form action="#">
        <table border="1">
            <tr>
                <td>사용자번호</td>
                <td><input type="number" name="seq" readonly></td>
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
                <td>주소</td>
                <td><input type="text" name="addr"></td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <!-- 수정 버튼 -->
                    <input type="submit"  name="submit" value="수정하기">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
