package a.b.c.com.kos.mem.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import a.b.c.com.common.ChabunUtil;
import a.b.c.com.common.CommonUtils;
import a.b.c.com.common.FileUploadUtil;
import a.b.c.com.common.chabun.service.KosChabunService;
import a.b.c.com.kos.mem.service.KosMemberService;
import a.b.c.com.kos.mem.vo.KosMemberVO;

@Controller
public class KosMemberController {
	Logger logger = LogManager.getLogger(KosMemberController.class);
	
	// 필드 오토 와이어드
	@Autowired(required=false)
	private KosChabunService kosChabunService;

	// 필드 오토 와이어드
	@Autowired(required=false)
	private KosMemberService kosMemberService;
	
	// 회원 입력 폼
	@GetMapping("memForm")
	public String kosMemberInsertForm() {
		logger.info("kosMemberInsertForm 함수 진입 >>> : ");
		return "mem/memForm";
	}
	
	// 회원 등록
	@PostMapping("memInsert")
	public String kosMemberInsert(HttpServletRequest req) {
		logger.info("kosMemberInsert 함수 진입 >>> : ");
		
		// 채번 구하기 
		String mnum = ChabunUtil.getMemberChabun("D", kosChabunService.getKosMemberChabun().getMnum());
		logger.info("kosMemberInsert 함수 mnum >>> : " + mnum);
		
		// 이미지 업로드 
		FileUploadUtil fu = new FileUploadUtil(	 CommonUtils.MEM_IMG_UPLOAD_PATH
								                ,CommonUtils.MEM_IMG_FILE_SIZE
								                ,CommonUtils.MEM_EN_CODE);
		// req - mr - fu
		// 이미지 파일 원본 사이즈 
		boolean bool = fu.imgfileUpload(req);
		logger.info("kosMemberInsert bool >>> : " + bool);
		
		KosMemberVO kvo = null;
		kvo = new KosMemberVO();
		
		// 채번 
		kvo.setMnum(mnum);
		
		// 이름 
		kvo.setMname(fu.getParameter("mname"));
		
		// 아이디
		kvo.setMid(fu.getParameter("mid"));
		
		// 패스워드
		kvo.setMpw(fu.getParameter("mpw"));		
		
		// 성별
		kvo.setMgender(fu.getParameter("mgender"));
		
		// 생일
		String mbirth = fu.getParameter("mbirth");
		String mbirth1 = fu.getParameter("mbirth1");
		String mbirth2 = fu.getParameter("mbirth2");
		kvo.setMbirth(mbirth.concat(mbirth1).concat(mbirth2));
		
		// 핸드폰 번호 
		String mhp = fu.getParameter("mhp");
		String mhp1 = fu.getParameter("mhp1");
		String mhp2 = fu.getParameter("mhp2");
		kvo.setMhp(mhp.concat(mhp1).concat(mhp2));
		
		// 유선전화 번호 
		String mtel = fu.getParameter("mtel");
		String mtel1 = fu.getParameter("mtel1");
		String mtel2 = fu.getParameter("mtel2");
		kvo.setMtel(mtel.concat(mtel1).concat(mtel2));
		
		// 이메일 
		String memail = fu.getParameter("memail");
		String memail1 = fu.getParameter("memail1");		
		kvo.setMemail(memail.concat("@").concat(memail1));				
		
		// 도로명 주소, 지번 주소
		kvo.setMzonecode(fu.getParameter("mzonecode"));
		kvo.setMroadaddr(fu.getParameter("mroadaddr"));
		kvo.setMroaddetail(fu.getParameter("mroaddetail"));
		kvo.setMjibunaddr(fu.getParameter("mjibunaddr"));
		
		// 취미 				
		String mhobby = "";
		String hobby[] = fu.getParameterValues("mhobby");
		if (hobby.length > 0) {
			for (int i=0; i < hobby.length; i++) {
				mhobby += hobby[i] + ",";
			}	
		}		
		kvo.setMhobby(mhobby);
		
		// 내소개 
		kvo.setMinfo(fu.getParameter("minfo"));
		
		// 파일
		kvo.setMphoto(fu.getFileName("mphoto"));
				
		
		// 서비스 호출
		int nCnt = kosMemberService.kosMemberInsert(kvo);
		
		if (nCnt > 0) {
			logger.info("kosMemberInsert 함수 nCnt >>> : " + nCnt);
			return "mem/memInsert";
		}
		
		return "mem/memForm";
	}
	
	// 회원 목록
	@GetMapping("memSelectAll")
	public String kosMemberSelectAll(KosMemberVO kvo, Model model) {
		logger.info("kosMemberSelectAll 함수 진입 >>> : ");
		
		List<KosMemberVO> listAll = kosMemberService.kosMemberSelectAll(kvo);
		if (listAll.size() > 0) {
			logger.info("kosMemberSelectAll listAll.size() >>> : " + listAll.size());
			
			model.addAttribute("listAll", listAll);
			
			// 검색 조회 후 리프레쉬된 페이지에 설정 유지용 데이터
			model.addAttribute("search_kvo", kvo);
			
			return "mem/memSelectAll";
		}
		
		return "mem/memForm";
	}
	
	// 회원 조회
	@PostMapping("memSelect")
	public String kosMemberSelect(KosMemberVO kvo, Model model) {
		logger.info("kosMemberSelect 함수 진입 >>> : ");
		logger.info("kosMemberSelect 함수 진입 kvo >>> : " + kvo);
		logger.info("kosMemberSelect 함수 진입 kvo >>> : " + kvo.getMnum());
		
		List<KosMemberVO> listS = kosMemberService.kosMemberSelect(kvo);
		if (listS.size() > 0) {
			logger.info("kosMemberSelectAll listS.size() >>> : " + listS.size());
			
			model.addAttribute("listS", listS);
			return "mem/memSelect";
		}
		
		return "mem/memSelectAll";
	}
	
	// 아이디 중복 체크하기
	@GetMapping("kosIdCheck")
	@ResponseBody
	public Object kosIdCheck(KosMemberVO kvo) {
		logger.info("kosMemberService 함수 진입 >>> :");		
		logger.info("kosMemberService kvo.getMid()() >>> : " + kvo.getMid());			
		
		List<KosMemberVO> list = kosMemberService.kosIdCheck(kvo);			
		logger.info("kosIdCheck list.size() >>> : " + list.size());
		
		String msg = "";		
		if (list.size() == 0) {msg = "ID_YES";}  
		else { msg = "ID_NO";}  
		
		return msg;		
	}
	
	// 수정
	@GetMapping("memUpdate")
	public String kosMemberUpdate(HttpServletRequest req, KosMemberVO kvo) {
		logger.info("kosMemberUpdate 함수 진입 >>> :");	
		logger.info("kosMemberService kvo.getMnum()() >>> : " + kvo.getMnum());	
		
		
		// 핸드폰 번호 
		String mhp = req.getParameter("mhp");
		String mhp1 = req.getParameter("mhp1");
		String mhp2 = req.getParameter("mhp2");
		kvo.setMhp(mhp.concat(mhp1).concat(mhp2));
		
		// 유선전화 번호 
		String mtel = req.getParameter("mtel");
		String mtel1 = req.getParameter("mtel1");
		String mtel2 = req.getParameter("mtel2");
		kvo.setMtel(mtel.concat(mtel1).concat(mtel2));
		
		// 이메일 
		String memail = req.getParameter("memail");
		String memail1 = req.getParameter("memail1");		
		kvo.setMemail(memail.concat("@").concat(memail1));				
		
		// 도로명 주소, 지번 주소
		kvo.setMzonecode(req.getParameter("mzonecode"));
		kvo.setMroadaddr(req.getParameter("mroadaddr"));
		kvo.setMroaddetail(req.getParameter("mroaddetail"));
		kvo.setMjibunaddr(req.getParameter("mjibunaddr"));
		
		// 취미 				
		String mhobby = "";
		String hobby[] = req.getParameterValues("mhobby");
		if (hobby.length > 0) {
			for (int i=0; i < hobby.length; i++) {
				mhobby += hobby[i] + ",";
			}	
		}		
		kvo.setMhobby(mhobby);
		
		int nCnt = kosMemberService.kosMemberUpdate(kvo);
		
		if (nCnt == 1) {
			logger.info("kosMemberUpdate 함수 nCnt >>> : " + nCnt);
			
			return "mem/memUpdate";			
		}
		
		return "";
	}
	
	// 삭제
	@GetMapping("memDelete")
	public String kosMemberDelete(KosMemberVO kvo) {
		logger.info("kosMemberDelete 함수 진입 >>> :");
		logger.info("kosMemberDelete 함수 진입 kvo.getMnum() >>> :" + kvo.getMnum());
		
		int nCnt = kosMemberService.kosMemberDelete(kvo);
		
		if (nCnt == 1) {
			logger.info("kosMemberDelete 함수 nCnt >>> : " + nCnt);
			
			return "mem/memUpdate";	
		}
		
		return "";
	}
}
