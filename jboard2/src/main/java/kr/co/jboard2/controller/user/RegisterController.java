package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dto.UserDTO;
import kr.co.jboard2.service.UserService;

@WebServlet("/user/register.do")
public class RegisterController extends HttpServlet{
	private static final long serialVersionUID = -3937831513474791716L;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private UserService service = UserService.getInstance();
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/register.jsp");
		dispatcher.forward(req, resp);
	}@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		UserDTO user	= new UserDTO();
		String uid		= req.getParameter("uid");
		String pass1	= req.getParameter("pass1");
		String name		= req.getParameter("name");
		String nick		= req.getParameter("nick");
		String email	= req.getParameter("email");
		String hp		= req.getParameter("hp");
		String sms		= req.getParameter("sms");
		String addr1	= req.getParameter("addr1");
		String addr2	= req.getParameter("addr2");
		String zip		= req.getParameter("zip");
		
		user.setUid(uid);
		user.setPass(pass1);
		user.setName(name);
		user.setNick(nick);
		user.setEmail(email);
		user.setHp(hp);
		user.setSms(sms);
		user.setZip(zip);
		user.setAddr1(addr1);
		user.setAddr2(addr2);
		user.setRegip(req.getRemoteAddr());
		logger.debug(user.toString());
		service.insertUser(user);
		resp.sendRedirect("/jboard2/user/login.do");
	}
}
