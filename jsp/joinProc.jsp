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
    String id = request.getParameter("id");
    String password1 = request.getParameter("password1");
    String password2= request.getParameter("password2");
    String name = request.getParameter("name");
    String department = request.getParameter("department");
    String position = request.getParameter("position");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "stageus", "1234");
    PreparedStatement pstmt;
    ResultSet rs;
    String sql;
    sql = "SELECT id FROM memberInfo where id = ?";
    pstmt = connect.prepareStatement(sql);
    pstmt.setString(1, id);
    rs = pstmt.executeQuery();
    Boolean flag = false;
    if(rs.next()){
        flag = true;
    }
    if(flag == true){
%>  
        <script>
            alert("아이디 중복입니다!!");
            history.go(-1);
        </script>
<%
    }
    else{
        if(!password1.equals(password2)){
%>
            <script>
                alert("비밀번호가 같지 않습니다!");
                history.go(-1);
            </script>
<%
        }
        else{
            sql = "INSERT INTO memberInfo VALUES (?, ?, ?, ?, ?)";
            pstmt = connect.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, password1);
            pstmt.setString(3, name);
            pstmt.setString(4, department);
            pstmt.setString(5, position);
            pstmt.executeUpdate();
            session.setAttribute("id", id);
            session.setAttribute("name", name);
            session.setAttribute("department", department);
            session.setAttribute("position", position);
            LocalDate now = LocalDate.now(); 
            int year = now.getYear();
            int month = now.getMonth().getValue();
            session.setAttribute("year", Integer.toString(year));
            session.setAttribute("month", Integer.toString(month));
            response.sendRedirect("schedule.jsp");
        }
    }
%>
</body>
