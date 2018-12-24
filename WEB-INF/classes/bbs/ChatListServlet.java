package bbs;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;

@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO userDAO = new UserDAO();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding(("UTF-8"));
		response.setContentType("text/html;charset=UTF-8");
		String listType = request.getParameter("listType");
		int lastID = Integer.parseInt(request.getParameter("lastID"));
		
		if(listType == null || listType.equals("")) response.getWriter().write("");
		else if(listType.equals("Initialize")) response.getWriter().write(getChat());
		//else if(listType.equals("Initialize")) response.getWriter().write("F Initail");
		else if(listType.equals("Update") && lastID != 0) response.getWriter().write(chatUpdate(lastID));
		//else if(listType.equals("Update") && lastID != 0) response.getWriter().write("Fucking Updatee");
	}
    
	/*protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding(("UTF-8"));
		response.setContentType("text/html;charset=UTF-8");
		String listType = request.getParameter("listType");
		int lastID = 0;
		lastID = Integer.parseInt(request.getParameter("lastID"));
		response.getWriter().write("Fuck");
		//if(listType == null || listType.equals("")) response.getWriter().write("");
		//else if(listType.equals("Initialize")) response.getWriter().write(getChat());
		//else if(listType.equals("Initialize")) response.getWriter().write("F Initail");
		//else if(listType.equals("Update") && lastID != 0) response.getWriter().write(chatUpdate(lastID));
		//else if(listType.equals("Update") && lastID != 0) response.getWriter().write("Fucking Updatee");
		//else response.getWriter().write("½ÇÆÐ : " + listType + " , lastID : " + lastID);
	}*/
	
	public String getChat() {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		
		ArrayList<Chat> chatList = chatDAO.getChatList();
		try {
			for(int i = chatList.size() - 1; i >= 0; i--) {
				result.append("[{\"value\": \"" + chatList.get(i).getChatName() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatID() + "\"},");
				result.append("{\"value\": \"" + userDAO.GetImageFile(chatList.get(i).getChatName()) + "\"}]");
				if(i != 0) result.append(", ");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		result.append("]}");
		return result.toString();
	}
	
	public String chatUpdate(int from) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<Chat> chatList = chatDAO.getChatList();
		try {
		int i = chatList.size() - 1;
		
			while(i >= 0) {
				if(chatList.get(i).getChatID() > from) {
					result.append("[{\"value\": \"" + chatList.get(i).getChatName() + "\"},");
					result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
					result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"},");
					result.append("{\"value\": \"" + chatList.get(i).getChatID() + "\"},");
					result.append("{\"value\": \"" + userDAO.GetImageFile(chatList.get(i).getChatName()) + "\"}]");
					if(i != 0) result.append(", ");
				}
				i--;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		result.append("]}");
		return result.toString();
	}
	
	/*public String chatUpdate(int from) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<Chat> chatList = chatDAO.getChatList();
		int i = 0;
		
		while(i < chatList.size()) {
			if(chatList.get(i).getChatID() > from) {
				result.append("[{\"value\": \"" + chatList.get(i).getChatName() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"},");
				result.append("{\"value\": \"" + chatList.get(i).getChatID() + "\"}]");
				if(i != chatList.size() -1) result.append(", ");
			}
			i++;
		}
		result.append("]}");
		return result.toString();
	}*/
}
