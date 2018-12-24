<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href ="css/bootstrap.css">
<link rel="stylesheet" href ="css/chatbox.css">
<title>게시판 웹사이트</title>
	<script type="text/javascript">
		var lastID = 0;
		
		function submitFunction(){
			var chatName = $('#chatName').val();
			var chatContent = $('#chatContent').val();
			$.ajax({
				type: "POST",
				url: "./chatSubmitServlet",
				data: {
					chatName: chatName,
					chatContent: chatContent
				},
				success: function(result){
					//alert(lastID + " " + result);
					//chatListUpdate(lastID);
				}
				
			});
			$('#chatContent').val('');
		}
		
		function chatListFunction(input_string){
			//alert('Ft2');
			$.ajax({
				type: "POST",
				url: "./chatListServlet",
				data: {
					listType: input_string,
					lastID: lastID
				},
				success: function(data){
					//alert("Test - lastID : " + lastID + ", Input String : " + input_string + ", result : " + data);
					var parsed = JSON.parse(data);
					var result = parsed.result;
					alert("Test - lastID : " + lastID + ", Input String : " + input_string + ", result : " + data);
					for(var i = 0; i < result.length; i++){
						addChat(result[i][0].value, result[i][1].value, result[i][2].value, result[i][4].value);
					}
					lastID = result[result.length -1][3].value;
				}
				
			});
		}
		
		/*function chatListFunction2(type){
			$.ajax({
				type: "POST",
				url: "./chatListServlet",
				data: {
					listType: type,
				},
				success: function(data){
					var parsed = JSON.parse(data);
					var result = parsed.result;
					alert('성공 : ' + data);
					for(var i = 0; i < result.length; i++){
						addChat(result[i][0].value, result[i][1].value, result[i][2].value);
					}
					lastID = result[result.length -1][3].value;
				}
				
			});
		}*/
		
		function chatListUpdate(input_string){
			//alert('Fucking List Test2');
			$.ajax({
				type: "POST",
				url: "./chatListServlet",
				data: {
					listType: input_string,
					lastID: lastID
				},
				success: function(data){
					var parsed = JSON.parse(data);
					var result = parsed.result;
					for(var i = 0; i < result.length; i++){
						addChat(result[i][0].value, result[i][1].value, result[i][2].value, result[i][4].value);
					}
					lastID = result[result.length -1][3].value;
				}
				
			});
		}
		
		function addChat(chatName, chatContent, chatTime, user_imgPath){
			var temp = new String("");
			temp += user_imgPath;
			var imgPath = "http://placehold.it/50/55C1E7/fff&text=U";
			if(temp == 'null') imgPath = "http://placehold.it/50/55C1E7/fff&text=U";
			else if(temp == 'default')imgPath = "http://placehold.it/50/55C1E7/fff&text=U";
			else imgPath = "img/" + user_imgPath;
			$('#chatList').append('<li class="left clearfix"><span class="chat-img pull-left">' + 
						'<img src=' + imgPath + ' alt="User Avatar" class="img-circle" width="64" height ="64"/>' +
						'</span>' +
						'<div class="chat-body clearfix">' +
						'<div class="header">' +
						'<strong class="primary-font">&nbsp; ' + chatName + '</strong> <small class="pull-right text-muted">' +
						'<span class="glyphicon glyphicon-time"></span>' + chatTime.substring(0,19) + '</small>' +
						'</div>' +
						'<p> &nbsp;&nbsp;' +
						chatContent +
						'</p>' +
						'</div></li><br>'
						);
		}
		
		function timerChat(){
			chatListFunction('Initialize');
			setInterval(function(){
				//addChat('to', 'from', '2018-12-10');
				chatListUpdate('Update');
			}, 1000);
		}
	</script>
</head>
<body   onload="timerChat()">
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
	
	<div class="panel-body">
	    <ul class="chat">
	    	<div id="chatList">
		        
	        </div>
	    </ul>
	</div>
	<div class="panel-footer">
	    <div class="input-group">
	        <input id="chatContent" type="text" class="form-control input-sm" placeholder="Type your message here..." />
	        <input id="chatName" type="hidden" value=<%= userID %>>
	        <span class="input-group-btn">
	            <button class="btn btn-warning btn-sm" id="btn-chat" onClick="submitFunction();">
	                Send</button>
	        </span>
	    </div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>