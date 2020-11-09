package member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberListAction extends AbstractController{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 관리자로 로그인 했을 때만 조회가 가능
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if (loginuser != null && loginuser.getUserid() == "admin") {
			
			InterMemberDAO mdao = new MemberDAO();
			
			// *** 페이징 처리를 안한 회원목록 보여주기 
			List<MemberVO> memberList = mdao.selectAllMember();
			
			request.setAttribute("memberList", memberList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberList.jsp");
			
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
