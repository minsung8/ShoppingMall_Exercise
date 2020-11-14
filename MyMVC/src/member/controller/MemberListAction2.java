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
import my.util.MyUtil;

public class MemberListAction2 extends AbstractController{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 관리자로 로그인 했을 때만 조회가 가능
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
		if (loginuser != null && "admin".equals(loginuser.getUserid())) {
			
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
			
			if (!isInteger(currentShowPageNo) || currentShowPageNo == null) {
				currentShowPageNo = "1";
			} 
			
			if ( !isInteger(sizePerPage) || sizePerPage == null || !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage))) {
				sizePerPage = "10";
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			List<MemberVO> memberList = mdao.selectPagingMember(paraMap);

			request.setAttribute("memberList", memberList);
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			request.setAttribute("sizePerPage", sizePerPage);
			
			/*
			 * 	1개 블럭당 10개씩 잘라서 페이지 만들기 
			 *  1 page에 (3, 5, 10개 행)을 보여주는데 
			 *  만약에 1 page당 5개행을 보여준다라면 
			 *  총 몇개 블럭이 나와야 할까 ?
			 *  
			 *  ex) 총 회원수 207명, 1 page 당 보여줄 회원이 5라면
			 *  42 page가 필요 => 5블락 필요 
			 *  
			 *  1블럭             	1 2 3 4 5 6 7 8 9 10 [다음]
			 *  2블럭  [이전] 11 12 13 14 15 16 17 18 19 20 [다음]
			 */
			
			int totalPage = mdao.getTotalPage(paraMap);
			
			/*
			 * 	currentShowPageNo			startPageNo
			 * 
			 * 1								1	((currentShowPageNo - 1) / blockSize) * blockSize + 1
			 * 2								1	
			 * 3								1
			 * 4								1
			 * 5								1
			 * 6								1
			 * 7								1
			 * 8								1
			 * 9								1
			 * 10								1
			 * 
			 */
			
			String pageBar = "";
			
			int blockSize = 10;
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수까지만 증가
			
			int pageNo = 0;
			// 페이지바에서 보여지는 첫번째 번호
			
			pageNo = ((Integer.parseInt(currentShowPageNo) - 1) / blockSize) * blockSize + 1;
			
			if (searchType == null) {
				searchType = "";
			}
			
			if (searchWord == null) {
				searchWord = "";
			}
			
			// [이전] 만들기
			if ( pageNo != 1) {
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a>&nbsp";
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+(pageNo - 1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp";
			}
			
			while (!(loop > blockSize || pageNo > totalPage)) {
				
				if ( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding: 2px 4px;'>" + pageNo + "</span>&nbsp";
				} else {
					pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>" + pageNo + "</a>&nbsp";
				}
				loop ++;
				pageNo++;
			}
			
			// [다음] 만들기, pageNo update
			if (!(pageNo > totalPage)) {
				
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp";
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a>&nbsp";
			}
			
			request.setAttribute("pageBar", pageBar);
			
			// 현재 페이지를 돌아갈 페이지 주소(goBackURL)로 지정하기
			String currentURL = MyUtil.getCurrentURL(request);
			// 회원 조회 시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 사용
			
			currentURL = currentURL.replaceAll("&", " ");
			System.out.println(currentURL);
	
			request.setAttribute("goBackURL", currentURL);
			
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
	
	static boolean isInteger(String s) { //정수 판별 함수
		try {
	     	Integer.parseInt(s);
	    	return true;
	    } catch(NumberFormatException e) {  //문자열이 나타내는 숫자와 일치하지 않는 타입의 숫자로 변환 시 발생
	    	return false;
	    }
	}
		
}
