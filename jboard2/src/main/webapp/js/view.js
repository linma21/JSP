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
				if(data.result > 0){
					
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
									                        <a href="#" data-no="\${data.no}" data-parent="\${data.parent}" class="remove">삭제</a>
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
	
	// 댓글 삭제
	//const remove = document.getElementsByClassName('.remove')[0]; 첫 번째 remove 버튼만 선택
	const remove = document.querySelectorAll('.remove');
	remove.forEach((item)=>{
		item.onclick = function() {
			const result = confirm('댓글을 삭제하시겠습니까?');
			
			if(result){
				const form = this.closest('form');
				const no	  = this.dataset.no;
				const parent  = this.dataset.parent;
				
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