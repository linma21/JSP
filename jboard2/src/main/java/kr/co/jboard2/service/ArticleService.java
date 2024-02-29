package kr.co.jboard2.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.dto.ArticleDTO;
import kr.co.jboard2.dto.FileDTO;
import kr.co.jboard2.dto.PageDTO;

public class ArticleService {
	private static ArticleService instance = new ArticleService();
	
	public static ArticleService getInstance() {
		return instance;
	}
	private ArticleService() {}
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleDAO dao = ArticleDAO.getInstance();
	
	public int insertArticle(ArticleDTO articleDTO) {
		return dao.insertArticle(articleDTO);
	}
	public ArticleDTO selectArticle(String no) {
		return dao.selectArticle(no);
	}
	public List<ArticleDTO> selectComments(String no) {
		return dao.selectComments(no);
	}
	public List<ArticleDTO> selectArticles(int start) {
		return dao.selectArticles(start);
	}
	public PageDTO selectPage(String pg) {
		PageDTO pageDTO = new PageDTO();
		int total = dao.selectCountTotal();
		// 마지막 페이지 번호
		int lastPageNum = 0;
		if(total % 10 ==0) {
			lastPageNum = (total / 10);
		}else {
			lastPageNum = (total / 10) + 1 ;
		}
		// 현재 페이지 번호
		int currentPg = 1;
		
		if(pg != null) {
			currentPg = Integer.parseInt(pg);
		}
		int start = (currentPg -1) * 10;
		
		// 페이지 그룹
		int pageGroupCurrent = (int) Math.ceil(currentPg / 10.0);
		int pageGroupStart = (pageGroupCurrent -1) * 10 +1;
		int pageGroupEnd = (pageGroupCurrent * 10);
		if(pageGroupEnd > lastPageNum) {
			pageGroupEnd = lastPageNum;
		}
		// 페이지 시작 번호
		int articleStartNum = total - start;
		pageDTO.setPageGroupCurrent(pageGroupCurrent);
		pageDTO.setPageGroupStart(pageGroupStart);
		pageDTO.setPageGroupEnd(pageGroupEnd);
		pageDTO.setArticleStartNum(articleStartNum);
		pageDTO.setCurrentPg(currentPg);
		pageDTO.setLastPageNum(lastPageNum);
		pageDTO.setStart(start);
		pageDTO.setTotal(total);
		logger.info("selectPage : "+pageDTO.toString());
		return pageDTO;
	}
	public void updateArticle(ArticleDTO articleDTO) {
		dao.updateArticle(articleDTO);
	}
	public void updateArticleForFileCount(int ano) {
		dao.updateArticleForFileCount(ano);
	}
	public void deleteArticle(String no) {
		dao.deleteArticle(no);
	}
	public int deleteComment(String no, String parent) {
		return dao.deleteComment(no, parent);
	}
	public ArticleDTO fileUpload(HttpServletRequest req) {
		// 파일 경로 설정
		ServletContext ctx = req.getServletContext();
		String uploadPath = ctx.getRealPath("/uploads");
		
		// 파일 업로드 처리 객체 생성
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		// 최대 파일크기 설정
		upload.setSizeMax(1024 * 1024 * 10); // 10MB
		
		// ArticleDTO 생성
		ArticleDTO articleDTO = new ArticleDTO();
		
		// 파일 DTO 리스트 생성
		List<FileDTO> fileDTOs = new ArrayList<>();
		
		// 파일 업로드 스트림 처리
		try {
			List<FileItem> items = upload.parseRequest(req);
			
			// 첨부 파일 갯수
			int count = 0;
			
			for(FileItem item : items) {
				if(item != null && !item.isFormField()) {
					// 첨부 파일인 경우
					if(!item.getName().isEmpty()) {
						
						count++;
						
						String fname = item.getName();
						int idx = fname.lastIndexOf(".");
						String ext = fname.substring(idx);
						
						String saveName = UUID.randomUUID().toString() + ext;
						
						FileDTO fileDTO = new FileDTO();
						fileDTO.setoName(fname);
						fileDTO.setsName(saveName);
						fileDTOs.add(fileDTO);
						
						File file = new File(uploadPath + File.separator + saveName);
						item.write(file);
						
						logger.info("file 주소 : "+file);
					}
				}else {
					// 폼 데이터인 경우
					String fieldName = item.getFieldName();
					String fieldValue = item.getString("UTF-8");
					
					if(fieldName.equals("title")) {
						articleDTO.setTitle(fieldValue);
					}else if(fieldName.equals("content")) {
						articleDTO.setContent(fieldValue);
					}else if(fieldName.equals("writer")) {
						articleDTO.setWriter(fieldValue);
					}else if(fieldName.equals("no")) {
						articleDTO.setNo(fieldValue);
					}
				}
			}
			articleDTO.setFile(count);
		} catch (Exception e) {
			logger.error("fileUpload : "+e.getMessage());
		}
		
		articleDTO.setFileDTOs(fileDTOs);
		return articleDTO;
	}
	public void fileDownload(HttpServletRequest req, HttpServletResponse resp, FileDTO fileDTO) {
		
		try {
			// response 헤더 설정
			resp.setContentType("application/octet-stream");
			resp.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(fileDTO.getoName(), "utf-8"));
			resp.setHeader("Content-Transfer-Encoding", "binary");
			resp.setHeader("Pragma", "no-cache");
			resp.setHeader("Cache-Control", "private");
			
			// response 파일 스트림 작업
			ServletContext ctx = req.getServletContext();
			String uploadsPath = ctx.getRealPath("/uploads");
			
			File file = new File(uploadsPath + File.separator + fileDTO.getsName());
			
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream bos = new BufferedOutputStream(resp.getOutputStream());
			
			while(true){
				int data = bis.read();
				if(data == -1){
					break;
				}
				bos.write(data);
			}
			
			bos.close();
			bis.close();
			
		}catch (Exception e) {
			logger.error("fileDownload : " + e.getMessage());
		}
	}
	public int insertComment(ArticleDTO articleDTO) {
		return dao.insertComment(articleDTO);
	}
	public int updateComment(ArticleDTO articleDTO) {
		return dao.updateComment(articleDTO);
	}
	

}
