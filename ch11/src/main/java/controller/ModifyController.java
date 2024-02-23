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

@WebServlet("/member/modify.do")
public class ModifyController extends HttpServlet{
    private static final long serialVersionUID = 1L;
    
    MemberService service = MemberService.getInstanse();
    // Logback 로거 생성
    private Logger logger = LoggerFactory.getLogger(ModifyController.class);
    
    @Override
    public void init() throws ServletException {
        // 로그 출력
        logger.info("ModifyController - init()...");
        
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    	String uid = req.getParameter("uid");
    	
    	MemberDTO member = service.selectMember(uid);
    	// 로그 레벨 테스트
        logger.error("ModifyController error - doGet()...");
        logger.warn("ModifyController warn - doGet()...");
        logger.info("ModifyController info - doGet()...");
        logger.debug("ModifyController debug - doGet()...");
        logger.trace("ModifyController trace - doGet()...");
        
        req.setAttribute("member", member);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/member/modify.jsp");
        dispatcher.forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	MemberDTO member = new MemberDTO();
    	String uid = req.getParameter("uid");
    	String name = req.getParameter("name");
    	String hp = req.getParameter("hp");
    	String pos = req.getParameter("pos");
    	String dep = req.getParameter("dep");
    	String rdate = req.getParameter("rdate");
    	member.setUid(uid);
    	member.setName(name);
    	member.setHp(hp);
    	member.setPos(pos);
    	member.setDep(dep);
    	member.setRdate(rdate);
    	
    	service.updateMember(member);
    	
    	resp.sendRedirect("/ch11/member/list.do");
    }
}
