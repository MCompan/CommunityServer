package NoticeBoard;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Global.Management;

public class NoticeProcessing {
	private static NoticeProcessing instance = new NoticeProcessing();
	private Management globalManager = Management.getInstance();

	public static NoticeProcessing getInstance() {
		return instance;
	}
	
	public int Writing(NoticeDataBean data) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int nextWritingNumber = -1;
		int state = -1;
		
		try{
			nextWritingNumber = GetNextWritingNumber();
			if(nextWritingNumber < 0) { 
				state = -2;	//Wrong Access
				return state;
			}
			
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"insert into NoticeBoard " +
					"value (?, ?, ?, ?)"
					);
			pStatement.setInt(1, nextWritingNumber);
			pStatement.setString(2, data.getSubject());
			pStatement.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
			pStatement.setString(4, data.getContent());
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
	
	public int DeleteWriting(int num) {		
		Connection connection = null;
		PreparedStatement pStatement = null;
		int state = -1;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"delete " + 
					"from NoticeBoard " +
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
	
	public int GetWritingCount() {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		int count = -1;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement("select count(*) as writingCount from NoticeBoard");
			resultSet = pStatement.executeQuery();
			count = 0;
			if(resultSet.next()) {
				count = resultSet.getInt("writingCount");
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		
		return count;
	}

	public List<NoticeDataBean> GetList(int start, int end) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		List<NoticeDataBean> list = null;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select * " + 
					"from NoticeBoard " +
					"order by num asc " + 
					"limit ?,?");
			pStatement.setInt(1, start-1);
			pStatement.setInt(2, end);
			resultSet = pStatement.executeQuery();
			
			if(resultSet.next()) {
				list = new ArrayList<NoticeDataBean>(end);
				do{
					NoticeDataBean writing = new NoticeDataBean();
					writing.setNum(resultSet.getInt("num"));
					writing.setSubject(resultSet.getString("subject"));
					writing.setRegistrationDate(resultSet.getTimestamp("registrationDate"));
					writing.setContent(resultSet.getString("content"));
					list.add(writing);
				} while(resultSet.next());
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return list;
	}
	
	public NoticeDataBean GetWriting(int num) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		NoticeDataBean writing = new NoticeDataBean();
		
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"select * " + 
					"from NoticeBoard " +
					"where num = ?;");
			pStatement.setInt(1, num);
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
					writing.setNum(resultSet.getInt("num"));
					writing.setSubject(resultSet.getString("subject"));
					writing.setRegistrationDate(resultSet.getTimestamp("registrationDate"));
					writing.setContent(resultSet.getString("content"));
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return writing;
	}
	
	int GetNextWritingNumber() {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		int nextWritingNumber = -1;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select MAX(num) AS nextWritingNumber " + 
					"from NoticeBoard");
			resultSet = pStatement.executeQuery();
			nextWritingNumber = 0;
			if(resultSet.next()) {
				nextWritingNumber = resultSet.getInt("nextWritingNumber");
				nextWritingNumber++;
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		
		return nextWritingNumber;
	}
}
