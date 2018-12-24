<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="comment" class="bbs.BbsComment" scope="page"/>
<jsp:setProperty name="comment" property ="commentContent"/>
<jsp:setProperty name="comment" property ="bbsID"/>
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
	} else{
		if(comment.getCommentContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			BbsDAO bbsDAO = new BbsDAO();
			//int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			int result = bbsDAO.comment(comment.getBbsID(), comment.getCommentContent(), userID);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 달기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'view.jsp?bbsID='" + Integer.toString(comment.getBbsID()));
				script.println("history.back()");
				script.println("</script>");
			}
		}
	}
		
	%>
</body>
</html>