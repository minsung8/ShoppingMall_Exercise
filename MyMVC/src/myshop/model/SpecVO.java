package myshop.model;

public class SpecVO {
	
	private int snum;
	private String sname;
	
	public SpecVO() {}
	
	public SpecVO(int snum, String sname) {
		super();
		this.snum = snum;
		this.sname = sname;
	}

	public int getSnum() {
		return snum;
	}

	public void setSnum(int snum) {
		this.snum = snum;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}
	
}
