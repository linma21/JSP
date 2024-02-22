package controller.user2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User2DTO;
import service.User2Service;

@WebServlet("/user2/modify.do")
public class ModifyController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private User2Service service = User2Service.getInstanse();
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uid = req.getParameter("uid");
			
		User2DTO user = service.selectUser2(uid);
		
		req.setAttribute("user", user);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user2/modify.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User2DTO user = new User2DTO();
		
		String uid	 = req.getParameter("uid");
		String name	 = req.getParameter("name");
		String addr	 = req.getParameter("addr");
		String birth = req.getParameter("birth");
		user.setUid(uid);
		user.setName(name);
		user.setAddr(addr);
		user.setBirth(birth);
		
		service.updateUser2(user);
		
		resp.sendRedirect("/ch10/user2/list.do");
	}
}
