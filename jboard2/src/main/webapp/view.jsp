<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="_header.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
window.onload = function() {
	// 원글 삭제
	const btnRemove = document.querySelector('.btnRemove');
	if(btnRemove != null){
		btnRemove.onclick = function() {
			const result = confirm('게시글을 삭제하시겠습니까?');
				
			if(result){
				return true;
			}else{
				return false;
			}
		}
	}
	// 원글 수정
	const btnModify = document.querySelector('.btnModify');
	if(btnModify != null){
		btnModify.onclick = function() {
			const result = confirm('게시글을 수정하시겠습니까?');
				
			if(result){
				return true;
			}else{
				return false;
			}
		}
	}
	// 댓글 등록
	
	const commentList = document.getElementsByClassName('commentList')[0];
	const btnSubmit = document.commentForm.submit;
	const form = document.commentForm;
	
	// textarea 비우기
	function clearTextarea() {
		const commentArea = document.getElementById('commentArea');
	    if (commentArea) {
	    	commentArea.value = '';
	    }
	}
	btnSubmit.onclick = function(e) {
		e.preventDefault();
		
		const parent = form.parent.value;
		const writer = form.writer.value;
		const content = form.content.value;
		
		const jsonData = {
				"parent":parent,
				"writer":writer,
				"content":content
		};
		fetch('/jboard2/comment.do',{
				method : 'POST',
				headers : {"content-type" : "application/json"},
				body : JSON.stringify(jsonData)
		})
			.then(response=>response.json())
			.then((data)=>{
				console.log("data : "+data);
				if(data.pk > 0){
					
					alert(' 댓글 등록 성공!');
					clearTextarea();
					
					const empty = document.getElementById('empty');
					if(empty){
						empty.parentNode.removeChild(empty);
					}
					const today = new Date();
					const year = today.getFullYear();
					const month = today.getMonth() + 1;
					const date = today.getDate();
			        // 태그 문자열 생성(JSP 표현언어와 Javascipt 템플릿 문자열의 간섭으로 \로 이스케이프 처리)
			        const commentArticle = `<form action="#">
									            <article>
									                <span class="nick">${sessUser.nick}</span>
									                <span class="date">\${year}-\${month}-\${date}</span>
									                <textarea class="content" name="content" readonly>\${content}</textarea>
									                    <div>
									                        <a href="#" data-no="\${data.pk}" data-parent="\${data.parent}" class="remove">삭제</a>
									                        <a href="#" class="modify">수정</a>
									                    </div>
									            </article>
								            </form>`;
			        console.log(commentArticle);
			        
			        // 태그 문자열 삽입
			        commentList.insertAdjacentHTML('beforeend', commentArticle);
			    }
			})
			.catch((err)=>{
				console.log(err);
			})
	}
	
	// 댓글 삭제 (동적 이벤트 처리)
	document.addEventListener('click', function(e) {
		
		
		if(e.target.classList == 'remove'){
			e.preventDefault();
			const result = confirm('댓글을 삭제하시겠습니까?');
			
			if(result){
				const form	 = e.target.closest('form');
				const no	  = e.target.dataset.no;
				const parent  = e.target.dataset.parent;
				
				fetch('/jboard2/comment.do?no='+no+'&parent='+parent)
					.then(response=>response.json())
					.then((data)=>{
						console.log('data : '+data);
						if(data.result > 0){
							form.parentNode.removeChild(form);
							alert('삭제 완료!');
						}
					})
					.catch((err)=>{
						console.log(err);
					})
				return true;
			}else{
				return false;
			}
		}
	});
	
	// 댓글 수정
	const modify = document.querySelectorAll('.modify');
	modify.forEach((item)=>{
		item.onclick = function(e) {
			e.preventDefault();
			if(this.innerText == '수정'){
				
				this.innerText = '수정완료';
				const textarea = this.parentElement.previousElementSibling;
				textarea.readOnly = false;
				textarea.style.background = 'white';
				textarea.focus();
			}else{
				const form = this.closest('form');
				//form.submit();
				const no	  = form.no.value;
				const parent  = form.parent.value;
				const content = form.content.value;
				
				const jsonData = {
					"no"	 :no,
					"parent" :parent,
					"content":content
				};
				
				$.ajax ({
				    method: 'POST',
				    url   : '/jboard2/commentModify.do',
				    data  : jsonData,
				    success: function(data){
				        console.log('data : ' + data);
				        
				        if(data.result > 0){
				            alert('수정 성공!');
				        }
				    }
				});

				
				this.innerText = '수정';
				const textarea = this.parentElement.previousElementSibling;
				textarea.readOnly = true;
				textarea.style.background = '#f9f9f9';
			}
		}
	});
}
</script>
        <main id="board">
            <section class="view">
                
                <table border="0">
                    <caption>글보기</caption>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" name="title" value="${articleDTO.title}" readonly/></td>
                    </tr>
                    <c:if test="${articleDTO.file > 0}">
                    <tr>
                        <th>파일</th>
                        <td>
	                        <c:forEach var="file" items="${articleDTO.fileDTOs}">
	                       	 	<p><a href="/jboard2/fileDownload.do?fno=${file.fno}">${file.oName}</a>&nbsp;<span>${file.download}</span>회 다운로드</p>
	                       	</c:forEach> 	
                        </td>
                    </tr>
                    </c:if>
                    <tr>
                        <th>내용</th>
                        <td>
                            <textarea name="content" readonly>${articleDTO.content}</textarea>
                        </td>
                    </tr>                    
                </table>
                
                <div>
                	<c:if test="${articleDTO.writer == sessionScope.sessUser.uid}">
	                    <a href="/jboard2/delete.do?no=${articleDTO.no}" class="btn btnRemove">삭제</a>
	                    <a href="/jboard2/modify.do?no=${articleDTO.no}" class="btn btnModify">수정</a>
                    </c:if>
                    <a href="/jboard2/list.do" class="btn btnList">목록</a>
                </div>

                <!-- 댓글목록 -->
                <c:if test="${!empty comments}">
				    <section class="commentList">
				        <h3>댓글목록</h3> 
				        <c:forEach var="comment" items="${comments}">
				        	<form action="#">
				        	<input type="hidden" name="no" value="${comment.no}">
				        	<input type="hidden" name="parent" value="${comment.parent}">
					            <article>
					                <span class="nick">${comment.nick}</span>
					                <span class="date">${comment.rdate.substring(0, 10)}</span>
					                <textarea class="content" name="content" readonly >${comment.content}</textarea>
					                <c:if test="${comment.writer == sessionScope.sessUser.uid}">                        
					                    <div>
					                        <a href="#" data-no="${comment.no}" data-parent="${comment.parent}" class="remove">삭제</a>
					                        <a href="#" class="modify">수정</a>
					                    </div>
					                </c:if>
					            </article>
				            </form>
				        </c:forEach>
				    </section>
				</c:if>
				
				<c:if test="${empty comments}">
				    <section class="commentList">
				        <h3>댓글목록</h3>
				        <article id="empty">
				            <p class="empty">등록된 댓글이 없습니다.</p>
				        </article>
				    </section>
				</c:if>


                <!-- 댓글쓰기 -->
                <section class="commentForm">
                    <h3>댓글쓰기</h3>
                    <form name ="commentForm" action="#"  method="post">
                    	<input type="hidden" name ="parent" value="${articleDTO.no}">
                    	<input type="hidden" name ="writer" value="${sessionScope.sessUser.uid}">
                        <textarea id="commentArea" name="content" placeholder="댓글내용 입력"></textarea>
                        <div>
                            <a href="#" class="btn btnCancel">취소</a>
                            <input type="submit" name="submit" value="작성완료" class="btn btnComplete"/>
                        </div>
                    </form>
                </section>

            </section>
        </main>
<%@ include file="_footer.jsp" %>