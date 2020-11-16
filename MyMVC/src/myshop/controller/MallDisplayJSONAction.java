package myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ProductVO;

public class MallDisplayJSONAction extends AbstractController{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String sname = request.getParameter("sname");
		String start = request.getParameter("start");
		String len = request.getParameter("len");

		
		// 맨 처음에는 1 ~ 8, 더보기 button 누르면 8 ~ 17 , ...
		
		InterProductDAO pdao = new ProductDAO();
		
		Map<String, String> paraMap = new HashMap<>();
	
		String end = String.valueOf( Integer.parseInt(start) + Integer.parseInt(len) - 1 );
		
		paraMap.put("sname", sname);
		paraMap.put("start", start);
		paraMap.put("end", end);
		
		List<ProductVO> prodList = pdao.selectBySpecName(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if (prodList.size() > 0) {
			
			for (ProductVO pvo : prodList) {
				
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("pnum", pvo.getPnum());
				jsonObj.put("pname", pvo.getPname());
				jsonObj.put("code", pvo.getCategvo().getCode());
				jsonObj.put("pcompany", pvo.getPcompany());
				jsonObj.put("pimage1", pvo.getPimage1());
				jsonObj.put("pimage2", pvo.getPimage2());
				jsonObj.put("pqty", pvo.getPqty()); 
				jsonObj.put("price", pvo.getPrice());
				jsonObj.put("saleprice", pvo.getSaleprice());
				jsonObj.put("sname", pvo.getSpvo().getSname());
				jsonObj.put("pcontent", pvo.getPcontent());
				jsonObj.put("point", pvo.getPoint());
				jsonObj.put("pinputdate", pvo.getPinputdate());
				jsonObj.put("discoutPercent", pvo.getDiscountPercent());
				
				jsonArr.put(jsonObj);
			
			}
			
			String json = jsonArr.toString();
						
			request.setAttribute("json", json);
		
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		
	}
	
	
}
