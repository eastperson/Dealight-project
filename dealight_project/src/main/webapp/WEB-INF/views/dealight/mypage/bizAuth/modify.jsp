<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 현중 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자등록페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
.container {
  border: 2px solid #ccc;
  background-color: #eee;
  border-radius: 5px;
  padding: 16px;
  margin: 16px 0;
  .uploadResult{
	width:100%;
	background-color: gray;
}
.uploadResult ul{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li{
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}
.uploadResult ul li img{
	width: 100px;
}
.uploadResult ul li span{
	color:white;
}
.bigPictureWrapper{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}
.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img {
	width: 600px;
}
}
</style>
</head>
<body>

<div class="container">
	<form action="/dealight/mypage/bizAuth/modify" method="post" name="modify">
		<label>ID</label><input type="text" name="userId" value="${buser.userId }" readonly="readonly"><br>
		<label>심사코드</label><input type="text" name="userId" value="${buser.brJdgStusCd }" readonly="readonly"><br>
		<label>접수날짜</label><input type="text" name="regdate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${buser.regdate }"/>'><br>
		-----------------><br>
		<label>심사번호</label><input type="text" name="brSeq" value="${buser.brSeq }" readonly="readonly"><br>
		<label>대표자명</label><input type="text" name="name" value="${buser.repName }" ><br>
		<label>매장명</label><input type="text" name="storeNm" value="${buser.storeNm}" ><br>
		<label>휴대전화</label><input type="text" name="telno" value="${buser.telno }" ><br>
		<label>사업장전화번호</label><input type="text" name="storeTelno" value="${buser.storeTelno }" ><br>
		<label>사업자등록번호</label><input type="text" name="brno" value="${buser.brno }" ><br>
		<label>수정날짜</label><input type="text" name="updatedate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${buser.updatedate }"/>'><br>
		<input type="hidden" name="brPhotoSrc" value="${buser.brPhotoSrc }" ><br>
	</form>
<div>
	
	
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
		<button class="modifybtn" data-oper="modify" >수정하기</button>
		<button class="removebtn" data-oper="remove">삭제하기</button>
		<button class="listbtn" data-oper="list" >목록으로</button>
	</div>

</div>
<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>



</body>
</html>
<script>

window.onload = function(){
	(function(){
		let brPhotoSrc = (document.getElementsByName("brPhotoSrc")[0]).value;
		let srcObj = subSrc(brPhotoSrc);
		console.log(srcObj)
		
		let str = "";
		
		
		let fileCallPath = encodeURIComponent( "/"+ srcObj["uploadPath"] +"/s_"+ srcObj["fileName"]);
		console.log(fileCallPath)
		str += "<li data-path='"+ srcObj["uploadPath"] +"'";
		str += "data-filename=\'"+ srcObj["fileName"] +"\'><div>";
		str += "<img src='/display?fileName=" + fileCallPath + "'>";
		str += "</div>";
		str += "</li>";
		
		$(".uploadResult ul").html(str);
	})();

	//버튼 클릭 이벤트
	
	const formObj = $("form");
	$('button').on("click",function(e){
		let operation = $(this).data('oper');
		
		console.log(operation);
		
		if(operation ==='remove'){
			formObj.attr("action", "/dealight/mypage/bizAuth/remove");
		}else if(operation === 'list'){
			formObj.attr("action", "/dealight/mypage/bizAuth/list").attr("method", "get");
			formObj.empty();
		}
		formObj.submit();
	})
	
	const uploadUL = $(".uploadResult ul");
	
	$(".uploadResult").on("click","li", function(e){
		
		console.log("view image");
		
		var liObj = $(this);
		
		let path = encodeURIComponent( "/" + liObj.data("path")+"/" + liObj.data("filename"));
		
		
		showImage(path.replace(new RegExp(/\\/g), "/"));
		
	});
	
	//이미지창 닫기
	$(".bigPictureWrapper").on("click", function(e){
		
		$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
		setTimeout(function(){
			$(".bigPictureWrapper").hide();
		},1000);
		
	});
	
	function showImage(fileCallPath){
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width:'100%', height:'100%'}, 1000);
	}
	
}
function subSrc(PhotoSrc){
	let srcObj = {};
	let index = PhotoSrc.lastIndexOf("/");
	
	srcObj["uploadPath"] = PhotoSrc.substring(0,index);
	srcObj["fileName"] = PhotoSrc.substring(index + 1);
	
	return srcObj;
}
	
</script>