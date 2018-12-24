<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserPhoto" %>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
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
	int isChanged = 0;
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		String directory = request.getSession().getServletContext().getRealPath("/img");
		int maxSize = 1024 * 1024 * 30;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String fileName = multipartRequest.getOriginalFileName("userPhoto");
		String fileRealName = multipartRequest.getFilesystemName("userPhoto");
		
		if(fileRealName != null){
			isChanged = 1;
			new UserDAO().FileUpload(fileName,fileRealName, userID);
		}
		
		String userPassword = request.getParameter("userPassword");
		String userPasswordCheck = request.getParameter("userPassword_check");
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		
		UserDAO userDAO = new UserDAO();
		
		if(userPassword == null || userPasswordCheck == null){}
		else if((userPassword.equals("") && !userPasswordCheck.equals("")) || (!userPassword.equals("") && userPasswordCheck.equals(""))){
			PrintWriter pWriter = response.getWriter();
			pWriter.println("<script>");
			pWriter.println("alert('비밀번호 변경 시 비밀번호와 비밀번호 확인칸을 모두 입력해주셔야 합니다.')");
			pWriter.println("history.back()");
			pWriter.println("</script>");
		} else if(!userPassword.equals(userPasswordCheck)){
			PrintWriter pWriter = response.getWriter();
			pWriter.println("<script>");
			pWriter.println("alert('비밀번호와 비밀번호 확인 내용이 일치하지 않습니다.')");
			pWriter.println("history.back()");
			pWriter.println("</script>");
		} else if(userPassword.equals(userPasswordCheck) && !userPassword.equals("")){
			userDAO.modify(userID, userPassword, "Password");
			isChanged = 1;
		}
		
		if(userName != null && !userName.equals("")){
			userDAO.modify(userID, userName, "Name");
			isChanged = 1;
		}
		if(userEmail != null && !userEmail.equals("")){
			userDAO.modify(userID, userEmail, "Email");
			isChanged = 1;
		}
		
		PrintWriter pWriter = response.getWriter();
		pWriter.println("<script>");
		if(isChanged == 0)pWriter.println("alert('회원정보 수정 실패.')");
		else pWriter.println("alert('회원정보가 수정되었습니다.')");
		pWriter.println("location.href = 'mypage.jsp'");
		pWriter.println("</script>");
		
		
		//int result = userDAO.login(user.getUserID(), user.getUserPassword());
	%>
</body>
</html>