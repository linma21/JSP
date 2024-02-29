package kr.co.jboard2.dao;

import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.SQL;
import kr.co.jboard2.dto.ArticleDTO;
import kr.co.jboard2.dto.FileDTO;

public class ArticleDAO extends DBHelper{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	public int insertArticle(ArticleDTO articleDTO) {
		int pk = 0;
		try {
			conn = getConnection();
			
			// INSERT가 실행되고 자동으로 생성되는 PK값을 리턴하는 옵션
			psmt = conn.prepareStatement(SQL.INSERT_ARTICLE, Statement.RETURN_GENERATED_KEYS);
			psmt.setString(1, articleDTO.getTitle());
			psmt.setString(2, articleDTO.getContent());
			psmt.setInt(3, articleDTO.getFile());
			psmt.setString(4, articleDTO.getWriter());
			psmt.setString(5, articleDTO.getRegip());
			logger.info("insertArticle : " + psmt);
			
			// INSERT 실행
			psmt.executeUpdate();
			
			// 생성된 PK 가져오기
			rs = psmt.getGeneratedKeys();
			if(rs.next()) {
				pk = rs.getInt(1);
			}
			closeAll();
		}catch (Exception e) {
			logger.debug("insertArticle : "+e.getMessage());
		}
		return pk;
	}
	public ArticleDTO selectArticle(String no) {
		
		ArticleDTO articleDTO = null;
		List<FileDTO> files = new ArrayList<>();
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLE);
			psmt.setString(1, no);
			logger.info("selectArticle : " + psmt);
			psmtEtc1 = conn.prepareStatement(SQL.UPDATE_HIT_COUNT);
			psmtEtc1.setString(1, no);
			logger.info("selectArticle : " + psmtEtc1);
			rs = psmt.executeQuery();
			psmtEtc1.executeUpdate();
			
			conn.commit();
			while(rs.next()) {
				
				// 글 하나당 파일이 여러개일 경우 글객체(ArticleDTO)는 여러개 생성할 필요가 없기 때문에 1개만 생성 되도록 조건처리
				if(articleDTO == null) {
					articleDTO = new ArticleDTO();
					articleDTO.setNo(rs.getInt(1));
					articleDTO.setParent(rs.getInt(2));
					articleDTO.setComment(rs.getInt(3));
					articleDTO.setCate(rs.getString(4));
					articleDTO.setTitle(rs.getString(5));
					articleDTO.setContent(rs.getString(6));
					articleDTO.setFile(rs.getInt(7));
					articleDTO.setHit(rs.getInt(8));
					articleDTO.setWriter(rs.getString(9));
					articleDTO.setRegip(rs.getString(10));
					articleDTO.setRdate(rs.getString(11));
				}
				
				FileDTO fileDTO = new FileDTO();
				fileDTO.setFno(rs.getInt(12));
				fileDTO.setAno(rs.getInt(13));
				fileDTO.setoName(rs.getString(14));
				fileDTO.setsName(rs.getString(15));
				fileDTO.setDownload(rs.getInt(16));
				fileDTO.setRdate(rs.getString(17));
				files.add(fileDTO);
			}
			
			articleDTO.setFileDTOs(files);
			
			closeAll();
			
		}catch (Exception e) {
			logger.error("selectArticle : " + e.getMessage());
		}
		
		return articleDTO;
	}
	public List<ArticleDTO> selectComments(String no) {
		List<ArticleDTO> comments = new ArrayList<>();
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_COMMENTS);
			psmt.setString(1, no);
			logger.info("selectComment : " + psmt);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleDTO articleDTO = new ArticleDTO();
					articleDTO.setNo(rs.getInt(1));
					articleDTO.setParent(rs.getInt(2));
					articleDTO.setComment(rs.getInt(3));
					articleDTO.setCate(rs.getString(4));
					articleDTO.setTitle(rs.getString(5));
					articleDTO.setContent(rs.getString(6));
					articleDTO.setFile(rs.getInt(7));
					articleDTO.setHit(rs.getInt(8));
					articleDTO.setWriter(rs.getString(9));
					articleDTO.setRegip(rs.getString(10));
					articleDTO.setRdate(rs.getString(11));
					articleDTO.setNick(rs.getString(12));
					comments.add(articleDTO);
			}
			closeAll();
		} catch (Exception e) {
			logger.debug("selectComment : " + e.getMessage());
		}
		return comments;
	}
	public List<ArticleDTO> selectArticles(int start) {
		List<ArticleDTO> articleDTOs = new ArrayList<>();
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLES + SQL.SELECT_ARTICLES_ORDER_LIMIT);
			psmt.setInt(1, start);
			rs = psmt.executeQuery();
			logger.info("selectArticles : " + psmt);
			while(rs.next()) {
				ArticleDTO articleDTO = new ArticleDTO();
				articleDTO.setNo(rs.getInt(1));
				articleDTO.setParent(rs.getInt(2));
				articleDTO.setComment(rs.getInt(3));
				articleDTO.setCate(rs.getString(4));
				articleDTO.setTitle(rs.getString(5));
				articleDTO.setContent(rs.getString(6));
				articleDTO.setFile(rs.getInt(7));
				articleDTO.setHit(rs.getInt(8));
				articleDTO.setWriter(rs.getString(9));
				articleDTO.setRegip(rs.getString(10));
				articleDTO.setRdate(rs.getString(11));
				articleDTO.setNick(rs.getString(12));
				
				articleDTOs.add(articleDTO);
			}
			closeAll();
		}catch (Exception e) {
			logger.debug("selectArticles : " + e.getMessage());
		}
		return articleDTOs;
	}
	public int selectCountTotal() {
		int total =0;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_COUNT_TOTAL);
			logger.info("selectCountTotal : " + stmt);
			if(rs.next()) {
				total = rs.getInt(1);
			}
			closeAll();
		}catch (Exception e) {
			logger.debug("selectCountTotal : " + e.getMessage());
		}
		return total;
	}
	public void updateArticle(ArticleDTO articleDTO) {
		logger.info("updateArticle : " + articleDTO.toString());
		try {
			conn = getConnection();
			
			psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE);
			psmt.setString(1, articleDTO.getTitle());
			psmt.setString(2, articleDTO.getContent());
			psmt.setInt(3, articleDTO.getFile());
			psmt.setInt(4, articleDTO.getNo());
			logger.info("updateArticle : " + psmt);
			psmt.executeUpdate();
			
			closeAll();
		}catch (Exception e) {
			logger.debug("updateArticle : "+e.getMessage());
		}
	}
	public void updateArticleForFileCount(int ano) {
		try {
			conn = getConnection();
			
			psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE_FOR_FILE_COUNT);
			psmt.setInt(1, ano);
			logger.info("updateArticleForFileCount : " + psmt);
			psmt.executeUpdate();
			
			closeAll();
		}catch (Exception e) {
			logger.debug("updateArticleForFileCount : "+e.getMessage());
		}
	}
	public void deleteArticle(String no) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			logger.info("deleteArticle : " + psmt);
			psmt.executeUpdate();
			closeAll();
		}catch (Exception e) {
			logger.debug("deleteArticle :" + e.getMessage());
		}
	}
	public int insertComment(ArticleDTO articleDTO) {
		int result =0;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			psmt = conn.prepareStatement(SQL.INSERT_COMMENT);
			psmt.setInt(1, articleDTO.getParent());
			psmt.setString(2, articleDTO.getContent());
			psmt.setString(3, articleDTO.getWriter());
			psmt.setString(4, articleDTO.getRegip());
			logger.info("insertComment : " + psmt);
			psmtEtc1 = conn.prepareStatement(SQL.UPDATE_COMMENT_PLUS);
			psmtEtc1.setInt(1, articleDTO.getParent());
			logger.info("insertComment : " + psmtEtc1);
			result = psmt.executeUpdate();
			psmtEtc1.executeUpdate();
			conn.commit();
			
			closeAll();
		}catch (Exception e) {
			logger.debug("insertComment : "+ e.getMessage());
		}
		return result;
	}
	public int updateComment(ArticleDTO articleDTO) {
		int result =0;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_COMMENT);
			psmt.setString(1, articleDTO.getContent());
			psmt.setInt(2, articleDTO.getNo());
			logger.info("updateComment : " + psmt);
			result = psmt.executeUpdate();
			closeAll();
		}catch (Exception e) {
			logger.debug("updateComment : "+ e.getMessage());
		}
		return result;
	}
	public void deleteComment(String no, String parent) {
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			psmt = conn.prepareStatement(SQL.DELETE_COMMENT);
			psmt.setString(1, no);
			logger.info("deleteArticle : " + psmt);
			psmtEtc1 = conn.prepareStatement(SQL.UPDATE_COMMENT_MINUS);
			psmt.setString(1, parent);
			logger.info("deleteArticle : " + psmtEtc1);
			psmt.executeUpdate();
			psmtEtc1.executeUpdate();
			conn.commit();
			
			closeAll();
		}catch (Exception e) {
			logger.debug("deleteArticle :" + e.getMessage());
		}
	}
}
