<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    

<jsp:include page="../header.jsp"/>

<style type="text/css">
	div#mvoInfo { width: 60%; text-align: left; border: solid 0px red; margin-top: 30px; font-size: 13pt; line-height: 200%; }
	span.myli { display: inline-block; width: 90px; border: solid 0px blue; }
	
	div#sms { margin: 0 auto; /* border: solid 1px red; */ overflow: hidden; width: 50%; padding: 10px 0 10px 80px; }
	span#smsTitle { display: block; font-size: 13pt; font-weight: bold; margin-bottom: 10px; } 
	textarea#smsContent { float: left; height: 100px; } 
	button#btnSend { float: left; border: none; width: 50px; height: 100px; background-color: navy; color: white; } 
	div#smsResult { clear: both; color: red; padding: 20px; }
</style>

<script type="text/javascript">
	
	var goBackURL = "";
	
	$(document).ready(function() {
		
        $("div#smsResult").show();

		
		 $("button#btnSend").click(function() {
			 	
	            $.ajax({
	               url:"/MyMVC/member/smsSend.up", 
	               type:"POST",
	               data:{"mobile":"${mvo.mobile}",
	                    "smsContent":$("textarea#smsContent").val()},
	               dataType:"json",
	               success:function(json){
	                  // json은 {"group_id":"R2Gx8ut4auVrqQsv","success_count":1,"error_count":0} 처럼 된다.
	                  if(json.success_count == 1){
	                	  alert("성공");
	                     $("div#smsResult").html("문자전송이 성공되었습니다.");
	                  }
	                  else if(error_count != 0){
	                	  alert("실패");
	                     $("div#smsResult").html("문자전송이 실패되었습니다.");
	                  }
	                  
	                  $("div#smsResult").show();
	                  
	               },
	               error: function(request, status, error){
	                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	               }

	         });
	      });
		 
		 goBackURL = "${goBackURL}";
		 
		 
		 // javascript => 공백을 모두 &로  변경
		 // ex)  문자열.replace(/ /gi, "&");
		 goBackURL = goBackURL.replace(/ /gi, "&");
	     
		 console.log(goBackURL);

	});
	
	function goMemberList() {
		alert(goBackURL);
		location.href = "/MyMVC/" + goBackURL;
	}
	
</script>

<c:if test="${ empty mvo }">>
	존재하지 않는 회원입니다.<br>
</c:if>

<c:if test="${ not empty mvo }">>
	<div id="mvoInfo">
	 <ol>
	  <li><span class="myli">아이디 : </span>${mvo.userid}</li>
	  <li><span class="myli">회원명 : </span>${mvo.name}</li> 
	  <li><span class="myli">이메일 : </span>${mvo.email}</li> 
	  <li><span class="myli">휴대폰 : </span>${ fn:substring(mvo.mobile, 0, 3)} - ${ fn:substring(mvo.mobile, 3, 7)} - ${ fn:substring(mvo.mobile, 7, 11)} </li> 
	  <li><span class="myli">우편번호 : </span>${mvo.postcode}</li> 
	  <li><span class="myli">주소 : </span>${mvo.address}&nbsp;${mvo.detailaddress}&nbsp;${mvo.extraaddress}</li> 
	  <li><span class="myli">성별 : </span> 
							<c:choose>
						
								<c:when test="${mvo.gender eq '1'}">
									남
								</c:when>
								
								<c:otherwise>
									여
								</c:otherwise>
							
							</c:choose>  
	  </li>
	  <li><span class="myli">생년월일 : </span>${ fn:substring(mvo.birthday, 0, 4)}.${ fn:substring(mvo.birthday, 4, 6)}.${ fn:substring(mvo.birthday, 6, 8)}</li> 
	  <li><span class="myli">나이 : </span>${mvo.age}세</li> 
	  <li><span class="myli">코인액 : </span><fmt:formatNumber value="${mvo.coin}" pattern="###,###" /> 원</li> 
	  <li><span class="myli">포인트 : </span><fmt:formatNumber value="${mvo.point}" pattern="###,###" /> POINT</li> 
	  <li><span class="myli">가입일자 : </span>${mvo.registerday}</li> 
	  </ol> 
	  </div>
	  
	  <%-- === 휴대폰 SMS 문자 보내기 === --%>
	  <div id="sms" align="left"> 
		  <span id="smsTitle">&gt;&gt;휴대폰 SMS(문자) 보내기 내용 입력란&lt;&lt;</span> 
		  <textarea rows="4" cols="40" id="smsContent"></textarea> 
		  <button id="btnSend">전송</button>
		  <div id="smsResult">
		  </div> 
	  </div>
	
</c:if>

<div>
	<button style="margin-top : 50px;" type="button" onclick="javascript:history.back()">회원목록</button>
	&nbsp;&nbsp;
	<button style="margin-top : 50px;" type="button" onclick="goMemberList()">회원목록2</button>
</div>

<jsp:include page="../footer.jsp"/>