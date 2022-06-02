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
    <link rel="stylesheet" href="../css/otherSchedulePage.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <%
        response.setContentType("text/html;charset=utf-8");
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "stageus", "1234");
        String year = (String)session.getAttribute("year");
        String month = (String)session.getAttribute("month");
        PreparedStatement pstmt;
        ResultSet rs;
        String sql;
        String position = (String)session.getAttribute("position");
        Vector<String> vec = new Vector<>();
        if(position.equals("관리자")){
            sql = "SELECT name FROM memberInfo where position = '부장' OR position = '사원'";
            pstmt = connect.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next()){
                vec.add(rs.getString(1));
            }
        }
        else if(position.equals("부장")){
            sql = "SELECT name FROM memberInfo where position = '사원'";
            pstmt = connect.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next()){
                vec.add(rs.getString(1));
            }
        }
        String name2 = (String)session.getAttribute("otherName");
        sql = "SELECT * FROM schedule where name = ? and year = ? and month = ?";
        pstmt = connect.prepareStatement(sql);
        pstmt.setString(1, name2);
        pstmt.setString(2, year);
        pstmt.setString(3, month);
        rs = pstmt.executeQuery();
        Vector<Vector<String> > schedule = new Vector<>();
        while(rs.next()){
            Vector<String> v = new Vector<>();
            v.add(rs.getString(1));
            v.add(rs.getString(2));
            v.add(rs.getString(3));
            v.add(rs.getString(4));
            v.add(rs.getString(5));
            v.add(rs.getString(6));
            v.add(rs.getString(7));
            v.add(rs.getString(8));
            v.add(rs.getString(9));
            schedule.add(v);
        }
        int[] ch = new int[32];
        for(int i = 1; i <= 31; ++i){
            for(int j = 0; j < schedule.size(); ++j){
                if(Integer.parseInt(schedule.get(j).get(5)) == i){
                    ch[i]++;
                }
            }
        }
    %>
    <%@ include file = "../jsp/header.jsp" %>
    <div class="m">
    <div id = "menu" class="side">
        <a href="" class="closebtn" onclick="closeSide()">&times;</a>
        <%for(int i = 0; i < vec.size(); ++i){%>
            <a href="otherNameModule.jsp?otherName=<%=vec.get(i)%>"><%=vec.get(i)%></a>
        <%}%>
    </div>
    <div class="schedule">
        <div class="openbtn">
            <i class="fa fa-bars" onclick="openSide()"></i>
        </div>
        <div class="main">
            <h2><%=year%>년</h2>
            <div class="month">
                <input type="button" value="&lt;" onclick="location.href='otherBeforeMonthModule.jsp'">
                <p><%=month%>월</p><input type="button" value="&gt;" onclick="location.href='otherAfterMonthModule.jsp'">
            </div>
            <%
                for(int i = 1; i <= 31; ++i){
                    if(ch[i] >= 1){%>
                        <div class="dayBox">
                            <div class="day">
                                <h1><%=i%></h1>
                            </div>    
                            <div class="content">
                                <%for(int j = 0; j < schedule.size(); ++j){
                                    String day = schedule.get(j).get(5);
                                    String hour = schedule.get(j).get(6);
                                    String minute = schedule.get(j).get(7);
                                    String content = schedule.get(j).get(8);
                                    if(Integer.parseInt(day) == i){%>
                                          <p><%=hour%>:<%=minute%>&nbsp;&nbsp;&nbsp;&nbsp;<%=content%></p>
                                    <%}
                                }%>
                            </div>   
                        </div>
                    <%}
                    
                }
            %>
        </div>
    </div>
    </div>
    <script>
        function openSide(){
            document.querySelector("#menu").style.width = "20%";
        }
        function closeSide(){
            document.querySelector("#menu").style.width = "0px";
        }
    </script>
</body>
</html>