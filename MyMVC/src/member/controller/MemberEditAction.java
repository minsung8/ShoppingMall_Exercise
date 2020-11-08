package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class MemberEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 내 정보를 수정하기 위한 전제조건 => 로그인
		if (super.checkLogin(request)) {
			
			String userid = request.getParameter("userid");
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			if ( loginuser.getUserid().equals(userid) ) {	// 로그인유저가 자신의 정보 수정
				
				super.setViewPage("/WEB-INF/member/memberEdit.jsp");
				
			} else {			// 로그인유저가 다른 유저의 정보 수정할 경우
				String message = "다른 유저의 정보 수정은 불가합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
		} else {
			String message = "회원정보를 수정하기 위해서는 먼저 로그인을 하세요!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}
	
}
