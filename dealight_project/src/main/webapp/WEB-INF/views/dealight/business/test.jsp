<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="/resources/js/Chart.js"></script>
</head>
<body>
	<div class="well">
		<h2>웨이팅 등록</h2>
		<input type="text" class="msg_wait" value='{"sendUser":"${userId}","waitId":"100","cmd":"wait","storeId":"1"}' class="form-control" />
		<button class="btn btn-primary btn_wait">Send Message</button>
	</div>
	
	<div class="well">
		<h2>예약 등록</h2>
		<input type="text" class="msg_rsvd" value='{"sendUser":"${userId}","rsvdId":"100","cmd":"rsvd","storeId":"1"}' class="form-control" />
		<button class="btn btn-primary btn_rsvd">Send Message</button>
	</div>
	
	<div class="wait_register_wrapper">
       <button class="btn_wait_register">온라인 웨이팅 등록</button>
    </div><!-- end wait board -->
    
    	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<ul class="rsvdDtls"></ul>
			<ul class="userRsvdList"></ul>
			<ul class="waiting_registerForm"></ul>
		</div>
	</div>
	
	<div id="socketAlert" class="alert alert-success" role="alert" style="display:none;"></div>
    <script>
    /* Web Socket */
    
 
 $(document).ready( function(){
		
		// input 내용을 socket에 send
		$('.btn_wait').on('click', function(evt) {
			  evt.preventDefault();
			if (socket.readyState !== 1) return;
				  let msg = $('input.msg_wait').val();
				  socket.send(msg);
			});
		
		$('.btn_rsvd').on('click', function(evt) {
			  evt.preventDefault();
			if (socket.readyState !== 1) return;
				  let msg = $('input.msg_rsvd').val();
				  socket.send(msg);
			});
		
		connectWS();
});

 const userId = ${userId};
    
	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
	});
 
    
 let socket = null;
 
 function connectWS() {
	// 전역변수 socket을 선언한다.
	// 다른 페이지 어디서든 소켓을 불러올 수 있어야 하기 때문이다.
	
 	// 소켓을 ws로 연다.
 	let ws = new WebSocket("ws://localhost:8080/manageSocket");
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
 	    
 	    
 	    let socketAlert = $('#socektAlert');
 	    socketAlert.html(event.data);
 	    socketAlert.css('display','block');
 	   	showWaitList(storeId);
 	    
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
 
 function regWait(wait, callback,error) {
	    
     $.ajax({
         type : 'post',
         url : '/dealight/business/manage/board/waiting/new',
         data : JSON.stringify(wait),
         contentType : "application/json; charset=utf-8",
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
     })
 }
 
 function showWaitRegisterForm(storeId, userId){
 	
 	let today = new Date();
 	let strWaitRegForm = "";
 	strWaitRegForm += "<h1>오프라인 웨이팅 등록</h1>";
 	strWaitRegForm += "<form id='waitRegForm' action='/dealight/business/manage/waiting/register' method='post'>";
 	strWaitRegForm += "고객 아이디<input name='userId' id='js_wait_custNm' value='"+userId+"' readonly></br>";
 	strWaitRegForm += "고객 이름<input name='custNm' id='js_wait_custNm'> <span id='name_msg'></span></br>";
 	strWaitRegForm += "고객 전화번호<input name='custTelno' id='js_wait_custTelno'> <span id='phoneNum_msg'></span></br>";
 	strWaitRegForm += "웨이팅 인원<input name='waitPnum' id='js_wait_pnum'> <span id='pnum_msg'></span></br>";
 	strWaitRegForm += "<input name='waitRegTm' value='"+today+"' hidden>";
 	strWaitRegForm += "<input name='storeId' value='"+storeId+"' hidden>";
 	strWaitRegForm += "<button id='submit_waitRegForm' type='submit'>제출하기</button>";
 	strWaitRegForm += "</form>";
 	strWaitRegForm += "<h2>현재 시간</h2>";
 	strWaitRegForm += "<h2>"+today+"</h2>";
 	
 	waitRegFormUL.html(strWaitRegForm);
 	
 	/* wait register valid check*/
 	const wait_custNm = document.querySelector("#js_wait_custNm"),
     	wait_phoneNum = document.querySelector("#js_wait_custTelno"),
     	wait_pnum = document.querySelector("#js_wait_pnum"),
     	btn_submit = document.querySelector("#submit_waitRegForm"),
     	name_msg = document.querySelector("#name_msg"),
     	phoneNum_msg = document.querySelector("#phoneNum_msg"),
     	pnum_msg = document.querySelector("#pnum_msg"),
     	waitRegForm = document.querySelector('#waitRegForm');
 	
 	const inputList = [wait_custNm,wait_phoneNum,wait_pnum];

 	// 웨이팅 등록의 valid check를 진행한다.
 	nameLenCheck = function () {
 		if(1 <= wait_custNm.value.length && wait_custNm.value.length <= 5)
 			return true;
 		return false;
 	}

 	phoneNumLenCheck = function () {
 		if(1 <= wait_phoneNum.value.length && wait_phoneNum.value.length <= 13)
 			return true;
 		return false;
 	}

 	pnumSizeCheck = function () {
 		if(isNaN(wait_pnum.value))
 			return false;
 		if(1 <= parseInt(wait_pnum.value) && parseInt(wait_pnum.value) <= 10)
 			return true;
 		return false;
 	}

 	wait_custNm.addEventListener("focusout", () => {
 		if(1 <= wait_custNm.value.length){
 		    if(nameLenCheck()){
 		        name_msg.innerText = "🙆‍♂️ 이름 형식이 적당하네요.";
 		    }
 		    else {
 		    	name_msg.innerText = "🙅‍♂️ 이름 길이를 다시 확인해 주세요. (5자 이내)";
 		    }
 		}
 	})

 	wait_phoneNum.addEventListener("focusout", () => {
 		if(1 <= wait_phoneNum.value.length){
 		    if(phoneNumLenCheck()){
 		        phoneNum_msg.innerText = "🙆‍♂️ 전화번호 형식이 적당하네요!";
 		    }
 		    else {
 		    	phoneNum_msg.innerText = "🙅‍♂️ 전화번호 길이를 다시 확인해 주세요. (13자 이내)";
 		    }
 		}
 	})

 	wait_pnum.addEventListener("focusout", () => {
 		if(1 <= wait_pnum.value.length){
 		    if(pnumSizeCheck()){
 		        pnum_msg.innerText = "🙆‍♂️ 인원이 적당합니다.";
 		    }
 		    else {
 		    	pnum_msg.innerText = "🙅‍♂️ 인원이 너무 많거나 형식이 적당하지 않아요! (10명 이내)";
 		    }
 		}
 	})

 	// null이면  true
 	nullCheck = function(inputList) {
 	    for(let i = 0; i < inputList.length; i++)
 	        if(inputList[i].value == "")
 	            return true;
 	    
 	    return false;
 	}
 	
 	let modalInputCustNm = modal.find("input[name='custNm']"),
			modalInputCutsTelNo = modal.find("input[name='custTelno']"),
			modalInputWaitPnum = modal.find("input[name='waitPnum']"),
			modalInputCurTime = modal.find("input[name='curTime']"),
			modalInputStoreId = modal.find("input[name='storeId']");
	
 	btn_submit.addEventListener("click", (e) => {
		
 		e.preventDefault();
 		
 		let wait = {
 				custNm : modalInputCustNm.val(),
 				custTelno : modalInputCutsTelNo.val(),
 				curTime : modalInputCurTime.val(),
 				waitPnum : modalInputWaitPnum.val(),
 				storeId : modalInputStoreId.val()
 		};
 		
 		
 	    if(nullCheck(inputList)){
 	        alert("필드가 비었어요")
 	        return;
 	    }
 	    
 	    if(!nameLenCheck()){
 	    	alert("🙅이름을 형식에 맞게 입력해주세요");
 	        return;
 	    }
 	    
 	    if(!phoneNumLenCheck()){
 	        alert("🙅전화번호를 형식에 맞게 입력해주세요");
 	        return;
 	    }
 	    
 	    if(!pnumSizeCheck()){
 	        alert("🙅예약인원을 형식에 맞게 입력해주세요");
 	        return;
 	    }
 	    

 		regWait(wait, result => {
 			
 			//alert(result);
     		showWaitList(storeId);
     		modal.find("ul").html("");
 			modal.find("input").val("");
 			modal.css("display","none");
 			
 		});
		
		});
 	
 	
 };
 
 /* 웨이팅 등록 */
 $(".btn_wait_register").on("click", e => {
 	
 	modal.css("display","block");
 	showWaitRegisterForm(storeId,userId);
 	
 	//$("#waitRegForm").submit();        		
 	
 });
    </script>
</body>
</html>