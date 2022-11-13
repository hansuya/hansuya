package a.b.c.com.kos.board.vo;

public class KosBoardVO {
	
	private String bnum;
	private String bsubject;
	private String bname;
	private String bcontent;
	private String bfile;
	private String bpw;
	private String deleteyn;
	private String insertdate;
	private String updatedate;
	
	// 페이징 이동 필드
	private String pageSize;
	private String groupSize;
	private String curPage;
	private String totalCount;
	
	// 조회수 필드
	private int bhit;
		
	// 생성자 
	public KosBoardVO() {
		
	}


	public KosBoardVO(String bnum, String bsubject, String bname, String bcontent, String bfile, String bpw,
			String deleteyn, String insertdate, String updatedate) {
		
		this.bnum = bnum;
		this.bsubject = bsubject;
		this.bname = bname;
		this.bcontent = bcontent;
		this.bfile = bfile;
		this.bpw = bpw;
		this.deleteyn = deleteyn;
		this.insertdate = insertdate;
		this.updatedate = updatedate;
	}
	
	
	public KosBoardVO(String bnum, String bsubject, String bname, String bcontent, String bfile, String bpw,
			String deleteyn, String insertdate, String updatedate, String pageSize, String groupSize, String curPage,
			String totalCount) {
		
		this.bnum = bnum;
		this.bsubject = bsubject;
		this.bname = bname;
		this.bcontent = bcontent;
		this.bfile = bfile;
		this.bpw = bpw;
		this.deleteyn = deleteyn;
		this.insertdate = insertdate;
		this.updatedate = updatedate;
		this.pageSize = pageSize;
		this.groupSize = groupSize;
		this.curPage = curPage;
		this.totalCount = totalCount;
	}


	public KosBoardVO(String bnum, String bsubject, String bname, String bcontent, String bfile, String bpw,
			String deleteyn, String insertdate, String updatedate, String pageSize, String groupSize, String curPage,
			String totalCount, int bhit) {
		
		this.bnum = bnum;
		this.bsubject = bsubject;
		this.bname = bname;
		this.bcontent = bcontent;
		this.bfile = bfile;
		this.bpw = bpw;
		this.deleteyn = deleteyn;
		this.insertdate = insertdate;
		this.updatedate = updatedate;
		this.pageSize = pageSize;
		this.groupSize = groupSize;
		this.curPage = curPage;
		this.totalCount = totalCount;
		this.bhit = bhit;
	}


	// setter / getter
	public String getBnum() {
		return bnum;
	}
	public void setBnum(String bnum) {
		this.bnum = bnum;
	}
	public String getBsubject() {
		return bsubject;
	}
	public void setBsubject(String bsubject) {
		this.bsubject = bsubject;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public String getBfile() {
		return bfile;
	}
	public void setBfile(String bfile) {
		this.bfile = bfile;
	}
	public String getBpw() {
		return bpw;
	}
	public void setBpw(String bpw) {
		this.bpw = bpw;
	}
	public String getDeleteyn() {
		return deleteyn;
	}
	public void setDeleteyn(String deleteyn) {
		this.deleteyn = deleteyn;
	}
	public String getInsertdate() {
		return insertdate;
	}
	public void setInsertdate(String insertdate) {
		this.insertdate = insertdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}

	// 페이지 getter / setter
	public String getPageSize() {
		return pageSize;
	}


	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}


	public String getGroupSize() {
		return groupSize;
	}


	public void setGroupSize(String groupSize) {
		this.groupSize = groupSize;
	}


	public String getCurPage() {
		return curPage;
	}


	public void setCurPage(String curPage) {
		this.curPage = curPage;
	}


	public String getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}


	// 조회수 getter /setter
	public int getBhit() {
		return bhit;
	}


	public void setBhit(int bhit) {
		this.bhit = bhit;
	}
	
}
