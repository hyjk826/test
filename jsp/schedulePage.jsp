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
    <link rel="stylesheet" href="../css/schedule.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <%
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
        String id2 = (String)session.getAttribute("id");
        sql = "SELECT * FROM schedule where id = ? and year = ? and month = ?";
        pstmt = connect.prepareStatement(sql);
        pstmt.setString(1, id2);
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
    <div id = "menu" class="side">
        <a href="" class="closebtn" onclick="closeSide()">&times;</a>
        <%for(int i = 0; i < vec.size(); ++i){%>
            <a href='otherNameModule.jsp?otherName=<%=vec.get(i)%>'><%=vec.get(i)%></a>
        <%}%>
    </div>
    <div class="m">
    <div class="schedule">
        <div class="openbtn">
            <i class="fa fa-bars" onclick="openSide()"></i>
        </div>
        <div class="main">
            <h2><%=year%>년</h2>
            <div class="month">
                <input type="button" value="&lt;" onclick="location.href='beforeMonthModule.jsp'">
                <p><%=month%>월</p><input type="button" value="&gt;" onclick="location.href='afterMonthModule.jsp'">
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
            <div class="button">
                <input type="button" value="수정" onclick="location.href='scheduleModifyPage.jsp'" class="modify"> 
                <input type="button" value="삭제" onclick="location.href='scheduleDeletePage.jsp'" class="delete">
            </div>
        </div>
    </div>
    <form action="scheduleAddmodule.jsp" method="post" name = "addForm">
    <div class="scheduleAdd">
            <input type="date" name = "date">
            <input type="time" name = "time">
            <textarea name="content" cols="30" rows="10">
            </textarea>
            <input type="button" value="일정 추가하기" onclick = "addCheck()" class="addButton">
            <input type="reset" value = "취소">
    </div>
    </form>
    </div>
    <script>
        function openSide(){
            document.querySelector("#menu").style.width = "20%";
        }
        function closeSide(){
            document.querySelector("#menu").style.width = "0px";
        }
        function addCheck(){
            var form = document.addForm;
            if(form.date.value == ""){
                alert("날짜를 입력해주십시오");
                form.date.focus();
                return false;
            }
            else if(form.time.value == ""){
                alert("시간을 입력해주십시오");
                form.time.focus();
                return false;
            }
            else if(form.content.value.length == 0){
                alert("일정을 입력해주십시오");
                form.content.focus();
                return false;
            }
            form.submit();
        }
    </script>
</body>
</html>