package myshop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO{
	
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public ProductDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/mymvc_oracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public List<ImageVO> imageSelectAll() throws SQLException {
		
		List<ImageVO> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = "select imgno, imgfilename " +  
					" from tbl_main_image " +
					" order by imgno asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ImageVO imgvo = new ImageVO();
				imgvo.setImgno(rs.getInt(1));
				imgvo.setImgfilename(rs.getNString(2));
				
				imgList.add(imgvo);
			}
			
		} finally {
			close();
		}
		
		return imgList;
	}

	@Override
	public int totalPspecCount(String fk_snum) throws SQLException {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " select count(*) " +  
					" from tbl_product " +
					" where fk_snum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_snum);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalCount;
		
	}

	@Override
	public List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException {
		
		List<ProductVO> prodList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point,\n"+
					" pinputdate from ( select row_number() over(order by pnum asc) AS RNO , \n"+
					" pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point ,\n"+
					" to_char(pinputdate, 'yyyy-mm-dd') as pinputdate\n"+
					" from tbl_product P JOIN tbl_category C ON P.fk_cnum = C.cnum JOIN tbl_spec S ON P.fk_snum = S.snum \n"+
					" where S.sname = ? ) V where RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sname"));
			pstmt.setString(2, paraMap.get("start"));
			pstmt.setString(3, paraMap.get("end"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO pvo = new ProductVO();
				pvo.setPnum(rs.getInt(1));
				pvo.setPname(rs.getString(2));
				
				CategoryVO ctgvo = new CategoryVO();
				ctgvo.setCode(rs.getString(3));
				pvo.setCategvo(ctgvo);
				pvo.setPcompany(rs.getNString(4));
				pvo.setPimage1(rs.getString(5));
				pvo.setPimage2(rs.getNString(6));
				pvo.setPqty(rs.getInt(7));
				pvo.setPrice(rs.getInt(8));
				pvo.setSaleprice(rs.getInt(9));
				
				SpecVO spvo = new SpecVO();
				spvo.setSname(rs.getString(10));
				pvo.setSpvo(spvo);
				pvo.setPcontent(rs.getString(11));
				pvo.setPoint(rs.getInt(12));
				pvo.setPinputdate(rs.getString(13));
				
				prodList.add(pvo);
			}			
			
		} finally {
			close();
		}
		
		return prodList;
	}

}
