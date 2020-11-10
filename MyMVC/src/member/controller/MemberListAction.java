package member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
			
		if (loginuser != null && loginuser.getUserid().equals("admin")) {
			
			InterMemberDAO mdao = new MemberDAO();
			
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);			
			
			
			// *** 페이징 처리 후 회원목록 보여주기
			
			// 회원목록을 처음 클릭했을 경우 null 값 => 1페이지로 지정
			String currentShowPageNo = request.getParameter("currentShowPageNo");	
			
			// 회원목록을 처음 클릭했을 경우 null 값  => 10개로 지정
			String sizePerPage = request.getParameter("sizePerPage");
			
			if (currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			if (sizePerPage == null || !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage))) {
				sizePerPage = "10";
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			List<MemberVO> memberList = mdao.selectPagingMember(paraMap);

			request.setAttribute("memberList", memberList);
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			request.setAttribute("sizePerPage", sizePerPage);
			
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
