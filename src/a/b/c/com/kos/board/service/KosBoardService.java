package a.b.c.com.kos.board.service;

import java.util.List;

import a.b.c.com.kos.board.vo.KosBoardVO;

public interface KosBoardService {
	
	public int kosBoardInsert(KosBoardVO kbvo);
	public List<KosBoardVO> kosBoardSelectAll(KosBoardVO kbvo);
	public List<KosBoardVO> kosBoardSelect(KosBoardVO kbvo);	
	
	public List<KosBoardVO> kosBoardPwCheck(KosBoardVO kbvo);
	
	// 게시글 조회 수 
	public int kobBoardBhit(KosBoardVO kbvo);
	
	// 20221111 수정 삭제 추가 eunbh
	public int kosBoardUpdate(KosBoardVO kbvo);
	public int kosBoardDelete(KosBoardVO kbvo);

}
