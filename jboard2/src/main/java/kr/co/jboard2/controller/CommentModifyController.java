package kr.co.jboard2.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import kr.co.jboard2.dto.ArticleDTO;
import kr.co.jboard2.service.ArticleService;

@WebServlet("/commentModify.do")
public class CommentModifyController extends HttpServlet{
	private static final long serialVersionUID = 7686345524627400840L;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService service = ArticleService.getInstance();
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/view.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ArticleDTO articleDTO = new ArticleDTO();
		String content = req.getParameter("content");
		String parent = req.getParameter("parent");
		String no = req.getParameter("no");
		articleDTO.setContent(content);
		articleDTO.setParent(parent);
		articleDTO.setNo(no);
		int result = service.updateComment(articleDTO);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		
		resp.setContentType("apllication/json");
		resp.getWriter().write(json.toString());
	}
}
