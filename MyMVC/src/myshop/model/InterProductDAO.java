package myshop.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {
	
	// 상품이미지 조회 메소드
	List<ImageVO> imageSelectAll() throws SQLException;
	
	// Ajax를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해
	int totalPspecCount(String fk_snum) throws SQLException;
	
	// Ajax를 이용한 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서 (start ~ end) 조회해오기 
	List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException;
	
	
	
	
}
