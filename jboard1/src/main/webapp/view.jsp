<%@page import="kr.co.jboard1.dto.UserDTO"%>
<%@page import="kr.co.jboard1.dto.ArticleDTO"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	
    UserDTO sessUserFromSession = (UserDTO) session.getAttribute("sessUser");
	ArticleDAO dao = ArticleDAO.getInstance();
	
	ArticleDTO article = dao.selectArticle(no);
	
	// 글 조회 카운트 업데이트
	
	dao.updateHitCount(no);
%>
<%@ include file="./_header.jsp"%>
<main>
	<section class="view">
		<h3>글보기</h3>
		<form action="#">
			<table>
				<tr>
					<td>제목</td>
					<td><input type="text" name="title" value="<%= article.getTitle() %>">
					</td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td><a href="#"><%= article.getFile() %></a> <span>7회 다운로드</span></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="content"><%= article.getContent()%></textarea></td>
				</tr>

			</table>

			<div>
			<% if(sessUserFromSession != null && sessUserFromSession.getUid().equals(article.getWriter())){ %>
				<a href="/jboard1/proc/deleteProc.jsp?no=<%= article.getNo() %>" class="btnDelete">삭제</a>
				<a href="/jboard1/modify.jsp"class="btnModify">수정</a>
				<% } %>
				<a href="/jboard1/list.jsp" class="btnList">목록</a>
			</div>
		</form>
		<!-- 댓글 리스트 -->
		<section class="commentList">
			<h3>댓글 목록</h3>
			<article class="comment">
				<span> <span>길동이</span> <span>20-05-13</span>
				</span>
				<textarea name="comment" readonly>댓글 샘플입니다.</textarea>
				<div>
					<a href="#">삭제</a> <a href="#">수정</a>
				</div>
			</article>
			<p class="empty">등록된 댓글이 없습니다.</p>
		</section>

		<!-- 댓글 입력 -->
		<section class="commentForm">
			<h3>댓글쓰기</h3>
			<form action="#">
				<textarea name="comment"></textarea>
				<div>
					<a href="#" class="btnCancle">취소</a> <input type="submit"
						class="btnWrite" value="작성완료">
				</div>
			</form>
		</section>
	</section>
</main>
<%@ include file="./_footer.jsp"%>
