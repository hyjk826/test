<%@ page language = "java" contentType = "text/html" pageEncoding = "utf-8"%> 
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <%@ include file = "jsp/header.jsp" %>
    <form action="jsp/loginModule.jsp" method="post">
    <table class="table">
        <tr>
            <td colspan="2" class="sub">로그인</td>
        </tr>
        <tr>
            <td>아이디</td>
            <td><input type="text" name = "id"></td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td><input type="password" name = "password"></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" class="submit" value = "로그인"></td>
        </tr>
    </table>
    </form>
</body>
</html>