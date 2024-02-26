package kr.co.jboard2.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.dto.ArticleDTO;

public class ArticleDAO extends DBHelper{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	public void insertArticle(ArticleDTO article) {}
	public ArticleDTO selectArticle(int no) {
		ArticleDTO article = new ArticleDTO();
		
		return article;
	}
	public List<ArticleDTO> selectArticles() {
		List<ArticleDTO> articles = new ArrayList<>();
		
		return articles;
	}
	public void updateArticle(ArticleDTO article) {}
	public void deleteArticle(int no) {}
}
