package kr.co.jboard2.db;

public class SQL {

	public static final String SELECT_TERMS = "SELECT * FROM `terms`";
	
	public static final String SELECT_COUNT_USER = "SELECT COUNT(*) FROM `User` ";
	public static final String WHERE_UID	 = "WHERE `uid`=?";
	public static final String WHERE_NICK	 = "WHERE `nick`=?";
	public static final String WHERE_HP		 = "WHERE `hp`=?";
	public static final String WHERE_EMAIL	 = "WHERE `email`=?";

	public static final String SELECT_USER_FOR_LOGIN = "SELECT * FROM `User` WHERE `uid`=? AND `pass`=SHA2(?, 256)";
	
	public static final String SELECT_ARTICLES = "SELECT a.*, b.`nick` FROM `Article` "
													+ "AS a JOIN `User` AS b ON a.writer=b.uid "
													+ "WHERE `parent` =0 ";
	
	public static final String SELECT_ARTICLES_WHERE_TITLE = "AND `title` LIKE ? ";
	public static final String SELECT_ARTICLES_WHERE_CONTENT = "AND `content` LIKE ? ";
	public static final String SELECT_ARTICLES_WHERE_TITLE_CONTENT = "AND (`title` LIKE ? OR `content` LIKE ?) ";
	public static final String SELECT_ARTICLES_WHERE_WRITER = "AND `nick` LIKE ? ";

	public static final String SELECT_ARTICLES_ORDER_LIMIT = "ORDER BY `no` DESC LIMIT ?, 10";
	
	public static final String SELECT_ARTICLE = "SELECT * FROM `Article` "
															+ "AS A LEFT OUTER JOIN `file` AS B "
															+ "ON A.no = B.ano "
															+ "WHERE `no` =?";
	
	public static final String SELECT_COMMENTS = "SELECT a.*, b.nick FROM `Article` "
															+ "AS a JOIN `User` "
															+ "AS b ON a.writer = b.Uid "
															+ "WHERE `parent` =? "
															+ "ORDER BY `no` DESC";
	public static final String SELECT_COMMENT = "SELECT * FROM `Article` WHERE `no` = ?";
	public static final String SELECT_FILE = "SELECT * FROM `File` WHERE `fno` = ?";
	public static final String SELECT_FILE_FOR_DELETE = "SELECT `ano`,`sname` FROM `File` WHERE `fno`=?";												
	
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(*) FROM `Article` AS a JOIN `User` AS b ON a.writer=b.uid WHERE `parent` =0 ";
	
	
	public static final String INSERT_ARTICLE = "INSERT INTO `Article` SET "
													+"`title` =?, "
													+"`content` =?, "
													+"`file` =?, "
													+"`writer` =?, "
													+"`regip` =?, "
													+"`rdate` =NOW() ";
	public static final String INSERT_USER  = "INSERT INTO `User` SET "
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
	public static final String INSERT_COMMENT = "INSERT INTO `Article` SET "
												+ "`parent` =?, "
												+ "`content` =?, "
												+ "`writer` =?, "
												+ "`regip` =?, "
												+ "`rdate` =NOW() ";

	public static final String INSERT_FILE = "INSERT INTO `File` SET "
														+ "`ano`=?, "
														+ "`oName`=?, "
														+ "`sName`=?, "
														+ "`rdate`=NOW() ";
	
	public static final String DELETE_ARTICLE = "DELETE FROM `Article` WHERE `no`=? OR `parent` =?";
	public static final String DELETE_ARTICLE_FILE = "DELETE FROM `File` WHERE `ano`=?";
	
	public static final String DELETE_FILE = "DELETE FROM `File` WHERE `fno`=?";
	
	
	public static final String DELETE_COMMENT = "DELETE FROM `Article` WHERE `no`=?";
	
	
	public static final String UPDATE_ARTICLE = "UPDATE `Article` SET `title`=?, "
												+ "`content`=?, "
												+ "`file`=? "
												+ "WHERE `no`=?";
	public static final String UPDATE_ARTICLE_FOR_FILE_COUNT = "UPDATE `Article` SET `file`= `file` -1 WHERE `no`=?";
	public static final String UPDATE_COMMENT 	= "UPDATE `Article` SET `content`= ? WHERE `no` =?";
	public static final String UPDATE_HIT_COUNT = "UPDATE `Article` SET `hit` = `hit` +1 WHERE `no`= ?";
	public static final String UPDATE_COMMENT_PLUS = "UPDATE `Article` SET `comment`= `comment`+1 WHERE `no` =?";
	public static final String UPDATE_COMMENT_MINUS = "UPDATE `Article` SET `comment`= `comment`-1 WHERE `no` =?";
	
	public static final String UPDATE_FILE_DOWNLOAD = "UPDATE `file` SET `download`= `download`+1 WHERE `fno` =?";
	
}
