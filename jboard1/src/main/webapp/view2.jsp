<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dto.UserDTO"%>
<%@page import="kr.co.jboard1.dto.ArticleDTO"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	ArticleDTO article = dao.selectArticle(no);
	
	// 글 조회 카운트 업데이트
	dao.updateHitCount(no);
	
	// 댓글 조회
	List<ArticleDTO> comments = dao.selectComments(no);
%>
<%@ include file="./_header.jsp"%>
<script>
	
	window.onload = function(){
		// 원글 삭제
		const btnDelete = document.querySelector('.btnDelete');
		btnDelete.onclick = ()=>{
			
			if(confirm('정말 삭제 하시겠습니까?')){
				return true;
			}else{
				return false;
			}
		}
		
		
		// 댓글 작성 취소
		const btnCancle = document.getElementsByClassName('btnCancle')[0];
		
		btnCancle.onclick = function(e){
			e.preventDefault();
			document.frmComment.reset(); // 폼 초기화
		}
		// 댓글 삭제
		const del = document.querySelectorAll('.del');
		del.forEach((item)=>{
			
			item.onclick = function(){
				
				const result = confirm('정말 삭제 하시겠습니까?');
				
				if(result){
					return true;
				}else{
					// 표준 이벤트 모델(addEventListener)은 작업 취소 안됨
					// 작업 취소
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
	                    <a href="#">2020년 상반기 매출자료.xls</a>
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
			<%for(ArticleDTO comment : comments){ %>
			<article class="comment">
				<span>
					<span><%= comment.getNick() %></span>
					<span><%= comment.getRdate().substring(2, 10) %></span>
				</span>	
				<textarea name="comment" readonly><%= comment.getContent() %></textarea>
				
				<% if(sessUser.getUid().equals(comment.getWriter())){ %>
				<div>
					<a href="/jboard1/proc/commentDelete.jsp?parent=<%= comment.getParent() %>&no=<%= comment.getNo() %>" class="del" >삭제</a>
					<a href="/jboard1/commentModify.jsp?parent=<%= comment.getParent() %>&no=<%= comment.getNo() %>" class="modify">수정</a>
				</div>
				<% } %>
			</article>
			<%} %>
			
			<% if(comments.isEmpty()){ %>
			<p class="empty">등록된 댓글이 없습니다.</p>
			<% } %>
		</section>

		<!-- 댓글 입력 -->
		<section class="commentForm">
			<h3>댓글쓰기</h3>
			<form action="/jboard1/proc/commentInsert.jsp" name="frmComment" method="post">
				<input type="hidden" name="parent" value="<%= no %>">
				<input type="hidden" name="writer" value="<%= sessUser.getUid() %>">
				<textarea name="content"></textarea>
				<div>
					<a href="#" class="btnCancle">취소</a> 
					<input type="submit" class="btnWrite" value="작성완료">
				</div>
			</form>
		</section>
	</section>
</main>
<%@ include file="./_footer.jsp"%>

