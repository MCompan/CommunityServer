package FriendsManagement;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Global.Management;

public class FriendsProcessing {
	private static FriendsProcessing instance = new FriendsProcessing();
	private Management globalManager = Management.getInstance();
	
	public static FriendsProcessing getInstance() {
		return instance;
	}
	
	public int AddFriend(int userNumber, String friendsEmail) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int state = -1;
		try{
			connection = globalManager.getConnection();
			
			pStatement = connection.prepareStatement(
					"insert into Friends " +
					"values (?, (select userNumber " +
								"from Users " +
								"where userEmail = ?))");
			pStatement.setInt(1, userNumber);
			pStatement.setString(2, friendsEmail);
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
	
	public int DeleteFriend(int userNumber, String friendsEmail) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int state = -1;
		try{
			connection = globalManager.getConnection();
			
			pStatement = connection.prepareStatement(
					"delete from Friends " +
					"where Friends.userNumber = ? and friendNumber = (select Users.userNumber " +
																	 "from Users " +
																	 "where Users.userEmail = ?)");
			pStatement.setInt(1, userNumber);
			pStatement.setString(2, friendsEmail);
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
	
	public List<String> GetFriends(int userNumber) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet= null;
		List<String> friends = null;

		try{
			connection = globalManager.getConnection();
			
			pStatement = connection.prepareStatement(
					"select Users.userEmail " +
					"from Users " +
					"where Users.userNumber in (select Friends.friendNumber " +
												"from Friends " +
												"where Friends.userNumber = ?)");
			pStatement.setInt(1, userNumber);
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				friends = new ArrayList<String>();
				do {
					friends.add(resultSet.getString("userEmail"));
				} while(resultSet.next());
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		
		return friends;
	}
}
