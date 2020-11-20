package myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ProductVO;

public class MallByCategoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		
		super.goBackURL(request);

		String cnum = request.getParameter("cnum");
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if ( currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		
		try {
			Integer.parseInt(currentShowPageNo);
		} catch (NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		
		InterProductDAO pdao = new ProductDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("cnum", cnum);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<ProductVO> productList = pdao.selectProductByCategory(paraMap);
		request.setAttribute("productList", productList);
		
		// **** ========= 페이지바 만들기 ========= **** //
	      /*
	          1개 블럭당 10개씩 잘라서 페이지 만든다.
	          1개 페이지당  10개행을 보여준다라면 총 몇개 블럭이 나와야 할까? 
	             총 제품의 개수가 423개 이고, 1개 페이지당 보여줄 제품의 개수가 10개 이라면 
	          412/10 = 41.2 ==> 42(totalPage)        
	              
	          1블럭               1 2 3 4 5 6 7 8 9 10 [다음]
	          2블럭   [이전] 11 12 13 14 15 16 17 18 19 20 [다음]
	          3블럭   [이전] 21 22 23 24 25 26 27 28 29 30 [다음]
	          4블럭   [이전] 31 32 33 34 35 36 37 38 39 40 [다음]
	          5블럭   [이전] 41 42 
	       */
		int totalPage = pdao.getTotalPage(cnum);
		
	//   System.out.println("~~~ 확인용 totalPage => " + totalPage);
	      
	      // ==== !!! 공식 !!! ==== // 
	   /*
	       1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은  1 이다.
	       11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.   
	       21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
	       
	       currentShowPageNo      pageNo
	       --------------------------------------------------------------------------------------
	            1                   1  = ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1 
	            2                   1  = ( (2 - 1)/10 ) * 10 + 1
	            3                   1  = ( (3 - 1)/10 ) * 10 + 1
	            4                   1  = ( (4 - 1)/10 ) * 10 + 1
	            5                   1  = ( (5 - 1)/10 ) * 10 + 1
	            6                   1  = ( (6 - 1)/10 ) * 10 + 1
	            7                   1  = ( (7 - 1)/10 ) * 10 + 1
	            8                   1  = ( (8 - 1)/10 ) * 10 + 1
	            9                   1  = ( (9 - 1)/10 ) * 10 + 1
	            10                  1  = ( (10 - 1)/10 ) * 10 + 1
	            
	            11                 11  = ( (11 - 1)/10 ) * 10 + 1
	            12                 11  = ( (12 - 1)/10 ) * 10 + 1 
	            13                 11  = ( (13 - 1)/10 ) * 10 + 1
	            14                 11  = ( (14 - 1)/10 ) * 10 + 1
	            15                 11  = ( (15 - 1)/10 ) * 10 + 1
	            16                 11  = ( (16 - 1)/10 ) * 10 + 1
	            17                 11  = ( (17 - 1)/10 ) * 10 + 1
	            18                 11  = ( (18 - 1)/10 ) * 10 + 1
	            19                 11  = ( (19 - 1)/10 ) * 10 + 1
	            20                 11  = ( (20 - 1)/10 ) * 10 + 1  
	            
	            21                 21  = ( (21 - 1)/10 ) * 10 + 1 
	            22                 21  = ( (22 - 1)/10 ) * 10 + 1 
	            23                 21  = ( (23 - 1)/10 ) * 10 + 1 
	            ..                 21  = ( (.. - 1)/10 ) * 10 + 1 
	            29                 21  = ( (29 - 1)/10 ) * 10 + 1 
	            30                 21  = ( (30 - 1)/10 ) * 10 + 1 
	    */
		
		String pageBar = "";
		
		int loop = 1;
		int blockSize = 10;
		int pageNo = 0;
		
		pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize) * blockSize + 1;
		
		String sizePerPage = "10";

		if ( pageNo != 1) {
			pageBar += "&nbsp;<a href='mallByCategory.up?currentShowPageNo=1&sizePerPage="+sizePerPage+">[맨처음]</a>&nbsp";
			pageBar += "&nbsp;<a href='mallByCategory.up?currentShowPageNo="+(pageNo - 1)+"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp";
		}
		
		while( !(loop > blockSize || pageNo > totalPage ) ) {
	         
	         if( pageNo == Integer.parseInt(currentShowPageNo) ) {
	            pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";  
	         }
	         else {
	            pageBar += "&nbsp;<a href='mallByCategory.up?currentShowPageNo="+pageNo+"&cnum="+cnum+"'>"+pageNo+"</a>&nbsp;"; 
	         }
	         
	         loop++;   // 1 2 3 4 5 6 7 8 9 10 
	                   
	         pageNo++; //  1  2  3  4  5  6  7  8  9 10 
	                   // 11 12 13 14 15 16 17 18 19 20 
	                   // 21 
	      }// end of while---------------------------------
		
		// **** [다음][마지막] 만들기 **** //
	      // pageNo ==> 11
	      if( !( pageNo > totalPage ) ) {
	         pageBar += "&nbsp;<a href='mallByCategory.up?currentShowPageNo="+pageNo+"&cnum="+cnum+"'>[다음]</a>&nbsp;";
	         pageBar += "&nbsp;<a href='mallByCategory.up?currentShowPageNo="+totalPage+"&cnum="+cnum+"'>[마지막]</a>&nbsp;";  
	      }
		
	      
	      
	      request.setAttribute("pageBar", pageBar);
	      
	      super.setViewPage("/WEB-INF/myshop/mallByCategory.jsp");
		
		
		

		
		
		
	}
}










