package MemberManagement;

import java.sql.*;

import Global.Management;
import work.crypt.SHA256;
import work.crypt.BCrypt;

public class MemberManagementProcessing {
    private static MemberManagementProcessing instance = new MemberManagementProcessing();
	private Management globalManager = Management.getInstance();
    
    public static MemberManagementProcessing getInstance() {
        return instance;
    }
    

    public int Login(MemberDataBean member) {
		Connection connection = null;
        PreparedStatement pStatement = null;
		ResultSet resultSet= null;
		SHA256 sha = SHA256.getInsatnce();
		int state = -1;
		
		try{
			connection = globalManager.getConnection();
            String orgPass = member.getUserPassword();
            String shaPass = sha.getSha256(orgPass.getBytes());
        	
        	pStatement = connection.prepareStatement(
            	"select userPassword "
            	+ "from Users "
            	+ "where userEmail = ?");
        	pStatement.setString(1, member.getUserEmail());
        	resultSet = pStatement.executeQuery();
        	
			if(resultSet.next()){
				String dbPassword= resultSet.getString("userPassword"); 
				if(BCrypt.checkpw(shaPass,dbPassword)) { state = 1; } //Login
				else { state = -2; } //Wrong password
			}
			else { state = -3; } //No ID
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
            if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
            if (connection != null) try { connection.close(); } catch(SQLException ex) {}
        }
		return state;
    }
    
    public int Registration(MemberDataBean member) {
		Connection connection = null;
        PreparedStatement pStatement = null;
        ResultSet resultSet = null;
		SHA256 sha = SHA256.getInsatnce();
		int nextUserNumber = -1;
		int state = -1;
		
		if(CheckInvalidEmail(member)) { 
			state = -2;	//Overlap Email
			return state; 
		}
		
		try{
			connection = globalManager.getConnection();
			
			nextUserNumber = GetNextUserNumber();
			if(nextUserNumber < 0) { 
				state = -3;	//Wrong Access
				return state;
			}

	        String orgPass = member.getUserPassword();
	        String shaPass = sha.getSha256(orgPass.getBytes());
	    	String bcPass = BCrypt.hashpw(shaPass, BCrypt.gensalt());
	    	
			pStatement = connection.prepareStatement(
					"insert into Users "
					+ "values (?,?,?,?)");
			pStatement.setInt(1, nextUserNumber);
			pStatement.setString(2, member.getUserEmail());
			pStatement.setString(3, member.getUserEmail());
			pStatement.setString(4, bcPass);
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
    
    public int ChangeEmail(MemberDataBean member, String newEmail) {
		Connection connection = null;
        PreparedStatement pStatement = null;
    	int state = -1;
    	
		if(!CheckInvalidEmail(member)) { 
			state = -2;	//Overlap Email
			return state; 
		}
    	
    	try{
			connection = globalManager.getConnection();
			
			pStatement = connection.prepareStatement(
					"update Users "
					+ "set userEmail = ?"
					+ "where userEmail = ?");
			pStatement.setString(1, newEmail);
			pStatement.setString(2, member.getUserEmail());
			pStatement.executeUpdate();
			state = 1; //Success change
    	} catch(Exception e) {
    		e.printStackTrace();
    	} finally {
            if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
            if (connection != null) try { connection.close(); } catch(SQLException ex) {}
    	}
    	return state;
    }
    
    public int Withdrawal(MemberDataBean member) {
		Connection connection = null;
        PreparedStatement pStatement = null;
    	int state = -1;
    	
    	try{
			connection = globalManager.getConnection();
			
			pStatement = connection.prepareStatement(
					"delete "
					+ "from Users "
					+ "where userEmail = ?");
			pStatement.setString(1, member.getUserEmail());
			pStatement.executeUpdate();
			state = 1; //Success delete
    	} catch(Exception e) {
    		e.printStackTrace();
    	} finally {
            if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
            if (connection != null) try { connection.close(); } catch(SQLException ex) {}
    	}
    	return state;
    }
    
    boolean CheckInvalidEmail(MemberDataBean member) {
		Connection connection = null;
        PreparedStatement pStatement = null;
        ResultSet resultSet = null;
    	boolean isOverlapped = true;
    	
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select userNumber "
					+ "from Users "
					+ "where userEmail = ?");
			pStatement.setString(1, member.getUserEmail());
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				isOverlapped = true; //Overlap Email
			} else {
				isOverlapped = false; //No overlap Email
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
            if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
            if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
    	return isOverlapped;
    }

    public int LoginWithFacebook(MemberDataBean member) {
		Connection connection = null;
        PreparedStatement pStatement = null;
        ResultSet resultSet = null;
    	int state = -1;
    	
		try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select userID "
					+ "from Users "
					+ "where userID = ?");
			pStatement.setString(1, member.getUserID());
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				state = 1;	//Success login with Facebook
			}
			else {
				if(RegistrationWithFacebook(member.getUserID())) {
					state = 2; //Success Registration with Facebook;
				}
				else {
					state = -2; //Fail Registration with Facebook;
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
            if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
            if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
    	
    	return state;
    }
    boolean RegistrationWithFacebook(String userID) {
		Connection connection = null;
        PreparedStatement pStatement = null;
        boolean state = false;
        int nextUserNumber = -1;
        
		try{
			connection = globalManager.getConnection();
			
			nextUserNumber = GetNextUserNumber();
			if(nextUserNumber < 0) { 
				state = false;	//Wrong Access
				return state;
			}
			
			pStatement = connection.prepareStatement(
					"insert into Users "
					+ "values (?,?,?,?)");
			pStatement.setInt(1, nextUserNumber);
			pStatement.setString(2, userID);
			pStatement.setString(3, "null");
			pStatement.setString(4, "null");
			pStatement.executeUpdate();
			
			state = true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
            if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
            if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		
		return state;
    }
    
    int GetNextUserNumber() {
		Connection connection = null;
        PreparedStatement pStatement = null;
        ResultSet resultSet = null;
    	int nextUserNumber = -1;
    	
    	try{
			connection = globalManager.getConnection();
			pStatement = connection.prepareStatement(
					"select MAX(userNumber) AS nextUserID "
					+ "from Users");
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				nextUserNumber = Integer.parseInt(resultSet.getString("nextUserID"));
				nextUserNumber++;
			}
    	} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
            if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
            if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
    	
    	return nextUserNumber;
    }
}
