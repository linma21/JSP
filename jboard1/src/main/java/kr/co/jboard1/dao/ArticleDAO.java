package kr.co.jboard1.dao;

import java.util.ArrayList;
import java.util.List;

import kr.co.jboard1.db.DBHelper;
import kr.co.jboard1.db.SQL;
import kr.co.jboard1.dto.ArticleDTO;

public class ArticleDAO extends DBHelper {
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	public void insertArticle(ArticleDTO article) {
		
		try {
			conn = getConnection();
			
			psmt = conn.prepareStatement(SQL.INSERT_ARTICLE);
			psmt.setString(1, article.getTitle());
			psmt.setString(2, article.getContent());
			psmt.setString(3, article.getWriter());
			psmt.setString(4, article.getRegip());
			
			psmt.executeUpdate();
			
			closeAll();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public ArticleDTO selectArticle(int no) {
		return null;
	}
	public List<ArticleDTO> selectArticles() {
		List<ArticleDTO> articles = new ArrayList<>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_ARTICLE_LIST);
			
			ArticleDTO dto = null;
			while(rs.next()) {
				dto = new ArticleDTO();
				dto.setNo(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setComment(rs.getInt(3));
				dto.setNick(rs.getString(4));
				dto.setRdate(rs.getTimestamp(5));
				dto.setHit(rs.getInt(6));
				
				articles.add(dto);
			}
			closeAll();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return articles;
	}
	public void updateArticle(ArticleDTO article) {}
	public void deleteArticle(int no) {}
	
}
