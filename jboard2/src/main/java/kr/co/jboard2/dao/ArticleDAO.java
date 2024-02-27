package kr.co.jboard2.dao;

import java.io.File;
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
	public List<ArticleDTO> selectArticle(String no) {
		
		List<ArticleDTO> articles = new ArrayList<>();
		List<FileDTO> files = new ArrayList<>();
		FileDTO fileDTO = new FileDTO();
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLE);
			psmt.setString(1, no);
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
				fileDTO.setoName(rs.getString(13));
				fileDTO.setDownload(rs.getInt(14));
				
				files.add(fileDTO);
			}
			
			
			
			closeAll();
		} catch (Exception e) {
			logger.debug("selectArticle : " + e.getMessage());
		}
		return articles;
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
	public void updateArticle(ArticleDTO articleDTO) {}
	public void deleteArticle(int no) {}
}
