<%@ page language = "java" contentType = "text/html" pageEncoding = "utf-8"%> 
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.time.LocalDate" %>
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
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String save = request.getParameter("save");
    sql = "SELECT password, name, department, position FROM memberInfo where id = ?";
    pstmt = connect.prepareStatement(sql);
    pstmt.setString(1, id);
    Boolean flag = false;
    String dbPassword = null;
    String name = null;
    String department = null;
    String position = null;
    rs = pstmt.executeQuery();
    while(rs.next()){
        flag = true;
        dbPassword = rs.getString(1);
        name = rs.getString(2);
        department = rs.getString(3);
        position = rs.getString(4);
    }
    if(!flag || !dbPassword.equals(password)){
%>
    <script>
        alert("아이디 또는 비밀번호가 맞지 않습니다!");
        history.go(-1);
    </script>
<%
    }
    else{
        session.setAttribute("id", id);
        session.setAttribute("name", name);
        session.setAttribute("department", department);
        session.setAttribute("position", position);
        LocalDate now = LocalDate.now(); 
        int year = now.getYear();
        int month = now.getMonth().getValue();
        session.setAttribute("year", Integer.toString(year));
        session.setAttribute("month", Integer.toString(month));
        response.sendRedirect("../jsp/schedule.jsp");
    }
%>
</body>
