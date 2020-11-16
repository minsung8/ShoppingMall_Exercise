package myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.SpecVO;

public class ProductRegisterAction extends AbstractController{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// == 관리자로 로그인 했을 때만 제품등록이 가능하도록 한다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
		if (loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String method = request.getMethod();
			if (!"POST".equalsIgnoreCase(method)) {	// get 방식이라면
				
				// 카테고리 목록 조회해오기
				super.getCategoryList(request);
				
				// spec 목록을 보여주고자 한다.
				InterProductDAO pdao = new ProductDAO();
				List<SpecVO> specList = pdao.selectSpecList();
				
				request.setAttribute("specList", specList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/myshop/admin/productRegister.jsp");
				
			} else {		// post 방식
				
			}
			
		} else {
			String message = "관리자만 접근 가능";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
			
		
	}

}
