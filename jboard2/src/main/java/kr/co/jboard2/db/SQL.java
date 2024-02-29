package kr.co.jboard2.db;

public class SQL {

	public static final String SELECT_TERMS = "SELECT * FROM `terms`";
	
	public static final String SELECT_COUNT_USER = "SELECT COUNT(*) FROM `user` ";
	public static final String WHERE_UID	 = "WHERE `uid`=?";
	public static final String WHERE_NICK	 = "WHERE `nick`=?";
	public static final String WHERE_HP		 = "WHERE `hp`=?";
	public static final String WHERE_EMAIL	 = "WHERE `email`=?";

	public static final String SELECT_USER_FOR_LOGIN = "SELECT * FROM `user` WHERE `uid`=? AND `pass`=SHA2(?, 256)";
	
	public static final String SELECT_ARTICLES = "SELECT a.*, b.`nick` FROM `article` "
													+ "AS a JOIN `user` AS b ON a.writer=b.uid "
													+ "WHERE `parent` =0 ";
	
	public static final String SELECT_ARTICLES_WHERE_TITLE = "AND `title` LIKE ? ";
	public static final String SELECT_ARTICLES_WHERE_CONTENT = "AND `content` LIKE ? ";
	public static final String SELECT_ARTICLES_WHERE_TITLE_CONTENT = "AND (`title` LIKE ? OR `content` LIKE ?) ";
	public static final String SELECT_ARTICLES_WHERE_WRITER = "AND `nick` LIKE ? ";

	public static final String SELECT_ARTICLES_ORDER_LIMIT = "ORDER BY `no` DESC LIMIT ?, 10";
	
	public static final String SELECT_ARTICLE = "SELECT * FROM `article` "
															+ "AS A LEFT OUTER JOIN `file` AS B "
															+ "ON A.no = B.ano "
															+ "WHERE `no` =?";
	
	public static final String SELECT_COMMENTS = "SELECT a.*, b.nick FROM `article` "
															+ "AS a JOIN `user` "
															+ "AS b ON a.writer = b.Uid "
															+ "WHERE `parent` =? "
															+ "ORDER BY `no` DESC";
	public static final String SELECT_COMMENT = "SELECT * FROM `article` WHERE `no` = ?";
	public static final String SELECT_FILE = "SELECT * FROM `file` WHERE `fno` = ?";
	public static final String SELECT_FILE_FOR_DELETE = "SELECT `ano`,`sName` FROM `file` WHERE `fno`=?";												
	
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(*) FROM `article` AS a JOIN `user` AS b ON a.writer=b.uid WHERE `parent` =0 ";
	
	
	public static final String INSERT_ARTICLE = "INSERT INTO `article` SET "
													+"`title` =?, "
													+"`content` =?, "
													+"`file` =?, "
													+"`writer` =?, "
													+"`regip` =?, "
													+"`rdate` =NOW() ";
	public static final String INSERT_USER  = "INSERT INTO `user` SET "
													+ "`uid` =?, "
													+ "`pass` =SHA2(?, 256), "
													+ "`name` =?, "
													+ "`nick` =?, "
													+ "`email` =?, "
													+ "`hp` =?, "
													+ "`zip` =?, "
													+ "`addr1` =?, "
													+ "`addr2` =?, "
													+ "`regip` =?, "
													+ "`sms` =?, "
													+ "`rdate` =NOW() ";
	public static final String INSERT_COMMENT = "INSERT INTO `article` SET "
												+ "`parent` =?, "
												+ "`content` =?, "
												+ "`writer` =?, "
												+ "`regip` =?, "
												+ "`rdate` =NOW() ";

	public static final String INSERT_FILE = "INSERT INTO `file` SET "
														+ "`ano`=?, "
														+ "`oName`=?, "
														+ "`sName`=?, "
														+ "`rdate`=NOW() ";
	
	public static final String DELETE_ARTICLE = "DELETE FROM `article` WHERE `no`=? OR `parent` =?";
	public static final String DELETE_ARTICLE_FILE = "DELETE FROM `file` WHERE `ano`=?";
	
	public static final String DELETE_FILE = "DELETE FROM `file` WHERE `fno`=?";
	
	
	public static final String DELETE_COMMENT = "DELETE FROM `article` WHERE `no`=?";
	
	
	public static final String UPDATE_ARTICLE = "UPDATE `article` SET `title`=?, "
												+ "`content`=?, "
												+ "`file`=? "
												+ "WHERE `no`=?";
	public static final String UPDATE_ARTICLE_FOR_FILE_COUNT = "UPDATE `article` SET `file`= `file` -1 WHERE `no`=?";
	public static final String UPDATE_COMMENT 	= "UPDATE `article` SET `content`= ? WHERE `no` =?";
	public static final String UPDATE_HIT_COUNT = "UPDATE `article` SET `hit` = `hit` +1 WHERE `no`= ?";
	public static final String UPDATE_COMMENT_PLUS = "UPDATE `article` SET `comment`= `comment`+1 WHERE `no` =?";
	public static final String UPDATE_COMMENT_MINUS = "UPDATE `article` SET `comment`= `comment`-1 WHERE `no` =?";
	
	public static final String UPDATE_FILE_DOWNLOAD = "UPDATE `file` SET `download`= `download`+1 WHERE `fno` =?";
	
}
