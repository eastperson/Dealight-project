<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	.select_img img{
		margin : 20px 0;
	}
	
	/* The Modal (background) */
        .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content/Box */
        .modal-content {
        background-color: #fefefe;
        margin: 15% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 80%; /* Could be more or less, depending on screen size */
        }

        /* The Close Button */
        .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .close:hover,
        .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
        }
        
        /* The Delete Button*/
        .btn_delete {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .btn_delete:hover,
        .btn_delete:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
        }
	
</style>
</head>
<body>
<%@include file="../../../../includes/mainMenu.jsp" %>
<h1>Business Menu Page</h1>

<h2>메뉴 등록</h2> 
<form action="/dealight/business/manage/menu/register" method="post" id="regForm">
	============================================================</br>
	<input name="storeId" value="${storeId}" hidden>
	
	<label for="name">메뉴 이름 : </label>
	<input name="name" required> </br>
	
	<label for="price">메뉴 가격 : </label>
	<input name="price" required> </br>
	
	<label for="recoMenu">메뉴 추천 여부 : </label>
	<input name="recoMenu" type="checkbox"></br>
	
	<div class=""><h2>사진 첨부하기(1개만 가능)</h2></div>
		<div class="file_body">
		<div class="form_img">
			<input type="file" name='uploadFile'>
		</div> 
		<div class='uploadResult'>
			<ul>
			</ul>
		</div> <!-- uploadResult -->
	</div> 
	
	<button type="submit">제출하기</button></br>
	============================================================
</form>
<button>메뉴 수정</button>

<h2>메뉴 리스트</h2>
<c:if test="${empty menus }">
<h2>현재 등록하신 메뉴가 없습니다!🤣</h2>
</c:if>
<c:if test="${not empty menus }">
	<c:forEach items="${menus }" var="menu">
		<div class="menu">
			=========================================
			<span hidden class='menuSeq'>${menu.menuSeq }</span>
			<span hidden class='storeId'>${menu.storeId }</span>
			<span hidden class='name'>${menu.name }</span>
			<span hidden class='price'>${menu.price }</span>
			<span hidden class='thumImgUrl'>${menu.thumImgUrl }</span>
			<span hidden class='recoMenu'>${menu.recoMenu }</span>
			<span hidden class='imgUrl'>${menu.imgUrl }</span>
			<h4>매장 번호 : ${menu.storeId }</h4>
			<h4>메뉴 번호 : ${menu.menuSeq }</h4>
			<h4>메뉴 이름 : ${menu.name }</h4>
			<h4>메뉴 가격 : ${menu.price }</h4>
			<h4>메뉴 사진 : ${menu.thumImgUrl }</h4>
			<h4>메뉴 추천 여부 : ${menu.recoMenu }</h4>
			<h4>메뉴 사진 : </h4><img src="/display?fileName=${menu.encThumImgUrl }">
		</div>
	</c:forEach>
</c:if>

	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<div class="menu_content"></div>
		</div>
	</div>


<script>
/* 동인  */

	const menuUl = $(".menu_content");

	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
	});
	
	$(".menu > *").on("click", e => {
		
		let menuSeq = $(e.target).parent().find(".menuSeq").text(),
			storeId = $(e.target).parent().find(".storeId").text(),
			name = $(e.target).parent().find(".name").text(),
			price = $(e.target).parent().find(".price").text(),
			recoMenu = $(e.target).parent().find(".recoMenu").text(),
			imgUrl = $(e.target).parent().find(".imgUrl").text(),
			thumImgUrl = $(e.target).parent().find(".thumImgUrl").text();
		
		console.log(menuSeq);
		
		recoCheck = '';
		
		if(recoMenu === 'Y')
			recoCheck = 'checked';
		
		let strMenu = "";
		strMenu += "<h2>메뉴 수정</h2>"
		strMenu += "<form id='menuForm' action='' method='post'>";
		strMenu += "매장 번호 : <input type='text' name='storeId' value='"+storeId+"' readonly></br>";
		strMenu += "메뉴 일련 번호 : <input type='text' name='menuSeq' value='"+menuSeq+"' readonly></br>";
		strMenu += "메뉴 이름 : <input type='text' name='name' value='"+name+"'></br>";
		strMenu += "메뉴 가격 : <input type='number' name='price' value='"+price+"'></br>";
		strMenu += "추천 여부 : <input type='checkbox' name='recoMenu' "+recoCheck+"></br>";
		strMenu += "이미지(수정필요) : <input type='text' name='imgUrl' value='"+imgUrl+"' readonly></br>";
		strMenu += "썸네일 이미지(수정필요) : <input type='text' name='thumImgUrl' value='"+thumImgUrl+"' readonly></br>";
		strMenu += "</form>";
		strMenu += "<button data-oper='modify' class='btn_modify'>수정</button>";
		strMenu += "<button data-oper='remove' class='btn_remove'>제거</button>";
		
		$(".menu_content").html(strMenu);
		modal.css("display", "block");
		
		let menuForm = $("#menuForm");
		
		$("button[data-oper='modify']").on("click", function(e){
			
			console.log
			
			menuForm.attr("method", "post");
			menuForm.attr("action", "/dealight/business/manage/menu/modify").submit();
			
		});
		
		$("button[data-oper='remove']").on("click", function(e){
			
			menuForm.attr("method", "post");
			menuForm.attr("action", "/dealight/business/manage/menu/delete").submit();
			
		});
		
	});
	
	/** REST FUL 대기 **/
	let menuService = (() => {
		
		/* 매장 내용 변경 put */
		function putModifyMenu(params, callback,error ){
			
			$.ajax({
				
				type : 'put',
				url : '/dealight/business/manage/menu/modify',
				data : {
					'storeId' : params.storeId,
					'menuSeq' : params.menuSeq,
					'name' : params.name,
					'price' : params.price,
					'recoMenu' : params.recoMenu,
					'imgUrl' : params.imgUrl,
					'thumImgUrl' : params.thumImgUrl
						},
			contentType : 'application/json',
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
			});
		}
		
	});

	

/* 페이지가 로드 되면 실행된다. */
$(document).ready(function(e){
    
    /* form 역할을 하는 엘리먼트를 선택한다. */
	let formObj = $("#regForm");
    
    /* submit 타입의 버튼을 제어한다.*/
	$("button[type='submit']").on("click", function(e){
    
		/* 기존 기능은 제한한다.*/
		e.preventDefault();
		
		console.log("submit clicked");
		
		console.log("form"+formObj);
		
		let str = "";
        
        /* 업로드 결과 화면에 업로드 결과를 작성해준다.*/
	$(".uploadResult ul li").each(function(i, obj) {
			
		if(i !== 0)
			return;
		
		
			let jobj = $(obj);
			
			console.dir(jobj);
			str += "<input type='hidden' name='imgUrl' value='" + jobj.data("path")+"\\"+jobj.data("uuid")+"_"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='thumImgUrl' value='" + jobj.data("path").replace(new RegExp(/\\/g),"/")+"/"+"s_"+jobj.data("uuid")+"_"+jobj.data("filename")+"'>";
			
		});
        
		console.log(str);
		
        /*위에서 작성한 글을 form에 추가하고 제출한다. */
		formObj.attr("method", "post");
		formObj.append(str).submit();
		
	});
   
    /* 정규식으로 파일 형식을 제한한다. */
    let regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
    
    /*최대 파일 크기를 제어한다  */
	let maxSize = 5242880; /* 5MB */
    
    /*업로드 결과를 보여준다. */
	function showUploadResult(uploadResultArr) {
        
        /**업로드 된게 없으면 그대로 반환 */
		if(!uploadResultArr || uploadResultArr.length == 0){return; }
        
        /*업로드 결과를 보여줄 ul를 선택 */
		let uploadUL = $(".uploadResult ul");
		
		let str = "";
        
        /*업로드 결과를 보여준다. */
		$(uploadResultArr).each(function(i,obj){
            
            /* 만일 파일이 이미지 형식이면 */
            /* data에 path,uuid,filename,type을 각각 저장한다. */
			if(obj.image) {
				let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
				let originPath = obj.uploadPath + "\\" + obj.uuid +"_" + obj.fileName;
				
				originPath = originPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li data-path='" + obj.uploadPath +"'";
				str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'";
				str += "><a href=\"javascript:showImage(" + originPath + ")\">" + "<div>";
				str += "<span>" + obj.fileName +"</span>";
				str += "<img src='/display?fileName=" + fileCallPath + "'>";
				str += "</div></a>";
				str += "<button type ='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>삭제</button><br>";
				str += "</li>";
                /* 만일 파일이 이미지 형식이 아니면 */
                /* default img를 보여준다. */
			} else {
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

				str += "<li "
				str += "data-path='" + obj.uploadPath + "'data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "' data-type='" +obj.image+"'><a href='/download?fileName=" + fileCallPath + "'>" + "<div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<img src='/resources/img/attach.png'>";
				str += "</a></div>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>삭제</button><br>";
				str += "</li>";
			}
		});
		uploadUL.append(str);
	}
    
    /*파일 valid check */
	function checkExtension(fileName, fileSize) {
        
        /*파일 사이즈를 체크한다. */
        if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		/*파일 형식을 체크한다. */
		if(regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	
    /* change() 해당하는 요소의 value에 변화가 생길 경우 이를 감지하여 등록된 콜백함수를 동작시킨다.  */
	$("input[type='file']").change(function(e){
		
		let cloneObj = $(".form_img").clone();
		
		let formData = new FormData();
		
		let inputFile = $("input[name='uploadFile']");
		
		let files = inputFile[0].files;
		
		for(let i = 0; i < files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)) {
				return false;
            }
            /* uploadFile 이라는 변수명에 파일 배열(스프링에서는 MultipartFile[]로 받는다)을 달아서보낸다. */
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url : '/uploadAjaxAction',
			processData : false,
            contentType : false, 
            data: formData,
            type: 'POST',
			dataType : 'json',
			success : function(result) {
			    console.log(result);
			    showUploadResult(result); // 업로드 결과 처리 함수
			    $(".form_img").html(cloneObj.html()); // 첨부파일 개수 초기화
			}
			
			
		})
		
	});
    
    /* 업로드 결과를 누르면 해당 파일을 제거한다.  */
	$(".uploadResult").on("click", "button", function(e) {
		
		let targetFile = $(this).data("file");
		
		console.log(targetFile);
		
		let type = $(this).data("type");
		
		console.log(type);
		
		let targetLi = $(this).closest("li");
		
		console.log(targetLi);
		
		$.ajax({
			url : '/deleteFile',
			data : {fileName : targetFile, type:type},
			dataType : 'text',
			type : 'POST',
			success : function(result) {
				alert(result);
				targetLi.remove();
			}
		}); // $.ajax
	});
	
	$(".uploadResult").on("click", "li", function(e){
        
        console.log("view image");
        
        let liObj = $(this);
        
        let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
        
        if(liObj.data("type")){
            
            showImage(path.replace(new RegExp(/\\/g), "/"));
        } else {
            //download
            self.location = "/download?fileName=" + path
        }
    });
	
	function showImage(fileCallPath) {
		
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName=" +encodeURI(fileCallPath) + "'>")
		.animate({width:'100%',height:'100%'},1000);
		
		
	}// end show image
	
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%',height:'0%'},1000);
		setTimeout(()=>{
			$(this).hide();
		}, 1000);
	});
}); // ready end
</script>
</body>
</html>