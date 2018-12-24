<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href ="css/bootstrap.css">
<link rel="stylesheet" href ="css/custom.css">
<link href="https://fonts.googleapis.com/css?family=Arimo|Major+Mono+Display|Nanum+Gothic+Coding|Noto+Sans|ZCOOL+QingKe+HuangYou" rel="stylesheet">

<style>
@import url('https://fonts.googleapis.com/css?family=Arimo|Major+Mono+Display|Nanum+Gothic+Coding|Noto+Sans|ZCOOL+QingKe+HuangYou');
</style>

<!-- 
font
font-family: 'Major Mono Display', monospace;
font-family: 'Noto Sans', sans-serif;
font-family: 'Nanum Gothic Coding', monospace;
font-family: 'ZCOOL QingKe HuangYou', cursive;
font-family: 'Arimo', sans-serif;
 -->
<title>게시판 웹사이트</title>

<script>
var toggle_Image = 1;
var date_choose;
var keyword;
window.addEventListener('message', function(e) {

  });
function test_Alert(value){
	toggle_Image = value;
	if(toggle_Image == 1) Change_barGraph(date_choose);
	else Change_wordCloud(date_choose);
}

function icon_Over(data){
	//alert(data);
	$(data).attr("width", "120");
	$(data).attr("height", "120");
}

function icon_Out(data){
	//alert(data);
	$(data).attr("width", "100");
	$(data).attr("height", "100");
}

function icon_Click(data){
	alert('click' + data);
	//$('#flight').attr("width", "120");
	//$('#flight').attr("height", "120");
}

</script>

</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
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
    <div style = "position: relative; background-image: URL(Images/sphere_by_snatti89-dcic51p.png); 
    background-size: cover; background-position: center; height : 426px;padding-top: 8rem;padding-bottom: 8rem;">
      <div class="container">
        <div class="row">
          <div class="col-lg-10 mx-auto">
            <h1 style="color:white; font-family: 'Major Mono Display', monospace; font-size:48px">
              <strong>Wtrip</strong>
            </h1>
            <hr>
            <h1 style="color:white; font-family: 'Nanum Gothic Coding', monospace; font-size:26px">
              	재밌는 게임을 즐겨보세요!!!
            </h1>
            <h1 style="color:white; font-family: 'Nanum Gothic Coding', monospace; font-size:18px">
              Unity 엔진 기반 WebGL 게임 모음
            </h1>
          </div>
        </div>
      </div>
      </div>
    </header>

	
	<div class ="container" style= "height: 100%; width: 100%; position: relative; background-size: cover;background-color: #E0E0F8;">
		<section class="features-icons bg-light text-center">
      <div class="container">
        <div class="row">
        <br><br><br>
          <div class="col-lg-4">
            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
              <div class="features-icons-icon d-flex">
                <i class="icon-screen-desktop m-auto text-primary"></i>
              </div>
              <img id = "block" src="Images/mainPage/Block_Game.png" onmouseout="icon_Out('#block')" onmouseover="icon_Over('#block')" onClick = "icon_Click('#block')" width = "100" height = "100">
              <h3 style="font-family: 'Noto Sans', sans-serif; font-size:30px;">Block Breaking</h3>
              <!-- <p class="lead mb-0">This theme will look great on any device, no matter the size!</p>
               -->
            </div>
          </div>
          <div class="col-lg-4">
            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
              <div class="features-icons-icon d-flex">
                <i class="icon-layers m-auto text-primary"></i>
              </div>
              <img id = "flight" src="Images/mainPage/Flight_Game.png" onmouseout="icon_Out('#flight')" onmouseover="icon_Over('#flight')" onClick = "icon_Click('#flight')" width = "100" height = "100">
              <h3 style="font-family: 'Noto Sans', sans-serif; font-size:30px;">Flight Game</h3>
              <!--  <p class="lead mb-0">Featuring the latest build of the new Bootstrap 4 framework!</p>
            	-->
            </div>
          </div>
          <div class="col-lg-4">
            <div class="features-icons-item mx-auto mb-0 mb-lg-3">
              <div class="features-icons-icon d-flex">
                <i class="icon-check m-auto text-primary"></i>
              </div>
              <img id = "shooting" src="Images/mainPage/Shooting_Game.png" onmouseout="icon_Out('#shooting')" onmouseover="icon_Over('#shooting')" onClick = "icon_Click('#shooting')" width = "100" height = "100">
              <h3 style="font-family: 'Noto Sans', sans-serif; font-size:30px;">Shooting Game</h3>
              <!--<p class="lead mb-0">Ready to use with your own content, or customize the source files!</p>
            	-->
            </div>
          </div>
        </div>
      </div>
      <br><br><br>
    </section>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>