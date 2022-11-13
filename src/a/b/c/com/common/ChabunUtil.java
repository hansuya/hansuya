package a.b.c.com.common;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public abstract class ChabunUtil {
	static Logger logger = LogManager.getLogger(ChabunUtil.class);
	
	
	public static final String BIZ_GUBUN_M 	= "M"; // 회원
	public static final String BIZ_GUBUN_B 	= "B"; // 게시판
	
//	public static final String BIZ_GUBUN_P 	= "P"; // 상품
//	public static final String BIZ_GUBUN_C 	= "C"; // 카트
//	public static final String BIZ_GUBUN_R 	= "RB"; // 게시판 댓글
//	public static final String BIZ_GUBUN_O 	= "O"; // 주문
	
	
	// type : D : YYYYMMDD, M : YYYYMM, Y : YYYY, N : 
	public static String numPad(String t, String c){
	
		for (int i=c.length(); i < 4; i++) {
			c = "0" + c;
		}				
		String ymd = DateFormatUtil.ymdFormats(t);
		
		return ymd.concat(c);
	}
	
	 
	public static String getMemberChabun(String type, String num) {	
		logger.info("getMemberChabun >>> : " + type + " : " + num);
		
		return BIZ_GUBUN_M.concat(ChabunUtil.numPad(type, num));
	}
	
	public static String getBoardChabun(String type, String num) {
		logger.info("getBoardChabun >>> : " + type + " : " + num);
		
		return BIZ_GUBUN_B.concat(ChabunUtil.numPad(type, num));
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		String c = "1";
		System.out.println(">>> : " + ChabunUtil.getBoardChabun("m", c));		
	}
}
