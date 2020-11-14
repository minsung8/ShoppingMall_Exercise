package myshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;

public class MallHomeAction extends AbstractController{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// ajax를 이용하여 hit 상품목록을 "더보기" 방식으로 페이징처리해서 보여주겠다
		InterProductDAO pdao = new ProductDAO();
		
		int totalHITCount = pdao.totalPspecCount("1");	// HIT 상품의 전체개수를 알아온다.
		
		System.out.println("확인용" + totalHITCount);
		
		request.setAttribute("totalHITCount", totalHITCount);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/myshop/mallHome1.jsp");
	}

}	

