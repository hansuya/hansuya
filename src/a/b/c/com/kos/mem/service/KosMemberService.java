package a.b.c.com.kos.mem.service;

import java.util.List;

import a.b.c.com.kos.mem.vo.KosMemberVO;

public interface KosMemberService {

	int kosMemberInsert(KosMemberVO kvo);
	List<KosMemberVO> kosMemberSelectAll(KosMemberVO kvo);
	List<KosMemberVO> kosMemberSelect(KosMemberVO kvo);
	
	List<KosMemberVO> kosIdCheck(KosMemberVO kvo);
	
	// 20221111 업데이트 추가 eunbh
	int kosMemberUpdate(KosMemberVO kvo);
	int kosMemberDelete(KosMemberVO kvo);
}
