<%@ page language = "java" contentType = "text/html" pageEncoding = "utf-8"%> 
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
        String id = request.getParameter("id");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "stageus", "1234");
        PreparedStatement pstmt;
        ResultSet rs;
        String sql;
        sql = "select count(*) cnt from memberInfo where id = ?";
        pstmt = connect.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
        int cnt = -1;
        while(rs.next()){
            cnt = rs.getInt("cnt");
        }
        if(cnt == 0){
            out.print("사용가능한 아이디입니다");
        }
        else{
            out.print("이미 사용중인 아이디입니다");
        }
    %>
</body>
</html>