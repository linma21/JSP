<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.dto.ArticleDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	ArticleDTO article = ArticleDAO.getInstance().selectArticle(no);
	
	int noIntValue = article.getNo();
	no = String.valueOf(noIntValue);
	
		ArticleDAO.getInstance().deleteArticle(no);
		response.sendRedirect("/jboard1/list.jsp");
%>