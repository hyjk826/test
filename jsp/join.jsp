<%@ page language = "java" contentType = "text/html" pageEncoding = "utf-8"%> 
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.util.Vector" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/join.css">
</head>
<body>
    <jsp:include page = "top.jsp"/>
    <form action="joinProc.jsp" method="post">
    <table class="main">
        <tr>
            <td colspan="4" class="sub">회원가입</td>
        </tr>       
        <tr>
            <td>아이디</td>
            <td colspan="2"><input type="text" class="input" name="id" id = "id"></td>
            <td><input type="button" value="중복확인" onclick="check()"></td>
        </tr>
        <tr>
            <td>패스워드</td>
            <td colspan="2"><input type="password" class="input" name="password1"></td>
        </tr>
        <tr>
            <td>패스워드 확인</td>
            <td colspan="2"><input type="password" class="input" name="password2"></td>
        </tr>
        <tr>
            <td>이름</td>
            <td colspan="2"><input type="text" class="input" name="name"></td>
        </tr>
        <tr>
            <td>부서</td>
            <td>
                <select name="department">
                    <option value="개발팀">개발팀</option>
                    <option value="재무팀">재무팀</option>
                    <option value="운영팀">운영팀</option>
                    <option value="교육팀">교육팀</option>
                </select>
            </td>
            <td>직책</td>
            <td>
                <select name="position">
                    <option value="사원">사원</option>
                    <option value="부장">부장</option>
                    <option value="관리자">관리자</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="4">
            <input type="submit" value="회원 가입">
            <input type="reset" value="취소">
            </td>
        </tr>
    </table>
    </form>
    <script>
        function check(){
            var id = document.getElementById("id").value;
	        var flag = true;                
	        if(id=="") {            
	        	alert("아이디를 입력해주세요.");            
	        	return ;
            }
 	        if(flag) alert("사용 가능한 아이디 입니다.");
	        else alert("중복된 아이디 입니다."); 
        }
    </script>
</body>
</html>