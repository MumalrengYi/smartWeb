<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="pwChangeOk.em" name="frm" method="post">
	비밀번호 : <input type="password" name="empPw" />
    <span>${pwFail }</span><br />
    <input type="submit" value="확인" />
</form>
</body>
</html>