package myshop.model;

import java.sql.SQLException;
import java.util.List;

public interface InterProductDAO {
	
	// 상품이미지 조회 메소드
	List<ImageVO> imageSelectAll() throws SQLException;
	
}
