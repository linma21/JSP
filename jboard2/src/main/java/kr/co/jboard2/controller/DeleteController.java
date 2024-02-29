package kr.co.jboard2.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.service.FileService;

@WebServlet("/delete.do")
public class DeleteController extends HttpServlet{
	private static final long serialVersionUID = -9040060042780306760L;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService service = ArticleService.getInstance();
	private FileService fileService = FileService.getInstance();
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		
		// 파일 먼저 삭제
		fileService.deleteArticleFile(no);
		// 게시글 삭제
		service.deleteArticle(no);
		
		resp.sendRedirect("/jboard2/list.do");
	}
}
