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
	public ArticleDTO selectArticle(String no) {
		ArticleDTO article = null;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLE);
			psmt.setString(1,no);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				article = new ArticleDTO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setWriter(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11));
				
			}
			closeAll();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return article;
	}

	public List<ArticleDTO> selectArticles(int start) {
		
		List<ArticleDTO> articles = new ArrayList<>();
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLES + SQL.SELECT_ARTICLES_ORDER_LIMIT);
			psmt.setInt(1, start);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleDTO article = new ArticleDTO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setWriter(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11));
				article.setNick(rs.getString(12));
				articles.add(article);
			}
			closeAll();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return articles;
	}
	public List<ArticleDTO> selectArticlesForSearch(String searchType, String keyword, int start) {
	    
	    List<ArticleDTO> articles = new ArrayList<>();
	    
	    // 동적 쿼리 생성 - StringBuilder 사용(String 의 불변성 때문)
	    StringBuilder sql = new StringBuilder(SQL.SELECT_ARTICLES);
	    
	    if(searchType.equals("title")) {
	        sql.append(SQL.SELECT_ARTICLES_WHERE_TITLE);
	    } else if(searchType.equals("content")) {
	    	sql.append(SQL.SELECT_ARTICLES_WHERE_CONTENT);
	    } else if(searchType.equals("title_content")) {
	    	sql.append(SQL.SELECT_ARTICLES_WHERE_TITLE_CONTENT);
	    } else if(searchType.equals("writer")) {
	    	sql.append(SQL.SELECT_ARTICLES_WHERE_WRITER);
	    }
	    sql.append(SQL.SELECT_ARTICLES_ORDER_LIMIT);
	    
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());
			
			if(searchType.equals("title_content")) {
				psmt.setString(1, "%" + keyword + "%");
				psmt.setString(2, "%" + keyword + "%");
				psmt.setInt(3, start);
			}else {
				psmt.setString(1, "%" + keyword + "%");
				psmt.setInt(2, start);
			}
			
			
			System.out.println(psmt);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleDTO article = new ArticleDTO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setWriter(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11));
				article.setNick(rs.getString(12));
				articles.add(article);
			}
			
			closeAll();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return articles;
	}
	public void updateArticle(ArticleDTO article) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE);
			psmt.setString(1, article.getTitle());
			psmt.setString(2, article.getContent());
			psmt.setInt(3, article.getFile());
			psmt.setInt(4, article.getNo());
			
			psmt.executeUpdate();
			
			closeAll();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteArticle(String no) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			psmt.executeUpdate();
			
			closeAll();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 사용자 정의
	public void insertComment(ArticleDTO comment) {
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false); // 트랜잭션 시작
			
			psmt = conn.prepareStatement(SQL.INSERT_COMMENT);
			psmt.setInt(1, comment.getParent());
			psmt.setString(2, comment.getContent());
			psmt.setString(3, comment.getWriter());
			psmt.setString(4, comment.getRegip());
			System.out.println(psmt);
			
			psmtEtc1 = conn.prepareStatement(SQL.UPDATE_COMMENT_PLUS);
			psmtEtc1.setInt(1, comment.getParent());
			System.out.println(psmtEtc1);
			
			psmt.executeUpdate();
			psmtEtc1.executeUpdate();
			
			conn.commit(); // 트랜잭션 종료
			closeAll();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<ArticleDTO> selectComments(String parent) {
		
		List<ArticleDTO> comments = new ArrayList<>(); 
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_COMMENTS);
			psmt.setString(1, parent);
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleDTO comment = new ArticleDTO();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setContent(rs.getString(6));
				comment.setWriter(rs.getString(9));
				comment.setRegip(rs.getString(10));
				comment.setRdate(rs.getString("rdate")); // 칼럼명 작성가능
				comment.setNick(rs.getString(12)); // 칼럼명 작성가능
				comments.add(comment);
				
			}
			closeAll();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return comments;
	}
	public ArticleDTO selectComment(String no) {
		ArticleDTO comment = null;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_COMMENT);
			psmt.setString(1, no);
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				comment = new ArticleDTO();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setContent(rs.getString(6));
				comment.setWriter(rs.getString(9));
			}
			closeAll();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return comment;
	}
	
	public int selectCountTotal(String searchType, String keyword) {
		
		int total = 0;
		StringBuilder sql = new StringBuilder(SQL.SELECT_COUNT_TOTAL);
	    
		if(searchType != null && keyword != null) {
			
		    if(searchType.equals("title")) {
		        sql.append(SQL.SELECT_ARTICLES_WHERE_TITLE);
		    } else if(searchType.equals("content")) {
		    	sql.append(SQL.SELECT_ARTICLES_WHERE_CONTENT);
		    } else if(searchType.equals("title_content")) {
		    	sql.append(SQL.SELECT_ARTICLES_WHERE_TITLE_CONTENT);
		    } else if(searchType.equals("writer")) {
		    	sql.append(SQL.SELECT_ARTICLES_WHERE_WRITER);
		    }
		}
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());
			
			if(searchType != null && keyword != null) {
				if(searchType.equals("title_content")) {
					psmt.setString(1, "%" + keyword + "%");
					psmt.setString(2, "%" + keyword + "%");
				}else{
					psmt.setString(1, "%" + keyword + "%");
				}
			}
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			closeAll();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return total;
	}
	
	public void updateHitCount(String no) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_HIT_COUNT);
			psmt.setString(1, no);
			//System.out.println(psmt);
			
			
			psmt.executeUpdate();
			closeAll();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteComment(String parent, String no) {
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			
			psmt = conn.prepareStatement(SQL.DELETE_COMMENT);
			psmt.setString(1, no); // 댓글번호
			
			psmtEtc1 = conn.prepareStatement(SQL.UPDATE_COMMENT_MINUS);
			psmtEtc1.setString(1, parent);
			
			psmt.executeUpdate();
			psmtEtc1.executeUpdate();
			
			conn.commit();
			closeAll();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	//
	public void updateComment(ArticleDTO comment) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_COMMENT);
			psmt.setString(1, comment.getContent());
			psmt.setInt(2, comment.getNo());
			
			psmt.executeUpdate();
			closeAll();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	// JSP로 댓글 수정
	public void updateComment(String no, String content) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			
			psmt.executeUpdate();
			closeAll();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
