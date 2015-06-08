package BulletinBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import Global.Management;

public class CommentsProcessing {
	private static CommentsProcessing instance = new CommentsProcessing();
	private Management globalManager = Management.getInstance();

	public static CommentsProcessing getInstance() {
		return instance;
	}

	public int WriteComment(CommentsDataBean data) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int nextCommentNumber = -1;
		int state = -1;
		
		try{
			connection = globalManager.getConnection();
			
			nextCommentNumber = GetNextCommentNumber();
			if(nextCommentNumber < 0) { 
				state = -2;	//Wrong Access
				return state;
			}
			
			pStatement = connection.prepareStatement(
					"insert into Comments " + 
					"values (?,?,?,?,?)");
			pStatement.setInt(1, nextCommentNumber);
			pStatement.setInt(2, data.getUserNumber());
			pStatement.setInt(3, data.getArticleNumber());
			pStatement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
			pStatement.setString(5, data.getContent());
			pStatement.executeUpdate();
			state = 1;	//Success Writing
			
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return state;
	}
	
	public int DeleteComment(int num) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int state = -1;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"delete " + 
					"from Comments " +
					"where num = ?");
			pStatement.setInt(1, num);
			pStatement.executeUpdate();
			state = 1;
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return state;
	}
	
	public List<CommentsDataBean> GetCommentList(int articleNumber) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		List<CommentsDataBean> comments = null;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select * " + 
					"from Comments " +
					"where articleNumber = ? " +
					"order by registrationDate desc");
			pStatement.setInt(1, articleNumber);
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				comments = new ArrayList<CommentsDataBean>();
				do {
					CommentsDataBean data = new CommentsDataBean();
					data.setNum(resultSet.getInt("num"));
					data.setUserNumber(resultSet.getInt("userNumber"));
					data.setArticleNumber(articleNumber);
					data.setRegistrationDate(resultSet.getTimestamp("registrationDate"));
					data.setContent(resultSet.getString("content"));
					comments.add(data);
				} while(resultSet.next());
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return comments;
	}
	
	int GetNextCommentNumber() {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		int nextCommentNumber = -1;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select MAX(num) AS nextCommentNumber " + 
					"from Comments");
			resultSet = pStatement.executeQuery();
			nextCommentNumber = 0;
			if(resultSet.next()) {
				nextCommentNumber = resultSet.getInt("nextCommentNumber");
				nextCommentNumber++;
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return nextCommentNumber;
	}
}
