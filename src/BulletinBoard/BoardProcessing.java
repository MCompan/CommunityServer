package BulletinBoard;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Timestamp;

import Global.Management;

public class BoardProcessing {
	private static BoardProcessing instance = new BoardProcessing();
	private Management globalManager = Management.getInstance();

	public static BoardProcessing getInstance() {
		return instance;
	}


	//type:1 = new, type:2 = update
	public int Write(BoardDataBean data, int type) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int nextWritingNumber = -1;
		int state = -1;
		
		try{
			connection = globalManager.getConnection();
			
			if(type == 1) {
				nextWritingNumber = GetNextWritingNumber();
				if(nextWritingNumber < 0) { 
					state = -2;	//Wrong Access
					return state;
				}
				
				pStatement = connection.prepareStatement(
						"insert into BulletinBoard " + 
						"values (?,?,?,?,?,?)");
				pStatement.setInt(1, nextWritingNumber);
				pStatement.setInt(2, data.getUserNumber());
				pStatement.setString(3, data.getSubject());
				pStatement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
				pStatement.setInt(5, data.getReadCount());
				pStatement.setString(6, data.getContent());
				pStatement.executeUpdate();
				state = 1;	//Success Writing
			} else if(type == 2) {
				pStatement = connection.prepareStatement(
						"update BulletinBoard " + 
						"set subject = ?, content = ? " +
						"where num = ?");
				pStatement.setString(1, data.getSubject());
				pStatement.setString(2, data.getContent());
				pStatement.setInt(3, data.getNum());
				pStatement.executeUpdate();
				state = 2;	//Success Update
			}
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
			pStatement = connection.prepareStatement("select count(*) as writingCount from BulletinBoard");
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
	
	public int UpdateReadCount(int num) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		int state = -1;
		int readCount = 0;
		
		try{
			connection = globalManager.getConnection();
			
			pStatement = connection.prepareStatement(
					"select readCount " +
					"from BulletinBoard " +
					"where num = ?");
			pStatement.setInt(1, num);
			resultSet = pStatement.executeQuery();
			
			if(resultSet.next()) {
				readCount = resultSet.getInt("readCount");
				readCount++;
			}
			
			pStatement = connection.prepareStatement(
					"update BulletinBoard " +
					"set readCount = ? " +
					"where num = ?");
			pStatement.setInt(1, readCount);
			pStatement.setInt(2, num);
			pStatement.executeUpdate();
			state = 1;
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		
		return state;
	}
	
	public List<BoardDataBean> GetList(int start, int end) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		List<BoardDataBean> list = null;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select * " + 
					"from BulletinBoard " +
					"order by num asc " + 
					"limit ?,?");
			pStatement.setInt(1, start-1);
			pStatement.setInt(2, end);
			resultSet = pStatement.executeQuery();
			
			if(resultSet.next()) {
				list = new ArrayList<BoardDataBean>(end);
				do{
					BoardDataBean writing = new BoardDataBean();
					writing.setNum(resultSet.getInt("num"));
					writing.setUserNumber(resultSet.getInt("userNumber"));
					writing.setSubject(resultSet.getString("subject"));
					writing.setRegistrationDate(resultSet.getTimestamp("registrationDate"));
					writing.setReadCount(resultSet.getInt("readCount"));
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
	
	public BoardDataBean GetWriting(int num) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		BoardDataBean writing = new BoardDataBean();
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select * " + 
					"from BulletinBoard " +
					"where num = ?");
			pStatement.setInt(1, num);
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
					writing.setNum(resultSet.getInt("num"));
					writing.setUserNumber(resultSet.getInt("userNumber"));
					writing.setSubject(resultSet.getString("subject"));
					writing.setRegistrationDate(resultSet.getTimestamp("registrationDate"));
					writing.setReadCount(resultSet.getInt("readCount"));
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
	
	public int DeleteWriting(int num) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int state = -1;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"delete " + 
					"from BulletinBoard " +
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
	
	int GetNextWritingNumber() {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		int nextWritingNumber = -1;
		
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select MAX(num) AS nextWritingNumber " + 
					"from BulletinBoard");
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
