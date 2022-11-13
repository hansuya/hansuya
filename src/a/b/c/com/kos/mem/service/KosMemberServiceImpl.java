package a.b.c.com.kos.mem.service;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import a.b.c.com.kos.mem.dao.KosMemberDAO;
import a.b.c.com.kos.mem.vo.KosMemberVO;

@Service
@Transactional
public class KosMemberServiceImpl implements KosMemberService {
	private Logger logger = LogManager.getLogger(KosMemberServiceImpl.class);
	
	@Autowired(required=false)
	private KosMemberDAO kosMemberDAO;

	@Override
	public int kosMemberInsert(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosMemberInsert() 함수 진입 >>> : ");
		
		return kosMemberDAO.kosMemberInsert(kvo);
	}

	@Override
	public List<KosMemberVO> kosMemberSelectAll(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosMemberSelectAll() 함수 진입 >>> : ");
		
		return kosMemberDAO.kosMemberSelectAll(kvo);
	}
	
	@Override
	public List<KosMemberVO> kosMemberSelect(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosMemberSelect() 함수 진입 >>> : ");
		
		return kosMemberDAO.kosMemberSelect(kvo);
	}

	@Override
	public List<KosMemberVO> kosIdCheck(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosIdCheck() 함수 진입 >>> : ");
		
		return kosMemberDAO.kosIdCheck(kvo);
	}

	@Override
	public int kosMemberUpdate(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosMemberUpdate() 함수 진입 >>> : ");
		
		return kosMemberDAO.kosMemberUpdate(kvo);
	}

	@Override
	public int kosMemberDelete(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosMemberDelete() 함수 진입 >>> : ");
		
		return kosMemberDAO.kosMemberDelete(kvo);
	}

}
