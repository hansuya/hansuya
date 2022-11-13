package a.b.c.com.kos.board.dao;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import a.b.c.com.kos.board.vo.KosBoardVO;
import a.b.c.com.kos.mem.dao.KosMemberDAOImpl;

@Repository
public class KosBoardDAOImpl implements KosBoardDAO {
	Logger logger = LogManager.getLogger(KosMemberDAOImpl.class);
	
	@Autowired(required=false)
	private SqlSessionTemplate sqlSession;

	@Override
	public int kosBoardInsert(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardInsert 함수 진입 >>> : ");	
		
		return sqlSession.insert("kosBoardInsert", kbvo);
	}

	@Override
	public List<KosBoardVO> kosBoardSelectAll(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardSelectAll 함수 진입 >>> : ");	
		
		return sqlSession.selectList("kosBoardSelectAll", kbvo);
	}

	@Override
	public List<KosBoardVO> kosBoardSelect(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardSelect 함수 진입 >>> : ");	
		
		return sqlSession.selectList("kosBoardSelect", kbvo);
	}

	@Override
	public List<KosBoardVO> kosBoardPwCheck(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardPwCheck 함수 진입 >>> : ");	
		
		return sqlSession.selectList("kosBoardPwCheck", kbvo);
	}

	@Override
	public int kobBoardBhit(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kobBoardBhit 함수 진입 >>> : ");	
		
		return sqlSession.update("kobBoardBhit", kbvo);
	}

	@Override
	public int kosBoardUpdate(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardUpdate 함수 진입 >>> : ");	
		
		return sqlSession.update("kosBoardUpdate", kbvo);
	}

	@Override
	public int kosBoardDelete(KosBoardVO kbvo) {
		// TODO Auto-generated method stub
		logger.info("kosBoardDelete 함수 진입 >>> : ");	
		
		return sqlSession.update("kosBoardDelete", kbvo);
	}
}
