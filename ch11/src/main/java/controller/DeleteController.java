package controller;

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

import dto.MemberDTO;
import service.MemberService;

@WebServlet("/member/delete.do")
public class DeleteController extends HttpServlet{
    private static final long serialVersionUID = 1L;
    
    MemberService service = MemberService.getInstanse();
    // Logback 로거 생성
    private Logger logger = LoggerFactory.getLogger(DeleteController.class);
    
    @Override
    public void init() throws ServletException {
        // 로그 출력
        logger.info("DeleteController - init()...");
        
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    	String uid = req.getParameter("uid");
    	// 로그 레벨 테스트
        logger.error("DeleteController error - doGet()...");
        logger.warn("DeleteController warn - doGet()...");
        logger.info("DeleteController info - doGet()...");
        logger.debug("DeleteController debug - doGet()...");
        logger.trace("DeleteController trace - doGet()...");
        
        service.deleteMember(uid);
        
        resp.sendRedirect("/ch11/member/list.do");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
}
