package user;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Logger;

//import bbs.Bbs;

public class UserDAO {
	private java.sql.Connection conn;
	private PreparedStatement pstmt;
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
	
	public User getUser(String userID) {
		userDAO();
		
		String SQL = "SELECT * FROM user where userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				user.setUserGameMoney(rs.getInt(5));
				return user;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int AlterUserMoney(String userID, int value) {
		userDAO();
		String SQL = "update user set userGameMoney = userGameMoney + ? where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, value);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int login(String userID, String userPassword) {
		userDAO();
		
		String SQL= "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
				return 1; //login success
				else 
				return 0;
			}
			return -1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int join(User user) {
		userDAO();
		
		String SQL = "insert into user values(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setInt(5, 0);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int modify(String userID, String Content, String c_type) {
		userDAO();
		String SQL = "";
		if(c_type.equals("Password")) SQL = "update user set userPassword = ? where userID = ?";
		if(c_type.equals("Name")) SQL = "update user set userName = ? where userID = ?";
		if(c_type.equals("Email")) SQL = "update user set userEmail = ? where userID = ?";
			
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, Content);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getNext() {
		userDAO();
		
		String SQL = "select fileNum from userphoto order by fileNum DESC";
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
	
	public int getNextUnity() {
		userDAO();
		
		String SQL = "select rankID from unity order by rankID DESC";
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
	
	public String getDate() {
		String SQL = "select now()";
		userDAO();
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int FileUpload(String filename, String fileRealname, String userID) {
		userDAO();
		
		String DeleteSQL = "Delete from userphoto where userID = ?";
		String SQL = "insert into userphoto values(?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, filename);
			pstmt.setString(3, fileRealname);
			pstmt.setString(4, userID);
			PreparedStatement pstmt2=conn.prepareStatement(DeleteSQL);
			pstmt2.setString(1, userID);
			return pstmt2.executeUpdate() + pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String GetImageFile(String userID) {
		userDAO();
		
		String SQL= "SELECT fileRealName FROM userphoto WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getString(1);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int unityResult(int gameNum, String userID, int gameResult) {
		userDAO();
		AlterUserMoney(userID, gameResult);
		String SQL = "insert into unity values (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNextUnity());
			pstmt.setInt(2, gameNum);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setInt(5, gameResult);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public ArrayList<UserUnity> getUnityList(String userID) {
		userDAO();
		
		String SQL = "SELECT * FROM unity where userID = ?";
		ArrayList<UserUnity> list = new ArrayList<UserUnity>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				UserUnity unity = new UserUnity();
				unity.setRankID(rs.getInt(1));
				unity.setGameNum(rs.getInt(2));
				unity.setUserID(rs.getString(3));
				unity.setResultTime(rs.getString(4));
				unity.setGameResult(rs.getInt(5));
				list.add(unity);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Item getItem(int itemID) {
		userDAO();
		String SQL= "SELECT * FROM item where itemNum = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, itemID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Item item = new Item();
				item.setItemNum(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setGameNum(rs.getInt(3));
				item.setPrice(rs.getInt(4));
				return item;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int addPossession(String userID, int itemNum) {
		userDAO();
		String SQL= "insert into possession values(?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, itemNum);
			return pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			}
		return -1;//데이터베이스 오류
	}
	
	public ArrayList<ItemPossession> getItemPossessionList(String userID) {
		userDAO();
		String SQL = "select * from possession where userID = ?";
		
		ArrayList<ItemPossession> list = new ArrayList<ItemPossession>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ItemPossession itemp = new ItemPossession();
				itemp.setItemNum(rs.getInt(2));
				itemp.setUserID(userID);
				list.add(itemp);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
