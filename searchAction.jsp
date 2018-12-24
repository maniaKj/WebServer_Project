<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>게시판 웹사이트</title>
</head>
<body>
	<%
	String col = request.getParameter("col");
    String word = request.getParameter("word");

    BbsDAO bbsDAO = new BbsDAO();
    
    if(word == null) {
    	PrintWriter script = response.getWriter();
    	script.println("<script>");
		script.println("alert('입력되지 않은 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
    } else{
	    if(col.equals("title")){
	    	PrintWriter script = response.getWriter();
	    	script.println("<script>");
			script.println("location.href = 'bbs.jsp?search_case=1&search_content=" + word + "'");
			script.println("</script>");
	    } else if(col.equals("name")){
	    	PrintWriter script = response.getWriter();
	    	script.println("<script>");
			script.println("location.href = 'bbs.jsp?search_case=2&search_content=" + word + "'");
			script.println("</script>");
	    } else if(col.equals("content")){
	    	PrintWriter script = response.getWriter();
	    	script.println("<script>");
			script.println("location.href = 'bbs.jsp?search_case=3&search_content=" + word + "'");
			script.println("</script>");
	    } else if(col.equals("title_content")){
	    	PrintWriter script = response.getWriter();
	    	script.println("<script>");
			script.println("location.href = 'bbs.jsp?search_case=4&search_content=" + word + "'");
			script.println("</script>");
	    }
    }
    	
	/* if(comment.getCommentContent() == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력되지 않은 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
	} else{
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
	*/
		
	%>
</body>
</html>