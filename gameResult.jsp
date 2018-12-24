<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="userUnity" class="user.UserUnity" scope="page"/>
<jsp:setProperty name="userUnity" property ="userID"/>
<jsp:setProperty name="userUnity" property ="gameScore"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href ="css/bootstrap.css">
<title>유니티 결과</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		int gameScore = 0;
		String get_userID = "";
		
		if(request.getParameter("get_userID") != null) {
			get_userID = request.getParameter("bbsID");
		}
		
		if(request.getParameter("gameScore") != null) {
			gameScore = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		UserDAO userDAO = new UserDAO();
		
		if(userUnity.getUserID().equals("asdf")){
			PrintWriter script = response.getWriter();
			script.println("send back Message!!");
		}
		
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
		//int result = userDAO.login(user.getUserID(), user.getUserPassword());
		/*PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력값은 : ' + userUnity.getGameScore())");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");*/
	
		
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand"href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){
					
			%>
			<ul class ="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class ="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a><%=userID %></a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%				
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게임 결과</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style = "width: 20%;">플레이어</td>
						<td colspan="2"><%= get_userID %></td>
					</tr>
					<tr>
						<td>점수</td>
						<td colspan ="2"><%= gameScore %></td>
					</tr>
				</tbody>
			</table>
			<a href="main.jsp" class="btn btn-primary">메인 화면으로</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>