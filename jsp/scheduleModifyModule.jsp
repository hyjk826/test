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
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "stageus", "1234");
        PreparedStatement pstmt;
        ResultSet rs;
        String sql;
        String[] num = request.getParameterValues("modify");
        String[] content = request.getParameterValues("content");
        for(int i = 0; i < num.length; ++i){
            sql ="UPDATE schedule set content = ? where scheduleNum = ?";
            pstmt = connect.prepareStatement(sql);
            pstmt.setString(1, content[i]);
            pstmt.setString(2, num[i]);
            pstmt.executeUpdate();
        }
        response.sendRedirect("schedulePage.jsp");
    %>
</body>
</html>