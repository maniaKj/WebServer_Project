package bbs;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ChatDAO {
	private java.sql.Connection conn;
	private ResultSet rs;
	
	public void userDAO() {
		try {
			String dbURL = "jdbc:mysql://127.0.0.1/BBS";
			String dbID = "jdbcuser";
			String dbPassword = "jdbctest";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Chat> getChatList() {
		ArrayList<Chat> chatList = null;
		userDAO();
		String SQL = "select * from chat where chatTime > (DATE_ADD(NOW(), INTERVAL -1 day)) and chatID > 0 order by chatTime desc limit 7";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			while(rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatID"));
				chat.setChatName(rs.getString("chatName"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				chat.setChatTime(rs.getString("chatTime"));
				chatList.add(chat);
			}
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return chatList;
	} 
	
	public int submit(String chatName, String chatContent) {
		userDAO();
		PreparedStatement pstmt=null;
		String SQL = "insert into chat values(?, ?, now(), ?)";
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  chatName);
			pstmt.setString(2,  chatContent);
			pstmt.setInt(3, getNext());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return -1;//데이터베이스 오류
	}
	
	public int getNext() {
		userDAO();
		
		String SQL = "select chatID from chat order by chatID DESC";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫 번째 게시글
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
}
