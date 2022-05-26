<%@ page language = "java" contentType = "text/html" pageEncoding = "utf-8"%> 
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<%
    session.setAttribute("id", null);
    session.setAttribute("name", null);
    session.setAttribute("department", null);
    session.setAttribute("position", null);
    response.sendRedirect("../index.jsp");
%>
</body>
</html>