<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 수빈 -->
<%@ include file="../../../../includes/mainMenu.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script>
//로그인이 안된 상태면 메인페이지로 넘어가게
let msg = '${msg}';
  if(msg != ""){
     alert(msg);
     location.href = '/dealight/dealight';
  }
</script>

<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	<h1>예약 내역 -> 리뷰 등록 페이지</h1>

	<form id="registerRevw" action="/dealight/mypage/review/register/rsvd" method="post"
		onsubmit="return checkSubmit(this);"> 

		매장번호: ${rsvd.store.storeId } <br />
		예약번호: ${rsvd.rsvdId } <br />
		매장사진: ${rsvd.bstore.repImg } <br />
		매장명: ${rsvd.store.storeNm } <br />
		예약날짜: <fmt:formatDate pattern="yyyy-MM-dd" value="${rsvd.regdate }" /> <br />
		예약메뉴: ${rsvd.dtls.menuNm } <br /> <br />
		
		<label>상품에 만족하십니까?</label> <br />
		<input type="number" min="0" max="5" step="0.5"
			class="rating" name="rating" required placeholder="0~5점 "
			oninvalid="alert('1~5점 사이로 평점을 입력해주세요.')"> <br /> <br />
		
		<label>리뷰 내용</label> <br />
		<textarea class="cnts" id="cnts" rows="10" name="cnts" required
			placeholder="리뷰를 작성해주세요 (최소 10자, 최대 100자 이내)"></textarea> <br /> <br />
		
		<label>사진 첨부</label> <br />
		<textarea class="imgUrl" rows="3" name="imgUrl" required
			placeholder="(임시)이미지 url을 문자열로 입력해주세요."></textarea> <br /> <br />
		<!-- <input type="file" name="uploadRevwImg" multiple> <br /> <br /> -->
		
		<button type="submit" class="submitbtn">등록</button>
		<button type="button" class="closebtn">취소</button>
		
		<!-- hidden으로 보낼 정보 -->
		<input type="hidden" name="storeNm" value="${rsvd.store.storeNm }" />
		<input type="hidden" name="storeId" value="${rsvd.store.storeId }" />
		<input type="hidden" name="rsvdId" value="${rsvd.rsvdId }" />
		<input type="hidden" name="userId" value="${rsvd.userId }" />
		
	</form>
	
	<script>
		// 리뷰 내용 유효성 검사
		var cnts = document.getElementById("cnts");
		
		function checkSubmit(i) {
			
			if(cnts.value.length < 10) {
				/* cnts.value = cnts.value.substr(0, 10); */
				alert("최소 10자 이상의 리뷰를 작성해주세요.");
				return false;
			}
			
			if(cnts.value.length > 100) {
				cnts.value = cnts.value.substr(0, 100);
				alert("100자 이내의 내용만 입력 가능합니다.");
				return false;
			}
			
		};
		
	</script>
</body>
</html>