<%@ page language = "java" contentType = "text/html" pageEncoding = "utf-8"%> 
<%@ page import = "javax.servlet.http.Cookie" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/header.css">
</head>
<body>
<%
    String name = (String)session.getAttribute("name");
%>
    <header>
        <a href="../jsp/schedulePage.jsp"><img src="../img/googlelogo_color_272x92dp.png" class = "homeImg"></a>
        <div>
            <%
                if(name == null){
            %>
                <input type="button" value="로그인" onclick="location.href = '../index.jsp'">
                <input type="button" value="회원가입" onclick="location.href = '../jsp/joinPage.jsp'">
            <%
                }
                else{
            %>
                <%= (String)session.getAttribute("name") %>님
                <input type="button" value="로그아웃" onclick="location.href = '../jsp/logoutModule.jsp'">
            <%
                }
            %>
        </div>
    </header>
</body>
</html>