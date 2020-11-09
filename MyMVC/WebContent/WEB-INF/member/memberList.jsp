<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>
<%-- 회원번호 지우기 --%>



<jsp:include page="../header.jsp"/>

<style type="text/css">

</style>

<script>
	$(document).ready(function() {
		
	});
</script>

<body>
<h2 style="margin: 20px;">::: 회원전체 목록 :::</h2>
 <form name="memberFrm"> 
 <select id="searchType" name="searchType"> 
 	<option value="name">회원명</option>
 	 <option value="userid">아이디</option> 
 	<option value="email">이메일</option>
 </select> <input type="text" id="searchWord" name="searchWord" />
 	<input type="text" style="display: none;"> 
 	<button type="button" onclick="goSearch();" style="margin-right: 30px;">검색</button> 
 	<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 회원명수-</span>
 	 <select id="sizePerPage" name="sizePerPage"> <option value="10">10</option>
 	  <option value="5">5</option> <option value="3">3</option> </select> </form>
 	   <table id="memberTbl" class="table table-bordered" style="width: 90%; margin-top: 20px;">
 	   	 <thead> 
 	   	 	<tr>
 	   	 		 <th>회원번호</th> 
 	   	 		 <th>아이디</th>
 	   	 		  <th>회원명</th> 
 	   	 		  <th>이메일</th>
 	   	 		   <th>성별</th> 
 	   	 	</tr>
 	   	  </thead>
 	    <tbody>
 	     <%-- 일단은 페이징처리를 안한 관리자를 제외한 모든 회원정보를 조회하도록 한다. --%>
			<c:foreach var="mvo" items="${memberList}">
				<tr>
					<td>${mvo.userid}</td>
					<td>${mvo.name}</td>
					<td>${mvo.email}</td>
					<td>
						<c:choose>
							<c:when test="${mvo.gender eq '1'}">
								남
							</c:when>
							<c:oterwise>
								남
							</c:oterwise>
						</c:choose>
					</td>
				</tr>
			</c:foreach>
 	    </tbody> 
 	      </table>
 	       <div>

 	      </div>
</body>

<jsp:include page="../footer.jsp"/>

