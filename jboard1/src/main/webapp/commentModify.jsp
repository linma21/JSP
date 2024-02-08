<%@page import="com.mysql.cj.protocol.a.NativeConstants.IntegerDataType"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dto.UserDTO"%>
<%@page import="kr.co.jboard1.dto.ArticleDTO"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	// parent 는 원글 번호, no는 댓글 번호
	String no = request.getParameter("no");
	String parent = request.getParameter("parent");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	ArticleDTO article = dao.selectArticle(parent);
	
	
	// 댓글 조회
	List<ArticleDTO> comments = dao.selectComments(parent);
	
	// 수정하기 선택한 댓글 조회
	ArticleDTO modifyComment = ArticleDAO.getInstance().selectComment(no);
%>
<%@ include file="./_header.jsp"%>
<script>
	
	window.onload = function(){
				
		// 댓글 수정 취소
		const btnCancle = document.querySelectorAll('.btnCancle');
		btnCancle.forEach((item)=>{
			
			item.onclick = function(){
				
				const result = confirm('수정 취소 하시겠습니까?');
				
				if(result){
					return true;
				}else{
					return false;
				}
			}
		});	
	}
	
</script>
<main>
	<section class="view">
		<h3>글보기</h3>
		<form action="#">
			<table>
				<tr>
					<td>제목</td>
					<td><input type="text" name="title" value="<%= article.getTitle() %>" readonly></td>
				</tr>
				<% if(article.getFile() > 0){ %>
	            <tr>
	                <td>첨부파일</td>
	                <td>
	                    <a href="#"><%= article.getFile() %></a>
	                    <span>7회 다운로드</span>
	                </td>
	            </tr>
	            <% } %>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="content" readonly><%= article.getContent()%></textarea>
					</td>
				</tr>

			</table>

			<div>
			<% if(sessUser != null && sessUser.getUid().equals(article.getWriter())){ %>
				<a href="/jboard1/proc/deleteProc.jsp?no=<%= article.getNo() %>" class="btnDelete">삭제</a>
				<a href="/jboard1/modify.jsp?no=<%= article.getNo() %>"class="btnModify">수정</a>
				<% } %>
				<a href="/jboard1/list.jsp" class="btnList">목록</a>
			</div>
		</form>
		<!-- 댓글 리스트 -->
		<section class="commentList">
			<h3>댓글 목록</h3>
			<%for(ArticleDTO comment : comments){
				if(comment.getNo() != Integer.parseInt(no)){
				%>
				<article class="comment">
					<span>
						<span><%= comment.getNick() %></span>
						<span><%= comment.getRdate().substring(2, 10) %></span>
					</span>	
					<textarea name="comment" readonly><%= comment.getContent() %></textarea>
					
					<% if(sessUser.getUid().equals(comment.getWriter())){ %>
					<div>
						<a href="/jboard1/proc/commentDelete.jsp?parent=<%= comment.getParent() %>&no=<%= comment.getNo() %>" class="del" >삭제</a>
						<a href="/jboard1/proc/commentModify.jsp?no=<%= comment.getNo() %>">수정</a>
					</div>
					<% } %>
			</article>
				<%} %>
			<%} %>
		</section>

		<!-- 댓글 수정 -->
		<section class="commentForm">
			<h3>댓글수정</h3>
			<form action="/jboard1/proc/commentModifyProc.jsp" name="frmComment" method="post">
				<input type="hidden" name="no" value="<%= no %>">
				<input type="hidden" name="parent" value="<%= parent %>">
				<input type="hidden" name="writer" value="<%= sessUser.getUid() %>">
				<textarea name="content" ><%= modifyComment.getContent() %></textarea>
				<div>
					<a href="/jboard1/view.jsp?no=<%= parent  %>" class="btnCancle">취소</a> 
					<input type="submit" class="btnWrite" value="수정하기">
				</div>
			</form>
		</section>
	</section>
</main>
<%@ include file="./_footer.jsp"%>

