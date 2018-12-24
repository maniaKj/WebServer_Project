package bbs;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BbsDAO {
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
	
	public int getNext() {
		userDAO();
		
		String SQL = "select bbsID from bbs order by bbsID DESC";
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
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		Logger LOG = Logger.getGlobal();
		LOG.info(bbsTitle + " " + userID + " " + bbsContent);
		userDAO();
		String SQL = "insert into bbs values (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public ArrayList<Bbs> getList(int pageNumber) {
		userDAO();
		
		String SQL = "SELECT * FROM BBS where bbsID < ? and bbsAvailable = 1 order by bbsID DESC limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		userDAO();
		
		String SQL = "SELECT * FROM BBS where bbsID < ? and bbsAvailable = 1 order by bbsID DESC limit 10";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) {
		userDAO();
		
		String SQL = "SELECT * FROM BBS where bbsID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		userDAO();
		
		String SQL = "UPDATE bbs set bbsTitle = ?, bbsContent = ? where bbsID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int delete(int bbsID) {
		userDAO();
		String SQL2 = "Delete from bbs where bbsID = ?";
		String SQL3 = "update bbs set bbsID = bbsID - 1 where bbsID > ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL2);
			pstmt.setInt(1, bbsID);
			PreparedStatement pstmt2=conn.prepareStatement(SQL3);
			pstmt2.setInt(1, bbsID);
			return pstmt.executeUpdate() + pstmt2.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int getCommentNext() {
		userDAO();
		
		String SQL = "select commentID from comment order by commentID DESC";
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
	
	public int comment(int bbsID, String commentContent, String userID) {
		//Logger LOG = Logger.getGlobal();
		//LOG.info(bbsTitle + " " + userID + " " + bbsContent);
		userDAO();
		String SQL = "insert into comment values (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setInt(2, getCommentNext());
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, commentContent);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public ArrayList<BbsComment> getCommentList(int bbsID) {
		userDAO();
		
		String SQL = "SELECT * FROM comment where bbsID = ? order by bbsID DESC limit 10";
		ArrayList<BbsComment> list = new ArrayList<BbsComment>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BbsComment comment = new BbsComment();
				comment.setBbsID(rs.getInt(1));
				comment.setCommentID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setCommentDate(rs.getString(4));
				comment.setCommentContent(rs.getString(5));
				list.add(comment);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> Search(int s_case, String search_content) {
		userDAO();
		String SQL = "";
		if(s_case == 1) {
			SQL = "SELECT * FROM BBS where bbsTitle like ? and bbsAvailable = 1 order by bbsID DESC limit 10";
		} else if(s_case == 2) {
			SQL = "SELECT * FROM BBS where userID like ? and bbsAvailable = 1 order by bbsID DESC limit 10";
		} else if(s_case == 3) {
			SQL = "SELECT * FROM BBS where bbsContent like ? and bbsAvailable = 1 order by bbsID DESC limit 10";
		} else if(s_case == 4) {
			SQL = "SELECT * FROM BBS where bbsTitle like ? or bbsContent like ? order by bbsID DESC limit 10";
		}		
		
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search_content + "%");
			if(s_case == 4) pstmt.setString(2, "%" + search_content + "%");
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
