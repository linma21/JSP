package kr.co.jboard2.dto;


public class PageDTO {
	private int pageGroupCurrent;
	private int pageGroupStart;
	private int pageGroupEnd;
	private int articleStartNum;
	private int currentPg;
	private int lastPageNum;
	private int start;
	private int total;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getLastPageNum() {
		return lastPageNum;
	}
	public void setLastPageNum(int lastPageNum) {
		this.lastPageNum = lastPageNum;
	}
	public int getCurrentPg() {
		return currentPg;
	}
	public void setCurrentPg(int currentPg) {
		this.currentPg = currentPg;
	}
	public int getPageGroupCurrent() {
		return pageGroupCurrent;
	}
	public void setPageGroupCurrent(int pageGroupCurrent) {
		this.pageGroupCurrent = pageGroupCurrent;
	}
	public int getPageGroupStart() {
		return pageGroupStart;
	}
	public void setPageGroupStart(int pageGroupStart) {
		this.pageGroupStart = pageGroupStart;
	}
	public int getPageGroupEnd() {
		return pageGroupEnd;
	}
	public void setPageGroupEnd(int pageGroupEnd) {
		this.pageGroupEnd = pageGroupEnd;
	}
	public int getArticleStartNum() {
		return articleStartNum;
	}
	public void setArticleStartNum(int articleStartNum) {
		this.articleStartNum = articleStartNum;
	}
	@Override
	public String toString() {
		return "PageDTO [pageGroupCurrent=" + pageGroupCurrent + ", pageGroupStart=" + pageGroupStart
				+ ", pageGroupEnd=" + pageGroupEnd + ", articleStartNum=" + articleStartNum + "]";
	}
	
}
