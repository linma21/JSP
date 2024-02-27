package kr.co.jboard2.service;

import java.util.List;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.dto.UserDTO;

public class UserService {
	private static UserService instance = new UserService();
	public static UserService getInstance() {
		return instance;
	}
	private UserService() {}
	
	// Logger
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private UserDAO dao = UserDAO.getInstance();
	
	public void insertUser(UserDTO userDTO) {
		dao.insertUser(userDTO);
	}
	public UserDTO selectUser(String uid) {
		return dao.selectUser(uid);
	}
	public UserDTO selectUserForLogin(String uid, String pass) {
		return dao.selectUserForLogin(uid, pass);
	}
	public List<UserDTO> selectUsers() {
		return null;
	}
	
	public void updateUser(UserDTO user) {
		dao.updateUser(user);
	}
	public void deleteUser(String uid) {
		dao.deleteUser(uid);
	}
	public int selectCountUser(String type, String value) {
		return dao.selectCountUser(type, value);
	}
	public void sendEmailCode(HttpSession session, String receiver) {
		
		// 인증코드 생성 (랜덤 6자리)
		int code = ThreadLocalRandom.current().nextInt(100000,1000000);
		session.setAttribute("code", String.valueOf(code));
		// 기본 정보
		String sender = "chlvldzmf96@gmail.com";
		String password = "mxpf jrnq xztf bfrx"; // 앱 비밀번호
		String title = "Jboard2 인증 코드 입니다.";
		String content = "<h1>인증코드는 "+ code + "입니다.</h1>";
		
		// Gmail SMTP 서버 설정
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		try {
		// Gmail SMTP 세션 설정
			Session gmailSession = Session.getInstance(props, new Authenticator(){
				
				@Override
				protected PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication(sender, password);
				}
			});
			// 메일 객체 생성 및 설정
			Message message = new MimeMessage(gmailSession);
			message.setFrom(new InternetAddress(sender, "보내는 사람", "UTF-8"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
			message.setSubject(title);
			message.setContent(content, "text/html;charset=UTF-8");
		
		// 메일 발송
		Transport.send(message);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int confirmEmailCode (HttpSession session, String code) {
		String sessCode = (String) session.getAttribute("code");
		
		if(sessCode.equals(code)) {
			// 성공
			return 1;
		}else {
			return 0;
		}
	}
}
