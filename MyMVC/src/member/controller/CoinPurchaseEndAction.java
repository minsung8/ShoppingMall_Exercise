package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class CoinPurchaseEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 결제창을 사용하기 위한 전제조건 => 로그인
		if (super.checkLogin(request)) {
			
			String userid = request.getParameter("userid");
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			if ( loginuser.getUserid().equals(userid) ) {	// 로그인유저가 자신의 코인 충전
				String coinmoney = request.getParameter("coinmoney");
				request.setAttribute("coinmoney", coinmoney);
				request.setAttribute("email", loginuser.getEmail());
				request.setAttribute("name", loginuser.getName());
				request.setAttribute("userid", userid);
				
				super.setViewPage("/WEB-INF/member/paymentGateway.jsp");
				
			} else {			// 로그인유저가 다른 유저의 코인 충전
				String message = "다른 유저의 코인 결제는 불가합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
		} else {
			String message = "코인충전을 하기 위해서는 먼저 로그인을 하세요!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}
