<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href ="css/bootstrap.css">
<link rel="stylesheet" href ="css/chatbox.css">

<title>Insert title here</title>
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
			<a class="navbar-brand"href="main.jsp">JSP 게시판 웹 사이트</a>
			<a class="navbar-brand"href="Unity_Web/index.html">틱텍톧</a>
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
	
	<div class="panel-body">
	    <ul class="chat">
	        <li class="left clearfix"><span class="chat-img pull-left">
	            <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
	        </span>
	            <div class="chat-body clearfix">
	                <div class="header">
	                    <strong class="primary-font">Jack Sparrow</strong> <small class="pull-right text-muted">
	                        <span class="glyphicon glyphicon-time"></span>12 mins ago</small>
	                </div>
	                <p>
	                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
	                    dolor, quis ullamcorper ligula sodales.
	                </p>
	            </div>
	        </li>
	        <li class="right clearfix"><span class="chat-img pull-right">
	            <img src="http://placehold.it/50/FA6F57/fff&text=ME" alt="User Avatar" class="img-circle" />
	        </span>
	            <div class="chat-body clearfix">
	                <div class="header">
	                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>13 mins ago</small>
	                    <strong class="pull-right primary-font">Bhaumik Patel</strong>
	                </div>
	                <p>
	                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
	                    dolor, quis ullamcorper ligula sodales.
	                </p>
	            </div>
	        </li>
	        <li class="left clearfix"><span class="chat-img pull-left">
	            <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
	        </span>
	            <div class="chat-body clearfix">
	                <div class="header">
	                    <strong class="primary-font">Jack Sparrow</strong> <small class="pull-right text-muted">
	                        <span class="glyphicon glyphicon-time"></span>14 mins ago</small>
	                </div>
	                <p>
	                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
	                    dolor, quis ullamcorper ligula sodales.
	                </p>
	            </div>
	        </li>
	        <li class="right clearfix"><span class="chat-img pull-right">
	            <img src="http://placehold.it/50/FA6F57/fff&text=ME" alt="User Avatar" class="img-circle" />
	        </span>
	            <div class="chat-body clearfix">
	                <div class="header">
	                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>15 mins ago</small>
	                    <strong class="pull-right primary-font">Bhaumik Patel</strong>
	                </div>
	                <p>
	                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
	                    dolor, quis ullamcorper ligula sodales.
	                </p>
	            </div>
	        </li>
	    </ul>
	</div>
	<div class="panel-footer">
	    <div class="input-group">
	        <input id="btn-input" type="text" class="form-control input-sm" placeholder="Type your message here..." />
	        <span class="input-group-btn">
	            <button class="btn btn-warning btn-sm" id="btn-chat">
	                Send</button>
	        </span>
	    </div>
	</div>
	
	<div class="container">
	    <div class="row">
	        <div class="col-md-5">
	            <div class="panel panel-primary">
	                <div class="panel-heading" id="accordion">
	                    <span class="glyphicon glyphicon-comment"></span> Chat
	                    <div class="btn-group pull-right">
	                        <a type="button" class="btn btn-default btn-xs" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                            <span class="glyphicon glyphicon-chevron-down"></span>
	                        </a>
	                    </div>
	                </div>
	            <div class="panel-collapse collapse" id="collapseOne">
	                <div class="panel-body">
	                    <ul class="chat">
	                        <li class="left clearfix"><span class="chat-img pull-left">
	                            <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
	                        </span>
	                            <div class="chat-body clearfix">
	                                <div class="header">
	                                    <strong class="primary-font">Jack Sparrow</strong> <small class="pull-right text-muted">
	                                        <span class="glyphicon glyphicon-time"></span>12 mins ago</small>
	                                </div>
	                                <p>
	                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
	                                    dolor, quis ullamcorper ligula sodales.
	                                </p>
	                            </div>
	                        </li>
	                        <li class="right clearfix"><span class="chat-img pull-right">
	                            <img src="http://placehold.it/50/FA6F57/fff&text=ME" alt="User Avatar" class="img-circle" />
	                        </span>
	                            <div class="chat-body clearfix">
	                                <div class="header">
	                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>13 mins ago</small>
	                                    <strong class="pull-right primary-font">Bhaumik Patel</strong>
	                                </div>
	                                <p>
	                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
	                                    dolor, quis ullamcorper ligula sodales.
	                                </p>
	                            </div>
	                        </li>
	                        <li class="left clearfix"><span class="chat-img pull-left">
	                            <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
	                        </span>
	                            <div class="chat-body clearfix">
	                                <div class="header">
	                                    <strong class="primary-font">Jack Sparrow</strong> <small class="pull-right text-muted">
	                                        <span class="glyphicon glyphicon-time"></span>14 mins ago</small>
	                                </div>
	                                <p>
	                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
	                                    dolor, quis ullamcorper ligula sodales.
	                                </p>
	                            </div>
	                        </li>
	                        <li class="right clearfix"><span class="chat-img pull-right">
	                            <img src="http://placehold.it/50/FA6F57/fff&text=ME" alt="User Avatar" class="img-circle" />
	                        </span>
	                            <div class="chat-body clearfix">
	                                <div class="header">
	                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>15 mins ago</small>
	                                    <strong class="pull-right primary-font">Bhaumik Patel</strong>
	                                </div>
	                                <p>
	                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
	                                    dolor, quis ullamcorper ligula sodales.
	                                </p>
	                            </div>
	                        </li>
	                    </ul>
	                </div>
	                <div class="panel-footer">
	                    <div class="input-group">
	                        <input id="btn-input" type="text" class="form-control input-sm" placeholder="Type your message here..." />
	                        <span class="input-group-btn">
	                            <button class="btn btn-warning btn-sm" id="btn-chat">
	                                Send</button>
	                        </span>
	                    </div>
	                </div>
	            </div>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>