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
	
	// 제품번호 채번 해오기
	int getPnumOfProduct() throws SQLException;
	
	// tbl_product 테이블에 제품정보 insert 하기
	int productInsert(ProductVO pvo) throws SQLException;
	
	// image 파일명 insert
	int product_imagefile_Insert(int pnum, String attachFileName) throws SQLException;
	
	// 해당 제품의 상세정보
	ProductVO selectOneProductByPnum(String pnum) throws SQLException;
	
	// 추가된 이미지 정보 조회
	List<String> getImagesByPnum(String pnum) throws SQLException;
	
	// Ajax를 이용한 특정 제품의 상품후기를 입력하기
	int addComment(PurchaseReviewsVO reviewsvo) throws SQLException;
	
	// Ajax를 이용한 특정 제품의 상품후기를 조회(select)하기
	List<PurchaseReviewsVO> commentList(String fk_pnum) throws SQLException;
	
	// 좋아요 추가
	int likeAdd(Map<String, String> paraMap) throws SQLException;
	
	// 싫어요 추가
	int dislikeAdd(Map<String, String> paraMap) throws SQLException;
	
	// 특정 제품에 대해 좋아요, 싫어요의
	Map<String, Integer> getLikeDislikeCount(String pnum);
	
}
