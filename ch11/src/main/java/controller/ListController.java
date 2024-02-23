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

@WebServlet("/member/list.do")
public class ListController extends HttpServlet{
    private static final long serialVersionUID = 1L;
    
    MemberService service = MemberService.getInstanse();
    // Logback 로거 생성
    private Logger logger = LoggerFactory.getLogger(ListController.class);
    
    @Override
    public void init() throws ServletException {
        // 로그 출력
        logger.info("ListController - init()...");
        
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    	List<MemberDTO> members = service.selectMembers();
    	req.setAttribute("members", members);
    	// 로그 레벨 테스트
        logger.error("ListController error - doGet()...");
        logger.warn("ListController warn - doGet()...");
        logger.info("ListController info - doGet()...");
        logger.debug("ListController debug - doGet()...");
        logger.trace("ListController trace - doGet()...");
        
        RequestDispatcher dispatcher = req.getRequestDispatcher("/member/list.jsp");
        dispatcher.forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
}
