package Global;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Management {
	private static Management instance = new Management();

	public static Management getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/CommunityServerDatabase");
    	
		return ds.getConnection();
	}
	
	public String GetUser(int userNumber) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		String userEmail = null;
		
		try{
			connection = getConnection();
			pStatement = connection.prepareStatement(
					"select userID " + 
					"from Users " +
					"where userNumber = ?");
			pStatement.setInt(1, userNumber);
			resultSet = pStatement.executeQuery();
			
			if(resultSet.next()) {
				userEmail = resultSet.getString("userID");
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		
		return userEmail;
	}
	public int GetUser(String userEmail) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		int userNumber = -1;
		
		try{
			connection = getConnection();
			pStatement = connection.prepareStatement(
					"select userNumber " + 
					"from Users " +
					"where userEmail = ?");
			pStatement.setString(1, userEmail);
			resultSet = pStatement.executeQuery();
			
			if(resultSet.next()) {
				userNumber = resultSet.getInt("userNumber");
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return userNumber;
	}
}
