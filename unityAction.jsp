<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.Item" %>
<%@ page import="user.ItemPossession" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.util.Random" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href ="css/bootstrap.css">
<title>유니티 post받기</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		int gameNum = 0, gameResult = 0, getValue=-1, check = -1;
		
		if(request.getParameter("gameNum") != null) {
			gameNum = Integer.parseInt(request.getParameter("gameNum"));
		}
		if(request.getParameter("gameResult") != null) {
			gameResult = Integer.parseInt(request.getParameter("gameResult"));
		}
		if(request.getParameter("getValue") != null) {
			getValue = Integer.parseInt(request.getParameter("getValue"));
		}
		if(request.getParameter("check") != null) {
			check = Integer.parseInt(request.getParameter("check"));
		}
		
		UserDAO userDAO = new UserDAO();
		
		if(gameNum != 0 && gameResult != 0){
			userDAO.unityResult(gameNum, userID, gameResult);
		}
		
		if(gameNum != 0 && getValue != -1){
			int random = new Random().nextInt(9);
			PrintWriter script = response.getWriter();
			script.println(random);
			script.println(new Random().nextInt(9));
			script.println(new Random().nextInt(9));
			script.println("?!?");
			random = -1;
		}
		
		if(gameNum != 0 && check != -1){
			ArrayList<ItemPossession> itemp = userDAO.getItemPossessionList(userID);
			for(int i =0;i<itemp.size(); i++){
				Item item = userDAO.getItem(itemp.get(i).getItemNum());
				if(item.getGameNum() == gameNum){
					PrintWriter script = response.getWriter();
					script.println("Item-" + item.getItemNum());
				}
			}
		}
		
		if(gameNum != 0 && check == 11){
			ArrayList<ItemPossession> itemp = userDAO.getItemPossessionList(userID);
			for(int i =0;i<itemp.size(); i++){
				Item item = userDAO.getItem(itemp.get(i).getItemNum());
				if(item.getGameNum() == gameNum){
					PrintWriter script = response.getWriter();
					script.println("Item-" + item.getItemNum());
				}
			}
		}
		
		if(gameNum != 0 && check != -1){
			PrintWriter script = response.getWriter();
			script.println("Item-" + 2);
		}
		/*if(userUnity.getUserID().equals("asdf")){
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
		
		if(userUnity.getUserID().equals("asdf")){
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write("TestUnityToSQL", "master", "congratulation");
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("Write Fail");
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("Write Success!!");
			}
		}
		
		if(userUnity.getUserID().equals("1234")){
			BbsDAO bbsDAO = new BbsDAO();
			ArrayList<Bbs> list= bbsDAO.getList(1);
			PrintWriter script = response.getWriter();
			script.println(list.get(0).getBbsID());
			//script.println(asdf);
		}*/
		//int result = userDAO.login(user.getUserID(), user.getUserPassword());
		/*PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력값은 : ' + userUnity.getGameScore())");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");*/
	
		
	%>
</body>
</html>