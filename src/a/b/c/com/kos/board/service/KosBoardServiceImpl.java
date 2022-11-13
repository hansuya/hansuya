package a.b.c.com.kos.board.service;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import a.b.c.com.kos.board.dao.KosBoardDAO;
import a.b.c.com.kos.board.vo.KosBoardVO;

@Service
@Transactional
public class KosBoardServiceImpl implements KosBoardService {
	Logger logger = LogManager.getLogger(KosBoardServiceImpl.class);
	
	// 서비스에서 DAO 연결하기 
	// 필드 @Autowired 어노테이션으로  DI (의존성 주입하기)
	@Autowired(required=false)		
	private KosBoardDAO kosBoardDAO;

	@Override
	public int kosBoardInsert(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardInsert 함수 진입 >>> : ");			
		return kosBoardDAO.kosBoardInsert(kbvo);
	}

	@Override
	public List<KosBoardVO> kosBoardSelectAll(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardSelectAll 함수 진입 >>> : ");			
		return kosBoardDAO.kosBoardSelectAll(kbvo);
	}

	@Override
	public List<KosBoardVO> kosBoardSelect(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardSelect 함수 진입 >>> : ");			
		return kosBoardDAO.kosBoardSelect(kbvo);
	}

	@Override
	public List<KosBoardVO> kosBoardPwCheck(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardPwCheck 함수 진입 >>> : ");			
		return kosBoardDAO.kosBoardPwCheck(kbvo);
	}

	@Override
	public int kobBoardBhit(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kobBoardBhit 함수 진입 >>> : ");			
		return kosBoardDAO.kobBoardBhit(kbvo);
	}

	@Override
	public int kosBoardUpdate(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardUpdate 함수 진입 >>> : ");			
		return kosBoardDAO.kosBoardUpdate(kbvo);
	}

	@Override
	public int kosBoardDelete(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardDelete 함수 진입 >>> : ");			
		return kosBoardDAO.kosBoardDelete(kbvo);
	}

}
