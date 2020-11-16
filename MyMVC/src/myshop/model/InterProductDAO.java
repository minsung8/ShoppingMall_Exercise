package myshop.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {
	
	// 상품이미지 조회 메소드
	List<ImageVO> imageSelectAll() throws SQLException;
	
	// Ajax를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해
	int totalPspecCount(String fk_snum) throws SQLException;
	
	// Ajax를 이용한 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서 (start ~ end) 조회해오기 
	List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException;
	
	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기
	// VO 를 사용하지 않고 Map 으로 처리해보겠습니다.
	List<HashMap<String, String>> getCategoryList() throws SQLException;
	
	// VO를 사용하여 spec 조회
	List<SpecVO> selectSpecList() throws SQLException;
}
