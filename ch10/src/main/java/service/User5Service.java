package service;

import java.util.List;

import dao.User5DAO;
import dto.User5DTO;


public class User5Service {
	private static User5Service instanse = new User5Service();
	public static User5Service getInstanse() {
		return instanse;
	}
	private User5Service() {}
	
	private User5DAO dao = User5DAO.getInstance();
	
		public void insertUser5(User5DTO user) {
			dao.insertUser5(user);
		}
		public User5DTO selectUser5(String uid) {
			return dao.selectUser5(uid);
		}
		public List<User5DTO> selectUser5s() {
			return dao.selectUser5s();
		}
		public void updateUser5(User5DTO user) {
			dao.updateUser5(user);
		}
		public void deleteUser5(String uid) {
			dao.deleteUser5(uid);
		}
}
