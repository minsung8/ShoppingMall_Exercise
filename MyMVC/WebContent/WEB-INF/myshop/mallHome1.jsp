<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

<style>
	
	.moreProdInfo {
		display: inline-block;
		margin : 10px;
	}
	
</style>

<script>
	
	$(document).ready(function () {
		
		displayHIT("1");
		
		// HIT 상품 게시물을 더보기 위하여
		$("button#btnMoreHIT").click(function() {
			
			if ( $(this).text() == "처음으로 " ) {
				
				$("div#displayHIT").empty();
				$("span#end").empty();
				displayHIT("1");
				$(this).text("더보기...");
				
			} else {
				displayHIT( $(this).val() );
			}
			
			
		});
		
	});
	
	var lenHIT = 8;			// 상수
	
	// display 할 HIT 상품 정보를 추가 요청하기(Ajax로 처리)
	function displayHIT(start) {		// start = 1 > 1~8 까지 상품 8개를 보여준다
										// start = 2 > 9~16 까지 상품 8개를 보여준다
										// ...
							
		alert("json 함수 실행 성공");
										
		$.ajax({
			url:"/MyMVC/shop/mallDisplayJSON.up",
		//	type:"GET", 생략 시 GET
			data:{"sname":"HIT"
				,"start":start		// "1"
				,"len":lenHIT},		// 8
		    dataType:"JSON",
				sucess:function(json) {
					
					// if select 정보가 없다면 [] => not null
					
					alert("성공");
					
					var html = "";
					if ( json.length > 0 ) {
						
						$.each( json, function(index, item) {
							html +=  "<div class='moreProdInfo'> <img width='120px' height='130px' src='/MyMVC/images/ "+item.pimage1+"' />"
									+ "</div>";
							
							if ( (index + 1)%4 == 0 ) {
								html += "<br>";
							}
						});
					
						// HIT 상품 결과를 출력하기
						$("div#displayHIT").append(html);
						
						// >>> !!! 중요 !!! 더보기...  버튼의 value 속성에 값을 지정하기 <<<
						$("button#btnMoreHIT").val( Number(start) + lenHIT );
						// 더보기... 버튼의 value값이 9로 변경
						
						// 지금까지 출력된 상품의 개수를 누적해서 기록
						$("span#countHIT").text( Number($("span#countHIT").text()) + json.length );
						
						// 더보기... 버튼을 계속해서 클릭하여 CountHIT 값과 totalHITCount값이 일치할경우
						if ( $("span#countHIT").text() == $("totalHITCount").text() ) {
							$("span#end").html("더이상 조회할 제품이 없습니다");
							$("button#btnMoreHIT").text("처음으로");
							$("span#countHIT").text("0");
						}
					} 
			

					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			
			
		});
		
	}
	
</script>

	<%-- === HIT 상품을 모두 가져와서 디스플레이(더보기 방식으로 페이징 처리한 것) === --%>

<div>
	<div style="margin: 20px 0;" >- HIT 상품 -</div>
	<div id="displayHIT">
	</div>
	
	<div style="margin: 20px 0;"> 
	<span id="end" style="font-size: 16pt; font-weight: bold; color: red;">
	</span><br/>
	<button type="button" id="btnMoreHIT" value="">더보기...</button>
	<span id="totalHITCount">${totalHITCount}</span>
	<span id="countHIT">0</span> 
	</div>
</div>

<jsp:include page="../footer.jsp" />1