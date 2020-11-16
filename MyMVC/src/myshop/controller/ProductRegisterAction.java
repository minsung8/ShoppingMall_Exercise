package myshop.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
				
			/* 파일을 첨부해서 보내는 폼태그가 enctype="multipart/form-data" 으로 되어었다라면 HttpServletRequest request 을 사용해서는 데이터값을 받아올 수 없다. 
			 * 이때는 cos.jar 라이브러리를 다운받아 사용하도록 한 후 아래의 객체를 사용해서 데이터 값 및 첨부되어진 파일까지 받아올 수 있다. */
				MultipartRequest mtrequest = null;
				/* MultipartRequest mtrequest 은 HttpServletRequest request 가
				 *  하던일을 그대로 승계받아서 일처리를 해주고 동시에 파일을 받아서 업로드, 다운로드까지 해주는 기능이 있다. */
			
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
				HttpSession sesssion = request.getSession();
				
				ServletContext svlCtx = sesssion.getServletContext();
				String imagesDir = svlCtx.getRealPath("/images");
				
				System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 imagesDir ==> " + imagesDir);
				// === 첨부되어지는 이미지 파일이 올라가는 절대경로 imagesDir ==> C:\NCS\workspace(jsp)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MyMVC\images
				/* MultipartRequest의 객체가 생성됨과 동시에 파일 업로드가 이루어 진다. MultipartRequest(HttpServletRequest request,
				 * 																		 String saveDirectory, -- 파일이 저장될 경로 
				 * 																		 int maxPostSize, -- 업로드할 파일 1개의 최대 크기(byte) 
				 * 																		 String encoding, FileRenamePolicy policy) -- 중복된 파일명이 올라갈 경우 파일명다음에 자동으로 숫자가 붙어서 올라간다. 파일을 저장할 디렉토리를 지정할 수 있으며, 업로드제한 용량을 설정할 수 있다.(바이트단위). 이때 업로드 제한 용량을 넘어서 업로드를 시도하면 IOException 발생된다. 또한 국제화 지원을 위한 인코딩 방식을 지정할 수 있으며, 중복 파일 처리 인터페이스를사용할 수 있다. 이때 업로드 파일 크기의 최대크기를 초과하는 경우이라면 IOException 이 발생된다. 그러므로 Exception 처리를 해주어야 한다. */
				
				try { // === 파일을 업로드 해준다. === 
					mtrequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy() );
					} catch(IOException e) {
						request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!"); 
						request.setAttribute("loc", request.getContextPath()+"/shop/admin/productRegister.up"); 
						super.setViewPage("/WEB-INF/msg.jsp"); 
						return; 
						}
				// 다음으로 DB에 업로드 된 제품정보를 테이블에 Insert를 해주어야 한다.
				
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
