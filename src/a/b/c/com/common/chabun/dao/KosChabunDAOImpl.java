package a.b.c.com.common.chabun.dao;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import a.b.c.com.kos.board.vo.KosBoardVO;
import a.b.c.com.kos.mem.vo.KosMemberVO;

@Repository
public class KosChabunDAOImpl implements KosChabunDAO {
	Logger logger = LogManager.getLogger(KosChabunDAOImpl.class);
	
	@Autowired(required=false)
	private SqlSessionTemplate sqlSession;

	@Override
	public KosMemberVO getKosMemberChabun() {
		// TODO Auto-generated method stub
		logger.info("getKosMemberChabun 함수 진입 >>> : ");
		return sqlSession.selectOne("getKosMemberChabun"); // getKosMemberChabun
	}

	@Override
	public KosBoardVO getKosBoardChabun() {
		// TODO Auto-generated method stub
		logger.info("getKosBoardChabun 함수 진입 >>> : ");
		return sqlSession.selectOne("getKosBoardChabun"); // getKosBoardChabun
	}

}
