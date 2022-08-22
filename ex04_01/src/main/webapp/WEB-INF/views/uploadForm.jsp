<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- enctype의 속성값을 반드시 정해야함, 최근 브라우저에서 multiple이라는 속성을 지원하는데 여러 개의 파일을 업로드할 수 있음-->
	<form action="uploadFormAction" method="post" enctype="multipart/form-data">
		<input type="file" name="uploadFile" multiple>
		<button>Submit</button>
	</form>
</body>
</html>