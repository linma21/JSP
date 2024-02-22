package controller.user4;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User4DTO;
import service.User4Service;

@WebServlet("/user4/modify.do")
public class ModifyController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	User4Service service = User4Service.getInstanse();
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");
		
		User4DTO user = service.selectUser4(uid);
		
		System.out.println(user.getUid());
		req.setAttribute("user", user);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user4/modify.jsp");
		dispatcher.forward(req, resp);
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User4DTO user = new User4DTO();
		String uid		= req.getParameter("uid");
		String name		= req.getParameter("name");
		String gender	= req.getParameter("gender");
		String age		= req.getParameter("age");
		String hp		= req.getParameter("hp");
		String addr		= req.getParameter("addr");
		user.setUid(uid);
		user.setName(name);
		user.setGender(gender);
		user.setAge(age);
		user.setHp(hp);
		user.setAddr(addr);
		service.updateUser4(user);
		resp.sendRedirect("/ch10/user4/list.do");
	}

}
