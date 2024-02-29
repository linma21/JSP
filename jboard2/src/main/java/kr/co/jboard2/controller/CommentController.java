package kr.co.jboard2.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kr.co.jboard2.dto.ArticleDTO;
import kr.co.jboard2.service.ArticleService;

@WebServlet("/comment.do")
public class CommentController extends HttpServlet{
	private static final long serialVersionUID = 7686345524627400840L;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService service = ArticleService.getInstance();
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		String parent = req.getParameter("parent");
		logger.debug("parent : "+parent);
		int result = service.deleteComment(no, parent);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		
		PrintWriter writer = resp.getWriter();
		writer.print(json);
		//resp.sendRedirect("/jboard2/view.do?no="+parent);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// AJAX POST 데이터 스트림 수신처리
		BufferedReader reader = req.getReader();
		StringBuilder requestBody = new StringBuilder();
		String line;
		while((line = reader.readLine()) != null){
			requestBody.append(line);
		}
		reader.close();
		
		logger.debug("requestBody : "+requestBody);
		String regip = req.getRemoteAddr();
		
		// JSON 파싱
		Gson gson = new Gson();
		ArticleDTO articleDTO = gson.fromJson(requestBody.toString(), ArticleDTO.class);
		articleDTO.setRegip(regip);
		
		// 댓글 입력
		int pk = service.insertComment(articleDTO);
		int parent = articleDTO.getParent();
		
		// 결과 JSON 생성
		JsonObject json = new JsonObject();
		json.addProperty("pk", pk);
		json.addProperty("parent", parent);
		
		// JSON 출력
		PrintWriter writer = resp.getWriter();
		writer.print(json);
		
	}
	
}
