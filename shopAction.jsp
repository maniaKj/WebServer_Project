<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.Item" %>
<%@ page import="user.ItemPossession" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>게시판 웹사이트</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 먼저 하셔야 합니다')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	} 
	
	int itemNum = 0;
	if(request.getParameter("itemNum") != null) {
		itemNum = Integer.parseInt(request.getParameter("itemNum"));
	}
	
	//이미 샀는지
	//소지한 금액이 충분한지
	
	UserDAO userDAO = new UserDAO();
	User user = userDAO.getUser(userID);
	Item item = userDAO.getItem(itemNum);
	ArrayList<ItemPossession> itemp = userDAO.getItemPossessionList(userID);
	
	/*PrintWriter script2 = response.getWriter();
	script2.println("<script>");
	script2.println("alert('" + user.getUserGameMoney() + "')");
	script2.println("alert('" + item.getPrice() + "')");
	script2.println("location.href = 'shop.jsp'");
	script2.println("</script>");*/
	
	for(int i =0;i<itemp.size(); i++){
		if(itemp.get(i).getItemNum() == itemNum){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 구입한 아이템입니다.')");
			script.println("location.href = 'shop.jsp'");
			script.println("</script>");
			return;
		}
	}
	if(user.getUserGameMoney() >= item.getPrice()){
		userDAO.AlterUserMoney(userID, -1 * item.getPrice());
		
			
		PrintWriter script = response.getWriter();
		script.println("<script>");
		//script.println("alert('" + item.getPrice() + "     " + item.getItemNum() + " 을 구매하셨습니다.')");
		if(userDAO.addPossession(userID, item.getItemNum()) == -1)
		script.println("alert('데이터 베이스 오류')");
		script.println("alert('" + item.getItemName() + " 을 구매하셨습니다.')");
		script.println("location.href = 'shop.jsp'");
		script.println("</script>");
	}
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게임머니가 충분하지 않습니다.')");
		script.println("location.href = 'shop.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>