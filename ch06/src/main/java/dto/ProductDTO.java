package dto;

public class ProductDTO {
	private int proNo;
	private String prodName;
	private int stock;
	private int price;
	private String company;
	public int getProNo() {
		return proNo;
	}
	public void setProNo(int proNo) {
		this.proNo = proNo;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	@Override
	public String toString() {
		return "ProductDTO [proNo=" + proNo + ", prodName=" + prodName + ", stock=" + stock + ", price=" + price
				+ ", company=" + company + "]";
	}
	
}
