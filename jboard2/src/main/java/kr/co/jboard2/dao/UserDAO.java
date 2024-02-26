package kr.co.jboard2.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.SQL;
import kr.co.jboard2.dto.UserDTO;

public class UserDAO extends DBHelper{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	public void insertUser(UserDTO user) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.INSERT_USER);
			psmt.setString(1, user.getUid());
			psmt.setString(2, user.getPass());
			psmt.setString(3, user.getName());
			psmt.setString(4, user.getNick());
			psmt.setString(5, user.getEmail());
			psmt.setString(6, user.getHp());
			psmt.setString(7, user.getZip());
			psmt.setString(8, user.getAddr1());
			psmt.setString(9, user.getAddr2());
			psmt.setString(10, user.getRegip());
			psmt.setString(11, user.getSms());
			
			logger.info("insertUser : "+psmt);
			psmt.executeUpdate();
			closeAll();
		}catch (Exception e) {
			logger.error("insertUser : "+e.getMessage());
		}
	}
	public UserDTO selectUser(String uid) {
		UserDTO user = new UserDTO();
		
		return user;
	}
	
	public List<UserDTO> selectUsers() {
		List<UserDTO> users = new ArrayList<UserDTO>();
		
		return users;
	}
	public void updateUser(UserDTO user) {}
	public void deleteUser(String uid) {}
	public int selectCountUser(String type, String value) {
		
		StringBuilder sql = new StringBuilder(SQL.SELECT_COUNT_USER);
		
		if (type.equals("uid")) {
			sql.append(SQL.WHERE_UID);
		} else if (type.equals("nick")) {
			sql.append(SQL.WHERE_NICK);
		} else if (type.equals("hp"))  {
			sql.append(SQL.WHERE_HP);
		} else if (type.equals("email"))  {
			sql.append(SQL.WHERE_EMAIL);
		}
		int result = 0;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());
			psmt.setString(1, value);
			
			logger.info("selectCountUser : " + psmt);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			closeAll();
		} catch (Exception e) {
			logger.error("selectCountUser : " + e.getMessage());
		}
		return result;
	}
	
}
