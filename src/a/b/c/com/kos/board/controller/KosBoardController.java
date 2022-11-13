package a.b.c.com.kos.board.controller;

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
import a.b.c.com.kos.board.service.KosBoardService;
import a.b.c.com.kos.board.vo.KosBoardVO;


@Controller
public class KosBoardController {
	Logger logger = LogManager.getLogger(KosBoardController.class);
	
	// 컨트롤러에서 채번 서비스 연결 
	@Autowired(required=false)
	private KosChabunService kosChabunService;
	
	// 컨트롤러에서 회원 서비스 연결 
	@Autowired(required=false)
	private KosBoardService kosBoardService;
	
	@GetMapping("boardForm")
	public String kosBoardForm() {
		logger.info("kosBoardForm 함수 진입 >>> : ");
		
		return "board/boardForm";
	}
	
	
	// 게시판 글쓰기 
	@PostMapping("boardInsert")
	public String kosBoardInsert(HttpServletRequest req) {
		logger.info("kosBoardInsert 함수 진입 >>> : ");	
		
		// 채번 구하기
		String num = kosChabunService.getKosBoardChabun().getBnum();
		logger.info("kosBoardInsert num >>> : " + num);
		String bnum = ChabunUtil.getBoardChabun("N", num);
		logger.info("kosBoardInsert bnum >>> : " + bnum);
			
		// 이미지 업로드 
		FileUploadUtil fu = new FileUploadUtil(	 CommonUtils.BOARD_IMG_UPLOAD_PATH
								                ,CommonUtils.BOARD_IMG_FILE_SIZE
								                ,CommonUtils.BOARD_EN_CODE);
		
		// 이미지 파일 원본 사이즈 
		boolean bool = fu.imgfileUpload(req);
		logger.info("kosBoardInsert bool >>> : " + bool);

		KosBoardVO _kbvo = null;
		_kbvo = new KosBoardVO();
			
		_kbvo.setBnum(bnum);
		_kbvo.setBsubject(fu.getParameter("bsubject"));
		_kbvo.setBname(fu.getParameter("bname"));
		_kbvo.setBpw(fu.getParameter("bpw"));
		_kbvo.setBcontent(fu.getParameter("bcontent"));
		_kbvo.setBfile(fu.getFileName("bfile"));
		
		// 서비스 호출
		int nCnt = kosBoardService.kosBoardInsert(_kbvo);
		if (nCnt > 0) { 
			logger.info("kosBoardInsert nCnt >>> : " + nCnt);
			return "board/boardInsert";
		}
		return "board/boardForm";
	}
	
	// 게시판 전체 조회 
	@GetMapping("boardSelectAll")
	public String kosBoardSelectAll(KosBoardVO kbvo, Model model) {
		logger.info("kosBoardSelectAll 함수 진입 >>> : ");
		
		// 페이징 처리 ====================================================================
		int pageSize = CommonUtils.BOARD_PAGE_SIZE;
		int groupSize = CommonUtils.BOARD_GROUP_SIZE;
		int curPage = CommonUtils.BOARD_CUR_PAGE;
		int totalCount = CommonUtils.BOARD_TOTAL_COUNT;
		
		if (kbvo.getCurPage() !=null){
			curPage = Integer.parseInt(kbvo.getCurPage());
		}
		
		kbvo.setPageSize(String.valueOf(pageSize));
		kbvo.setGroupSize(String.valueOf(groupSize));
		kbvo.setCurPage(String.valueOf(curPage));
		kbvo.setTotalCount(String.valueOf(totalCount));

		logger.info("kosSpringFileUploadSelectAll kbvo.getPageSize() >>> : 	" + kbvo.getPageSize());
		logger.info("kosSpringFileUploadSelectAll kbvo.getGroupSize() >>> : 	" + kbvo.getGroupSize());
		logger.info("kosSpringFileUploadSelectAll kbvo.getCurPage() >>> : 	" + kbvo.getCurPage());
		logger.info("kosSpringFileUploadSelectAll kbvo.getTotalCount() >>> : " + kbvo.getTotalCount());
		// 페이징 처리 ======================================================================================
		
		// 서비스 호출
		List<KosBoardVO> listAll = kosBoardService.kosBoardSelectAll(kbvo);		
		if (listAll.size() > 0) { 
			logger.info("kosBoardSelectAll listAll.size() >>> : " + listAll.size());
			
			model.addAttribute("pagingKBVO", kbvo);				
			model.addAttribute("listAll", listAll);
			return "board/boardSelectAll";
		}		
		return "board/boardSelectAll";
	}
	
	// 게시글 조회 
	@GetMapping("boardSelect")
	public String kosBoardSelect(KosBoardVO kbvo, Model model) {
		logger.info("kosBoardSelect 함수 진입 >>> : ");
		
		logger.info("kosBoardSelect 함수 진입  kbvo.getBnum() >>> : " + kbvo.getBnum());
		
		// 서비스 호출
		List<KosBoardVO> listS = kosBoardService.kosBoardSelect(kbvo);		
		if (listS.size() == 1) { 
			logger.info("kosBoardSelect listS.size() >>> : " + listS.size());
			
			int bhitCnt = kosBoardService.kobBoardBhit(kbvo);
			logger.info("kosBoardSelect bhitCnt >>> : " + bhitCnt);
					
			model.addAttribute("listS", listS);
			return "board/boardSelect";
		}		
		return "board/boardSelectAll";
	}
		
	// 게시글 내용보기  
	@GetMapping("boardSelectContents")
	public String kosBoardSelecContents(KosBoardVO kbvo, Model model) {
		logger.info("kosBoardSelecContents 함수 진입 >>> : ");
		
		logger.info("kosBoardSelecContents 함수 진입  kbvo.getBnum() >>> : " + kbvo.getBnum());
		
		// 서비스 호출
		List<KosBoardVO> listS = kosBoardService.kosBoardSelect(kbvo);		
		if (listS.size() == 1) { 
			logger.info("kosBoardSelect listS.size() >>> : " + listS.size());
			
			int bhitCnt = kosBoardService.kobBoardBhit(kbvo);
			logger.info("kosBoardSelect bhitCnt >>> : " + bhitCnt);
					
			model.addAttribute("listS", listS);
			return "board/boardSelectContents";
		}		
		return "board/boardSelectAll";
	}
	
	// 게시글 수정 
	@GetMapping("boardUpdate")
	public String kosBoardUpdate(KosBoardVO kbvo, Model model) {
		logger.info("kosBoardUpdate 함수 진입 >>> : ");
		logger.info("kosBoardDelete 함수 진입 kbvo.getBnum() >>> : " + kbvo.getBnum());
		
		int nCnt = kosBoardService.kosBoardUpdate(kbvo);
		
		if (nCnt > 0) { 
			logger.info("kosBoardUpdate nCnt >>> : " + nCnt);
			return "board/boardUpdate";
		}
		return "#";		
	}
	
	// 게시글 삭제
	@GetMapping("boardDelete")
	public String kosBoardDelete(KosBoardVO kbvo, Model model) {
		logger.info("kosBoardDelete 함수 진입 >>> : ");
		logger.info("kosBoardDelete 함수 진입 kbvo.getBnum() >>> : " + kbvo.getBnum());
		
		int nCnt = kosBoardService.kosBoardDelete(kbvo);
		
		if (nCnt > 0) { 
			logger.info("kosBoardDelete nCnt >>> : " + nCnt);
			return "board/boardDelete";
		}
		return "#";		
	}
	
	// 패스워드 체크하기
	@PostMapping("boardPwCheck")
	@ResponseBody
	public Object kosBoardPwCheck(KosBoardVO kbvo) {
		logger.info("kosBoardPwCheck 함수 진입 >>> :");		
		logger.info("kosBoardPwCheck kbvo.getBpw()() >>> : " + kbvo.getBpw());			
		
		List<KosBoardVO> list = kosBoardService.kosBoardPwCheck(kbvo);			
		logger.info("kosBoardPwCheck list.size() >>> : " + list.size());
		
		String msg = "";		
		if (list.size() == 1) {msg = "ID_YES";}  
		else { msg = "ID_NO";}  
		
		return msg;		
	}

}
