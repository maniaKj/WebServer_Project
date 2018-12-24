package bbs;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChatSubmitServlet")
public class ChatGetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding(("UTF-8"));
		response.setContentType("text/html;charset=UTF-8");
		String chatName = request.getParameter("chatName");
		String chatContent = request.getParameter("chatContent");
		
		if(chatName == null || chatName.equals("") || chatContent == null) {
			response.getWriter().write("실패  이름값 : " + chatName + " 입력값 : " + chatContent);
		}
		else {
			response.getWriter().write(new ChatDAO().submit(chatName, chatContent) + "");
		}
	}

}
