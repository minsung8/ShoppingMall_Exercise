package myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.PurchaseReviewsVO;

public class CommentListAction extends AbstractController{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String fk_pnum = request.getParameter("fk_pnum");
		
		InterProductDAO pdao = new ProductDAO();
		
		JSONArray jsArr = new JSONArray();
		
		List<PurchaseReviewsVO> commentList = pdao.commentList(fk_pnum);
		
		if (commentList != null && commentList.size() > 0) {
			
			for ( PurchaseReviewsVO reviewsVO: commentList ) {
				JSONObject jsobj = new JSONObject();
				jsobj.put("contents", reviewsVO.getContents());
				jsobj.put("name", reviewsVO.getMvo().getName());
				jsobj.put("writeDate", reviewsVO.getWriteDate());
				
				jsArr.put(jsobj);		// 
			}
			
		}
		
		String json = jsArr.toString();
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
