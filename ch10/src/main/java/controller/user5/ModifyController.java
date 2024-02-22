package controller.user5;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User5DTO;
import service.User5Service;

@WebServlet("/user5/modify.do")
public class ModifyController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	User5Service service = User5Service.getInstanse();
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String seq= req.getParameter("seq");
		User5DTO user = service.selectUser5(seq);
		
		req.setAttribute("user", user);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user5/modify.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String seq		= req.getParameter("seq");
		String name		= req.getParameter("name");
		String gender	= req.getParameter("gender");
		String age		= req.getParameter("age");
		String addr		= req.getParameter("addr");
		
		User5DTO user = new User5DTO();
		user.setSeq(seq);
		user.setName(name);
		user.setGender(gender);
		user.setAddr(addr);
		user.setAge(age);
		System.out.println("user : "+user);
		service.updateUser5(user);
		resp.sendRedirect("/ch10/user5/list.do");
	}
}
