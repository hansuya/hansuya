package a.b.c.com.kos.mem.dao;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import a.b.c.com.kos.mem.vo.KosMemberVO;

@Repository
public class KosMemberDAOImpl implements KosMemberDAO {
	Logger logger = LogManager.getLogger(KosMemberDAOImpl.class);
	
	@Autowired(required=false)
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public int kosMemberInsert(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosSpringInsert 함수 진입 >>> : ");	
		
		return sqlSession.insert("kosMemberInsert", kvo);
	}


	@Override
	public List<KosMemberVO> kosMemberSelectAll(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosMemberSelectAll 함수 진입 >>> : ");	
		
		return sqlSession.selectList("kosMemberSelectAll", kvo);
	}
	
	@Override
	public List<KosMemberVO> kosMemberSelect(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosMemberSelect 함수 진입 >>> : ");	
		
		return sqlSession.selectList("kosMemberSelect", kvo);
	}


	@Override
	public List<KosMemberVO> kosIdCheck(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosIdCheck 함수 진입 >>> : ");	
		
		return sqlSession.selectList("kosIdCheck", kvo);
	}


	@Override
	public int kosMemberUpdate(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosMemberUpdate 함수 진입 >>> : ");	
		
		return sqlSession.update("kosMemberUpdate", kvo);
	}


	@Override
	public int kosMemberDelete(KosMemberVO kvo) {
		// TODO Auto-generated method stub
		logger.info("kosMemberDelete 함수 진입 >>> : ");	
		
		return sqlSession.update("kosMemberDelete", kvo);
	}

}
