<%@page import="kr.co.jboard1.dto.ArticleDTO"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	ArticleDTO article = dao.selectArticle(no);
	
%>
<%@ include file="./_header.jsp" %>
    <main>
      <section class="modify">
        <h3>글수정</h3>
        <form action="/jboard1/proc/modifyProc.jsp" method="post">
	        <input type="hidden" name=no value=<%= article.getNo() %>>
	        <table>
	          <tr>
	            <td>제목</td>
	            <td>
	              <input type="text" name="title" placeholder="제목을 입력하세요." value="<%= article.getTitle() %>">
	            </td>
	          </tr>
	          <tr>
	            <td>내용</td>
	            <td>
	              <textarea name="content"><%= article.getContent() %></textarea>
	            </td>
	          </tr>
	          <tr>
	            <td>첨부</td>
	            <td>
	              <input type="file" name="file" value="<%= article.getFile() %>">
	            </td>
	          </tr>
	        </table>

        <div>
          <a href="/jboard1/view.jsp?no=<%= article.getNo() %>" class="btnCancle">취소</a>
          <input type="submit" class="btnWrite" value="수정완료">
        </div>
      </form>
      </section>
    </main>
<%@ include file="./_footer.jsp" %>