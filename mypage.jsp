<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "user.User" %>
<%@ page import= "user.UserUnity" %>
<%@ page import= "user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href ="css/bootstrap.css">
<title>게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		User user = new UserDAO().getUser(userID);
		UserDAO userdao = new UserDAO();
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
			<a class="navbar-brand"href="main.jsp">Wtrip</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="chat2.jsp">전체채팅</a></li>
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
						<li><a href="mypage.jsp"><%=userID %></a></li>
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
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">내정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<% if(userdao.GetImageFile(userID) != null) {%>
						<td><img src = "img/<%= userdao.GetImageFile(userID) %>" width = "128" height = "128"></td>
						<%}else{ %>
						<td>프로필 사진 없음</td>
						<% } %>
						<td>
							<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd"><tbody>
								<tr>
									<td style = "width: 20%;">아이디</td>
									<td><%=user.getUserID() %></td>
								</tr>
								<tr>
									<td>이름</td>
									<td><%=user.getUserName() %></td>
								</tr>
								<tr>
									<td>이메일</td>
									<td><%=user.getUserEmail() %></td>
								</tr>
								<tr>
									<td>게임 머니</td>
									<td><%=user.getUserGameMoney() %></td>
								</tr>
							</tbody></table>
						</td>
					</tr>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: left;">게임 플레이 기록</th>
					</tr>
					<tr>
						<td colspan = 2>
							<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th style="background-color: #eeeeee; text-align: center;">게임</th>
										<th style="background-color: #eeeeee; text-align: center;">플레이 날짜</th>
										<th style="background-color: #eeeeee; text-align: center;">게임결과</th>
									</tr>
								</thead>
								<tbody>
									<%
										UserDAO userDAO = new UserDAO();
										ArrayList<UserUnity> list= userDAO.getUnityList(userID);
										for(int i =0;i<list.size(); i++){
											String gameName;
											if(list.get(i).getGameNum() == 1) gameName = "슈팅 게임";
											else if(list.get(i).getGameNum() == 2) gameName = "블럭깨기 게임";
											else gameName = "비행기 게임";
									%>
										<tr>
											<td><%= gameName%></td>
											<td><%= list.get(i).getResultTime().substring(0,11) %></td>
											<td><%= list.get(i).getGameResult() %></td>
											
										</tr>
									<%
										}
									%>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>

			<a href="main.jsp" class="btn btn-primary">메인 페이지</a>
			<a href="modifyProfile.jsp" class="btn btn-primary">정보 수정</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>