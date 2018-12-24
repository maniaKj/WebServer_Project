<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.ItemPossession" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href ="css/bootstrap.css">
<title>게시판 웹사이트</title>
<style type = "text/css">
	a, a:hover{
		color: #000000;
		text-decotation: none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		User user = new UserDAO().getUser(userID);
		String itemPath = "Images/shop/";
		String item1 = "bar1", item2 = "bullet_item", item3 = "bullet_item2", item4 = "speedmeter";
		String png = ".png";
		
		ArrayList<ItemPossession> itemp = new UserDAO().getItemPossessionList(userID);
		for(int i =0;i<itemp.size(); i++){
			if(itemp.get(i).getItemNum() == 1) item1 = item1 + "_sold";
			else if(itemp.get(i).getItemNum() == 2) item2 = item2 + "_sold";
			else if(itemp.get(i).getItemNum() == 3) item3 = item3 + "_sold";
			else if(itemp.get(i).getItemNum() == 4) item4 = item4 + "_sold";
		}
		
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
	
	<header>
      <div class="container my-auto">
        <div class="row">
          <div>
            <h1 class="text-uppercase">
              <strong>Game Item Shop</strong>
            </h1>
            <hr>
          </div>
          <div class="col-lg-8 mx-auto">
            <p class="text-faded mb-5">게임에서 사용하실 수 있는 아이템을 구매할 수 있습니다</p>
          </div>
        </div>
      </div>
    </header>
    
    <br><br>
    
	<div class="container">
		<div class="row">
			<table class="table">
 				 <thead class="thead-dark">
				    <tr>
				      <th scope="col">#</th>
				      <th scope="col" align="center">Items</th>
				      <th scope="col" align="right">소지금액 : <%= user.getUserGameMoney() %></th>
				    </tr>
				  </thead>
				<tbody>
					<tr>
						<td colspan=3>
							<div class="container my-auto">
						        <div class="row">
						          <div>
						            <h1 class="text-uppercase">
						              <strong>블럭 깨기</strong>
						            </h1>
						            <hr>
						          </div>
						          <div class="col-lg-8 mx-auto">
						          	<table class="table">
						          		<tbody>
						          			<tr>
						          				<td>
									          		<form method='POST' action='shopAction.jsp'>
									          			<input type ="hidden" name = "itemNum" value = "1"/>
									          			<%
									          				//if(itemp)
									          			%>
									          			<button id="close-image" type="submit"><img src=<%=itemPath + item1 + png %> width="200" height="200"></button>
									          		</form>
									          	</td>
						          			</tr>
						          			<tr>
						          				<td text-align="center"><strong>막대 길이 증가 - 1000</strong></td>
						          			</tr>
						          		</tbody>
						          	</table>
						          </div>
						        </div>
					      	</div>
				   		</td>
				    </tr>
				    <tr>
						<td colspan=3>
							<div class="container my-auto">
						        <div class="row">
						          <div>
						            <h1 class="text-uppercase">
						              <strong>슈팅</strong>
						            </h1>
						            <hr>
						          </div>
						          <div class="col-lg-8 mx-auto">
						          	<table class="table">
						          		<tbody>
						          			<tr>
						          				<td>
									          		<form method='POST' action='shopAction.jsp'>
									          			<input type ="hidden" name = "itemNum" value = "2"/>
									          			<button id="close-image" type="submit"><img src=<%=itemPath + item2 + png %> width="200" height="200"></button>
									          		</form>
									          	</td>
									          	<td>
									          		<form method='POST' action='shopAction.jsp'>
									          			<input type ="hidden" name = "itemNum" value = "3"/>
									          			<button id="close-image" type="submit"><img src=<%=itemPath + item3 + png  %> width="200" height="200"></button>
									          		</form>
									          	</td>
						          			</tr>
						          			<tr>
						          				<td><strong>공격 x2 - 1000</strong></td>
						          				<td><strong>공격 x4 - 2000</strong></td>
						          			</tr>
						          		</tbody>
						          	</table>
						          </div>
						        </div>
					      	</div>
				   		</td>
				    </tr>
				    <tr>
						<td colspan=3>
							<div class="container my-auto">
						        <div class="row">
						          <div>
						            <h1 class="text-uppercase">
						              <strong>비행</strong>
						            </h1>
						            <hr>
						          </div>
						          <div class="col-lg-8 mx-auto">
						          	<table class="table">
						          		<tbody>
						          			<tr>
									          	<td>
									          		<form method='POST' action='shopAction.jsp'>
									          			<input type ="hidden" name = "itemNum" value = "4"/>
									          			<button id="close-image" type="submit"><img src=<%=itemPath + item4 + png %> width="200" height="200"></button>
									          		</form>
									          	</td>
						          			</tr>
						          			<tr>
						          				<td><strong>비행기 속도 증가 - 1500</strong></td>
						          			</tr>
						          		</tbody>
						          	</table>
						          </div>
						        </div>
					      	</div>
				   		</td>
				    </tr>
				</tbody>
			</table>
			<br><br>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>