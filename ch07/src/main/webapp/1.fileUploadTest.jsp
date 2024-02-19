<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>1.FileUpload</title>
		<!-- 
		 	날짜 : 24/02/19
		 	이름 : 최이진
		 	내용 : JSP 파일 업로드 실섭
		 -->
	</head>
	<body>
		<h3>FileUpload</h3>
		<form action="./proc/fileUploadProc.jsp" method="post" enctype="multipart/form-data">
			<input type="text" name="title"><br>
			<input type="text" name="content"><br>
			<input type="file" name="file"><br>
			<input type="submit" value="전송">
		</form>
	</body>
</html>