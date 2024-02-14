<%@page import="java.net.URLEncoder"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.dto.ArticleDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String no 		= request.getParameter("no");
	String title	= request.getParameter("title");
	String content 	= request.getParameter("content");
	String file 	= request.getParameter("file");
	String searchType = request.getParameter("searchType");
	String keyword = request.getParameter("keyword");
	String pg = request.getParameter("pg");

	ArticleDTO article = new ArticleDTO();
	article.setNo(no);
	article.setTitle(title);
	article.setContent(content);
	if(file != null && !file.isEmpty()){
		article.setFile(file);
	}	
			
	ArticleDAO.getInstance().updateArticle(article);
	
	// 동적 파라미터 생성
		String params ="&pg="+ pg;
		
		if(searchType != null && keyword != null){
			String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
			params += "&searchType="+searchType +"&keyword="+encodedKeyword;
		}
		
		response.sendRedirect("/jboard1/view.jsp?no=" + no + params);
%>