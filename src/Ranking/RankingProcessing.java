package Ranking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Global.Management;

public class RankingProcessing {
	private static RankingProcessing instance = new RankingProcessing();
	private Management globalManager = Management.getInstance();
	
	public static RankingProcessing getInstance() {
		return instance;
	}
	
	public int SetRanking(RankingDataBean data) {
		int state = -1;
		if(IsInData(data)) {
			if(IsUpdatable(data)) {
				state = UpdateRanking(data);
			} else {
				// Can not update because record less than origin
				state = -2;
			}
		} else {
			state = AddRanking(data);
		}
		return state;
	}
	
	public List<RankingDataBean> GetRanking() {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet= null;
		List<RankingDataBean> ranking = null;
		
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"select * " +
					"from Ranking " +
					"order by stage asc, recording asc");
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				ranking = new ArrayList<RankingDataBean>();
				do{
					RankingDataBean rankingBean = new RankingDataBean();
					rankingBean.setUserNumber(resultSet.getInt("userNumber"));
					rankingBean.setStage(resultSet.getInt("stage"));
					rankingBean.setRecording(resultSet.getInt("recording"));
					ranking.add(rankingBean);
				} while(resultSet.next());
			}
			
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return ranking;
	}	
	public List<RankingDataBean> GetUserRanking(String userEmail) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet= null;
		List<RankingDataBean> ranking = null;
		
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"select * " +
					"from Ranking " +
					"where Ranking.userNumber = (select Users.userNumber " +
												"from Users " +
												"where Users.userEmail = ?) " +
					"order by stage asc");
			pStatement.setString(1, userEmail);
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				ranking = new ArrayList<RankingDataBean>();
				do{
					RankingDataBean rankingBean = new RankingDataBean();
					rankingBean.setUserNumber(resultSet.getInt("userNumber"));
					rankingBean.setStage(resultSet.getInt("stage"));
					rankingBean.setRecording(resultSet.getInt("recording"));
					ranking.add(rankingBean);
				} while(resultSet.next());
			}
			
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return ranking;
	}
	
	int AddRanking(RankingDataBean data) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int state = -1;
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"insert into Ranking " +
					"values (?, ?, ?)");
			pStatement.setInt(1, data.getUserNumber());
			pStatement.setInt(2, data.getStage());
			pStatement.setInt(3, data.getRecording());
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
	int UpdateRanking(RankingDataBean data) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		int state = -1;
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"update Ranking " +
					"set recording = ? " +
					"where userNumber = ? and stage = ?");
			pStatement.setInt(1, data.getRecording());
			pStatement.setInt(2, data.getUserNumber());
			pStatement.setInt(3, data.getStage());
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
	boolean IsUpdatable (RankingDataBean data) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet= null;
		boolean isUpdatabe = false;		
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"select recording " +
					"from Ranking " +
					"where userNumber = ? and stage = ?");
			pStatement.setInt(1, data.getUserNumber());
			pStatement.setInt(2, data.getStage());
			resultSet = pStatement.executeQuery();
			if(resultSet.next()) {
				if(resultSet.getInt("recording") > data.getRecording())
					isUpdatabe = true;
			}
		} catch(Exception e) { 
			e.printStackTrace(); 
		} finally {
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (pStatement != null) try { pStatement.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
	return isUpdatabe;
	}
	boolean IsInData (RankingDataBean data) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet= null;
		boolean isInData = false;
		
		try{
			connection = globalManager.getConnection();

			pStatement = connection.prepareStatement(
					"select * " +
					"from Ranking " +
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