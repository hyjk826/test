<%@ page language = "java" contentType = "text/html" pageEncoding = "utf-8"%> 
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.util.ArrayList" %>;
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String content = request.getParameter("content");
        String year = date.substring(0, 4);
        String month = date.substring(5, 7);
        if(month.charAt(0) == '0'){
            month = month.substring(1);
        }
        String day = date.substring(8, 10);
        if(day.charAt(0) == '0'){
            day = day.substring(1);
        }
        String hour = time.substring(0, 2);
        String minute = time.substring(3, 5);
        Class.forName("com.mysql.jdbc.Driver");
        String id = (String)session.getAttribute("id");
        String name = (String)session.getAttribute("name");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "stageus", "1234");
        PreparedStatement pstmt;
        ResultSet rs;
        String sql;
        sql = "INSERT INTO schedule (id, name, year, month, day, hour, minute, content) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = connect.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, name);
        pstmt.setString(3, year);
        pstmt.setString(4, month);
        pstmt.setString(5, day);
        pstmt.setString(6, hour);
        pstmt.setString(7, minute);
        pstmt.setString(8, content);
        pstmt.executeUpdate();
        response.sendRedirect("schedulePage.jsp");
    %>
</body>
</html>