package com.dealight.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.dealight.domain.Criteria;
import com.dealight.domain.RsvdMenuDTOList;
import com.dealight.domain.UserVO;
import com.dealight.domain.WaitVO;
import com.dealight.handler.ManageSocketHandler;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//다울
@Controller
@Log4j
@RequestMapping("/dealight/*")
@AllArgsConstructor
public class StoreController {

	private StoreService service;
	
	private UserService userService;
	
	private WaitService waitService;

	@GetMapping("/store")
	public String store(Long storeId,Criteria cri,Model model,String clsCd) {
		// store타입을 체크 한다 n일경우 n 스토어를 보여줌 b일 경우 b를 보여줌
		
		//다울 nstore check
		if (clsCd.equalsIgnoreCase("B")) {
			log.info("bstore: " + storeId);
			model.addAttribute("store", service.bstore(storeId));
			//model.addAttribute("revws", service.revws(storeId,cri));
			return "/dealight/store/bstore";
		} else {
			log.info("nstore: " + storeId);
			model.addAttribute("store", service.nstore(storeId));
			return "/dealight/store/nstore";
		}

	}

	@PostMapping("/reservation")
	public void reservation(Model model,HttpSession session, RsvdMenuDTOList rsvdMenuList, String pnum, String time, Long storeId) {
		//로그인 성공 후 세션에 저장된 user 정보를 꺼내와서 user정보를 불러옴
	    UserVO user = (UserVO)session.getAttribute("user");
	    if(user == null) {
	    	model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
	    	model.addAttribute("storeId",storeId);
	    	
	    }else {
		model.addAttribute("store", service.bstore(storeId));
		model.addAttribute("rsvdMenuList", rsvdMenuList); 
		model.addAttribute("pnum", pnum); 
		model.addAttribute("time", time);
		log.info(rsvdMenuList);
		}
	
	}
	
	@PostMapping("/waiting")
	public String waiting(Model model, HttpSession session,int pnum, Long storeId) {
		
		// 임시로 'kjuioq'의 아이디를 로그인한다.
		session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");
		
		UserVO user = userService.get(userId);
		
		SimpleDateFormat fomater = new SimpleDateFormat("yyyy/MM/dd HH24:mm:ss");
		WaitVO wait = new WaitVO().builder()
				.userId(userId)
				.storeId(storeId)
				.waitPnum(pnum)
				.custNm(user.getName())
				.custTelno(user.getTelno())
				.waitStusCd("W")
				.waitRegTm(fomater.format(new Date()))
				.build();
		
		waitService.registerOnWaiting(wait);
		

    	ManageSocketHandler handler = ManageSocketHandler.getInstance();
    	Map<String, WebSocketSession> map = handler.getUserSessions();
    	WebSocketSession ws = map.get("kjuioq");
    	if(ws != null) {
    		TextMessage message = new TextMessage("{\"sendUser\":\""+userId+"\",\"waitId\":\""+wait.getWaitId()+"\",\"cmd\":\"wait\",\"storeId\":\""+storeId+"\"}");
    		try {
				handler.handleMessage(ws, message);
			} catch (Exception e) {
				
				log.warn("web socket error...............");
				e.printStackTrace();
			}
    	}
    	
    	
    	return "redirect:/dealight/store?storeId=" + storeId;
	}

}
