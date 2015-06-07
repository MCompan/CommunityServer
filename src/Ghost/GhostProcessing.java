package Ghost;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import Global.Management;

public class GhostProcessing {
	private static GhostProcessing instance = new GhostProcessing();
	private Management globalManager = Management.getInstance();
	
	public static GhostProcessing getInstance() {
		return instance;
	}
	
	public int SetGhost(GhostDataBean data) {
		int state = -1;
		if(isInData(data)) {
			state = UpdateGhost(data);
		} else {
			state = AddGhost(data);
		}
		return state;
	}
	
	public String GetGhostPath(String userEmail, int stage) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		String path = null;
		
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"select filePath " +
					"from Ghost " +
					"where stage = ? and Ghost.userNumber = (select Users.userNumber " +
													  "from Users " +
													  "where userEmail = ?)");
			pStatement.setInt(1, stage);
			pStatement.setString(2, userEmail);
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				path = resultSet.getString("filePath");
			}
			
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return path;
	}
	
	public List<GhostDataBean> GetGhostList(int userNumber) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		List<GhostDataBean> GhostList = null;
		
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"select * " +
					"from Ghost " +
					"where userNumber = ?");
			pStatement.setInt(1, userNumber);
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				GhostList = new ArrayList<GhostDataBean>();
				do{
					GhostDataBean ghostData = new GhostDataBean();
					ghostData.setUserNumber(resultSet.getInt("userNumber"));
					ghostData.setStage(resultSet.getInt("stage"));
					ghostData.setFilePath(resultSet.getString("filePath"));
					ghostData.setRegistrationDate(resultSet.getTimestamp("registrationDate"));
					GhostList.add(ghostData);
				} while(resultSet.next());
			}
			
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return GhostList;
	}
	
	public int AddGhost(GhostDataBean data) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int state = -1;
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"insert into Ranking " +
					"values (?, ?, ?)");

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
	public int UpdateGhost(GhostDataBean data) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int state = -1;
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"update Ghost " +
					"set registrationDate = ?, filePath = ? " +
					"where userNumber = ? and stage = ?");
			pStatement.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
			pStatement.setString(2, data.getFilePath());
			pStatement.setInt(3, data.getUserNumber());
			pStatement.setInt(4, data.getStage());
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
	public boolean isInData (GhostDataBean data) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet= null;
		boolean isInData = false;
		
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"select * " +
					"from Ghost " +
					"where userNumber = ? and stage = ?");
			pStatement.setInt(1, data.getUserNumber());
			pStatement.setInt(2, data.getStage());
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				isInData = true;
			}
			
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		
		return isInData;
	}
}
