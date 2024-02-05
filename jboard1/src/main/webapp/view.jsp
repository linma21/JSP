<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp"%>
<main>
	<section class="view">
		<h3>글보기</h3>
		<form action="#">
			<table>
				<tr>
					<td>제목</td>
					<td><input type="text" name="title" placeholder="제목을 입력하세요.">
					</td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td><a href="#">2020년 상반기 매출자료.xls</a> <span>7회 다운로드</span></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="content">내용 샘플입니다.</textarea></td>
				</tr>

			</table>

			<div>
				<a href="#" class="btnDelete">삭제</a> <a href="./modify.html"
					class="btnModify">수정</a> <a href="./list.html" class="btnList">목록</a>
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