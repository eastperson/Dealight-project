<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<!--  common  -->
<link rel="stylesheet" href="/resources/css/common.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/main_footer.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/main_header.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/alert_manager.css" type ="text/css" />
<link rel="shortcut icon" href="/resources/icon/favicon.png" type="image/x-icon">
<link rel="icon" href="/resources/icon/favicon.png" type="image/x-icon">
<!--  end common  -->

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- Add icon library -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>


.top {
	overflow: hidden;
	flex: 1;
	/* 비율을 1:1:1로 주기 */
	height: 35px;
	display: inline-block;
	z-index: 0;
}

.dropbtn {
	margin-top: 0;
	padding-left: 10px;
	border: none;
	outline: none;
	font-size: 30px;
	cursor: pointer;
	display: inline-block;
}

.dropdown {
	position: absolute;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	min-width: 160px;
	z-index: 1;
	background-color: #f1f1f1;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

.dropdown-content a {
	display: block;
	padding: 3px;
	color: black;
	font-size: 15px;
	text-decoration: none;
}

.dropdown-content a:hover {
	background-color: crimson;
	color: white;
}

.dropbtn:hover .dropdown-content {
	display: block;
	z-index: 99;
}

.logo {
	margin-left: 40%;
	padding: 3px 8px;
	display: inline-block;
	height: 100%;
	text-align: center;
	font-size: 30px;
}

.logo-content {
	float: left;
}

.rightIcon {
	float: right;
	padding: 3px 8px;
	font-size: 28px;
}

.mydropbtn {
	color: white;
	z-index: 1;
}

.mydropdown {
	position: relative;
	display: inline-block;
}

.mydropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.mydropdown-content a {
	color: black;
	font-size: 15px;
	padding: 3px 5px;
	text-decoration: none;
	display: block;
}

.mydropdown-content a:hover {
	background-color: #ddd;
}

.mydropdown:hover .mydropdown-content {
	display: block;
}

.middleDiv {
	width: 100%;
	height: 600px;
	position: relative;
}

.imgContainer {
	width: 100%;
	height: 100%;
	position: absolute;
}

.imgContainer img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

.searchBarDiv {
	border: 1px solid black;
	margin: 0 auto;
	margin-top: 100px;
	width: 40%;
	height: 100px;
	position: relative;
}

.topRow {
	border: 1px solid black;
	display: inline-block;
	width: 100%;
	height: 50%;
	background-color: white;
}

.topRowBar {
	border: 1px solid black;
	float: left;
	width: 33.33%;
	height: 100%;
}

.bottomRow {
	border: 1px solid black;
	display: block;
	position: absolute;
	top: 50%;
	width: 100%;
	height: 50%;
	background-color: white;
}

.bottomRowBar {
	border: 1px solid black;
	float: left;
	width: 80%;
	height: 100%;
}

.searchbtn {
	background-color: crimson;
	color: white;
	width: 20%;
	height: 100%;
	border: none;
}

.dealTitleDiv {
	border: 1px solid rgb(151, 151, 151);
	width: 80%;
	height: 50px;
	margin: 30px auto 0 auto;
}

.dealTitle {
	border: 1px solid black;
	width: 150px;
	height: 100%;
	display: inline-block;
}

.dealDiv {
	border: 1px solid black;
	width: 80%;
	height: 1200px;
	margin: auto;
	overflow: hidden;
}

.dealContainer {
	border: 1px solid black;
	display: inline-block;
	margin: 23px 30px;
	width: 28%;
	height: 350px;
}

.dealImg {
	border: 1px solid black;
	display: block;
	width: 100%;
	height: 70%;
}

.dealText {
	border: 1px solid black;
	display: block;
	width: 100%;
	height: 30%;
}

.footer {
	border: 1px solid black;
	width: 100%;
	height: 180px; 
	z-index: 1;
	cursor: pointer;
}

/* add style */



/* end added style*/


</style>
</head>
<body>
<header class="main_nav">
        <nav class="main_nav_left">
        	<div class="main_nav_logo"><img id="logo" src="/resources/icon/d2.png" alt=""></div>
        </nav>
        
        <nav class="main_nav_right">
            <div><c:if test="${userId != null}"> <span id="nav_user_id">${userId }님</span></c:if></div>
            <div class="nav_reg_brno"><a href="/dealight/mypage/bizauth/list">매장 등록</a></div>
            <div class="account_btn">
            	<div class="account_icon_box">
            		<div class="account_menu"><i class="fas fa-bars"></i></div>
            		<div class="account_icon"><i class="fas fa-user-circle"></i></div>
            		<div class="account-dropdown-content">
						<div class="common_menu_cnts">
							<div class="account_cnts"><a href="/dealight/hotdeal/main">핫딜 찾기</a></div>
	        				<div class="account_cnts"><a href="/dealight/search/">매장 찾기</a></div>
	        			</div>
						<sec:authorize access="isAnonymous()">
								<div class="account_cnts"><a href="/dealight/login">로그인</a></div>
								<div class="account_cnts"><a href="/dealight/register">회원가입</a></div>
						</sec:authorize>

						<sec:authorize access="isAuthenticated()">
							<sec:authorize access="hasRole('ROLE_USER')">
								<div class="account_cnts"><a href="/dealight/mypage/reservation">예약 내역</a></div> 
								<div class="account_cnts"><a href="/dealight/mypage/wait">웨이팅 내역</a></div>
								<div class="account_cnts"><a href="/dealight/mypage/review/">나의 리뷰</a></div>
								<div class="account_cnts"><a href="/dealight/mypage/like">찜 목록</a> </div>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_MEMBER')">								
								<div class="account_cnts"><a href="/dealight/business/">매장 관리</a></div>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ADMIN')">								
								<div class="account_cnts"><a href="/dealight/mypage/business/">서비스 관리</a></div>
							</sec:authorize>
								<div class="account_cnts"><a href="/dealight/mypage/modify">회원정보수정</a></div>
								<div class="account_cnts"><a href="dealight/logout" onclick="submit(event)">로그아웃</a></div>
						</sec:authorize>
					</div>
            	</div>
            </div>
        </nav>
    </header>
   		<div class="alert manage_rsvd hide">
		  <span class="alert_closebtn">&times;</span>  
		  <strong class="alert_tit">예약</strong>
		  <span class="alert_senduser"></span>
		  <span class="alert_msg">예약 관련 notification 입니다.</span>
		</div>
		
		<div class="alert manage_wait hide">
		  <span class="alert_closebtn">&times;</span>  
		  <strong class="alert_tit">웨이팅</strong>
		  <span class="alert_senduser"></span>
		  <span class="alert_msg">웨이팅 관련 notification 입니다.</span>
		</div>
		
		<div class="alert manage_htdl hide">
		  <span class="alert_closebtn">&times;</span>  
		  <strong class="alert_tit">핫딜</strong>
		  <span class="alert_senduser"></span>
		  <span class="alert_msg">핫딜 관련 notification 입니다.</span>
		  <span class="alert_dto"></span>
		  <button class='btnAcceptHtdl'>핫딜 등록</button>
		  <button class="alert_closebtn">거절</button>
		</div>
	
	<script>

	//로그아웃 폼 제출
	function submit(e){
		e.preventDefault();
		let body = $("body");
		let form = $("<form></form>");
		form.attr("action", "/logout");
		form.attr("method", "post");
		
		let csrfInput = $("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>");
		form.append(csrfInput);
		form.appendTo(body);
		form.submit();
		
	}
	
	$("#logo").on("click",function(e){
		
		self.location.href="/dealight/dealight";
	});
	
	
 //1. 버튼을 누르면 모달창이 띄어지고, 배경 회색으로 변경
   function openModal(){
       document.getElementById('content').style.display='block';
       document.body.style.backgroundColor = "rgba(0,0,0,0.4)";

}

//2. X버튼을 누르면 모달창이 사라지고 원상복귀
   function closebtn(){
   document.getElementById('content').style.display='none';
   document.body.style.backgroundColor = "white";
}

//3. login상태에서 사람모양 클릭시 mypage(예약내역)로 이동
function goMypage(){
	 location.href="/dealight/mypage/reservation";

}

/* web socket!!!!!!!!!!!!!!!!!!!!*/
/* 	<div id="socketAlert" class="alert alert-success" role="alert"">알림!!!</div> */
	let socket = null;

	 function connectWS() {
		// 전역변수 socket을 선언한다.
		// 다른 페이지 어디서든 소켓을 불러올 수 있어야 하기 때문이다.
		
	 	// 소켓을 ws로 연다.
	 	var ws = new WebSocket("ws://localhost:8181/manageSocket");
	 	socket = ws;

	 	// 커넥션이 연결되었는지 확인한다.
	 	ws.onopen = function () {
	 	    console.log('Info: connection opened.');
	 	};

	 	
	 	// 받은 메시지를 출력한다.
	 	// 메시지를 수신한 이벤트 핸들러와 같다.
	 	ws.onmessage = function (event) {
	 	    console.log("ReceiveMessage : ", event.data+'\n');
	 	    
	 	    // 추후에 message 형식을 JSON으로 변환해서 message type을 지정해줘야 한다.
	 	    //if()
	 	    	
	 	   	//alert(event.data);
	 	    console.log(typeof event.data);
	 	    
	 	    let data = JSON.parse(event.data);
	 	    
	 	    console.log(typeof data);
	 	    console.log("cmd : "+data.cmd);
	 		console.log("sendUser : "+data.sendUser);
	 	    console.log("storeId : "+data.storeId);
	 	    
	 	    let curNotiCnt = 0;
	 	    
	 	    for(let i = 0; i < document.getElementsByClassName("alert").length; i++){
	 	    	if(document.getElementsByClassName("alert")[i].style.display === 'show')
	 	    		curNotiCnt += 1;
	 	    }
	 	    
	 	    console.log("curNotiCnt : "+curNotiCnt);
	 	    
		if(data.cmd === 'rsvd'){
   	 		showRsvdList(storeId);
   	 		showRsvdMap(storeId);
   	 		$('.alert.manage_rsvd .alert_tit').html('예약 알림');
   	 		$('.alert.manage_rsvd .alert_senduser').html(data.sendUser);
   	 		$('.alert.manage_rsvd .alert_msg').html(data.msg);
   	 		document.getElementsByClassName("manage_rsvd")[0].style.bottom = 15 + curNotiCnt*100;
   	 		$('.alert.manage_rsvd').removeClass("hide");
   	 		$('.alert.manage_rsvd').addClass("show");
   	 		$('.alert.manage_rsvd').addClass("showAlert");
   	 		console.log(data.msg);
		} else if (data.cmd === 'wait'){
   	 		showWaitList(storeId);
   	 		$('.alert.manage_wait .alert_tit').html('웨이팅 알림');
   	 		$('.alert.manage_wait .alert_senduser').html(data.sendUser);
   			$('.alert.manage_wait .alert_msg').html(data.msg);
   			document.getElementsByClassName("manage_wait")[0].style.bottom = 15 + curNotiCnt*100;
   			$('.alert.manage_wait').removeClass("hide");
   	 		$('.alert.manage_wait').addClass("show");
   	 		$('.alert.manage_wait').addClass("showAlert");
		} else if (data.cmd === 'htdl') {
			
		}
	 	    
	 	    //let socketAlert = $('#socektAlert');
	 		//socketAlert.html(event.data);
	 	    //socketAlert.css('display','block');
	    
	    // 메시지가 3초 있다가 자동으로 사라지게
	    /*
	    setTimeout( function(){
	    	
	    	$socketAlert.css('display','none');
	    },3000);
	 	    */
	    
	    /*
	 	    let socketAlert = $('#socektAlert');
	 		socketAlert.innerHTML = event.data;
	 	    socketAlert.style.display = "block";
	 	   	showWaitList(storeId);
	 	    */
	 	   	
	 	    // 메시지가 3초 있다가 자동으로 사라지게
	 	    /*
	 	    setTimeout( function(){
	 	    	
	 	    	$socketAlert.css('display','none');
	 	    },3000);
	 	    */
	 	};


	 	// connection을 닫는다.
	 	ws.onclose = function (event) {
	 		console.log('Info: connection closed.');
	 		//setTimeout( function(){ connect(); }, 1000); // retry connection!!
	 	};
	 	ws.onerror = function (event) { console.log('Error'); };
	 	 
	 }
	 
		
		// input 내용을 socket에 send
		$('#btnSend').on('click', function(evt) {
			  evt.preventDefault();
			if (socket.readyState !== 1) return;
				  let msg = $('input#msg').val();
				  socket.send(msg);
			});
		
		//connectWS();
   </script>