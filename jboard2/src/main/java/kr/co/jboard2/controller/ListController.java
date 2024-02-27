package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dto.ArticleDTO;
import kr.co.jboard2.dto.PageDTO;
import kr.co.jboard2.service.ArticleService;

@WebServlet("/list.do")
public class ListController extends HttpServlet{
	private static final long serialVersionUID = 7787169292569437228L;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService service = ArticleService.getInstance();
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pg = req.getParameter("pg");
		PageDTO pageDTO = service.selectPage(pg);
		
		
		// 현재 페이지 번호
		int currentPage = pageDTO.getCurrentPg();
				
		// 전체 게시물 갯수 
		int total = pageDTO.getTotal();
				
		// 마지막 페이지 번호
		int lastPageNum = pageDTO.getLastPageNum();
			
		// 페이지 그룹 start, end 번호
		int pageGroupStart = pageDTO.getPageGroupStart();
		int pageGroupEnd = pageDTO.getPageGroupEnd();
				
		// 페이지 시작번호
		int pageStartNum = pageDTO.getArticleStartNum();
				
		// 시작 인덱스
		int start = pageDTO.getStart();
				
		List<ArticleDTO> articles = service.selectArticles(start);
		
		// view 공유 참조
		req.setAttribute("articles", articles);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("lastPageNum", lastPageNum);
		req.setAttribute("pageGroupStart", pageGroupStart);
		req.setAttribute("pageGroupEnd", pageGroupEnd);
		req.setAttribute("pageStartNum", pageStartNum+1);
			
		RequestDispatcher dispatcher = req.getRequestDispatcher("/list.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
