<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dto.ArticleDTO"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp"%>
<main>
	<section class="list">
		<h3>글 목록</h3>
		<article>
			<table>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>조회</th>
				</tr>
				<%  
					List<ArticleDTO> articles =ArticleDAO.getInstance().selectArticles();
					for(ArticleDTO dto : articles){
				%>
				<tr>
					<td><%=dto.getNo() %></td>
					<td><a href="#"><%=dto.getTitle() %></a>[<%=dto.getComment()%>]</td>
					<td><%=dto.getNick() %></td>
					<td><%=new SimpleDateFormat("yy-MM-dd").format(dto.getRdate()) %></td>
					<td><%=dto.getHit() %></td>
				</tr>
				<% } %>
			</table>
		</article>

		<!-- 페이지네이션 -->
		<div class="paging">
			<a href="#" class="prev">이전</a> <a href="#" class="num current">1</a>
			<a href="#" class="num">2</a> <a href="#" class="num">3</a> <a
				href="#" class="num">4</a> <a href="#" class="num">5</a> <a href="#"
				class="prev">다음</a>

		</div>
		<div>
			<a href="/jboard1/write.jsp" class="btnWrite">글쓰기</a>
		</div>
	</section>
</main>
<%@ include file="./_footer.jsp"%>