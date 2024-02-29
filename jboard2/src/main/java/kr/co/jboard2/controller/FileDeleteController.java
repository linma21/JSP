package kr.co.jboard2.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.service.FileService;

@WebServlet("/fileDelete.do")
public class FileDeleteController extends HttpServlet{
	private static final long serialVersionUID = 3454011666393788527L;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private FileService service = FileService.getInstance();
	private ArticleService articleService = ArticleService.getInstance();
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 파일	번호 수신
		String fno = req.getParameter("fno");
		
		// 실제 업로드 파일 삭제를 위한 저장명 
		//String sname = service.selectFileForSname(fno);
		
		int ano = service.deleteFile(req, fno);
		articleService.updateArticleForFileCount(ano);
		
		// ajax로 요청했기 때문에 결과 JSON 출력(결과값은 파일의 글번호)
		JsonObject json = new JsonObject();
		json.addProperty("result", ano);
		// JSON 출력
		PrintWriter writer = resp.getWriter();
		writer.print(json);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
