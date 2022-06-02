<%@ page language = "java" contentType = "text/html" pageEncoding = "utf-8"%> 
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
        int year = Integer.parseInt((String)session.getAttribute("year"));
        int month = Integer.parseInt((String)session.getAttribute("month"));
        if(month < 12){
            month++;
            session.setAttribute("month", Integer.toString(month));
        }
        else{
            month = 1;
            year++;
            session.setAttribute("month", Integer.toString(month));
            session.setAttribute("year", Integer.toString(year));
        }
        response.sendRedirect("otherSchedule.jsp");
    %>
</body>
</html>