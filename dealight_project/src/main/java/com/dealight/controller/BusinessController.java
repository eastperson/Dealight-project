package com.dealight.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.BUserVO;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlMenuDTO;
import com.dealight.domain.HtdlRequestDTO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdRequestDTO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;
import com.dealight.domain.UserWithRsvdDTO;
import com.dealight.domain.WaitVO;
import com.dealight.handler.ManageSocketHandler;
import com.dealight.service.BizAuthService;
import com.dealight.service.CallService;
import com.dealight.service.HtdlService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//현중 동인이형이랑 회의필요
@Controller
@Log4j
@RequestMapping("/dealight/business/*")
@AllArgsConstructor
public class BusinessController {

	private StoreService sService;
	
	private StoreService storeService;
	
	private RsvdService rsvdService;
	
	private WaitService waitService;
	
	private HtdlService htdlService;
	
	private CallService callService;
	
	private UserService userService;
	
	private BizAuthService bizAuthService;
	
	// 파일 저장 경로를 지정한다.
	final static private String ROOT_FOLDER = "C:\\dealgiht\\rds\\";
	
	
	//메뉴 사진첨부파일 매장평가 사업자테이블에 태그 메뉴 옵션이 들어가야한다.
	//DTO에 대한이해가 피요하고 많아지는 객체들을 쪼갤수있는 방법을 생각하자.
	@PostMapping("/register")
	public String register(StoreVO store, BStoreVO bStore, StoreLocVO loc, StoreEvalVO eval,Long brSeq,RedirectAttributes rttr) {
		
		
		log.info("store................"+store);
		log.info("bstore................." + bStore);
		log.info("loc................." + loc);
		log.info("store eval................." + eval);
		// log.info("imgs............." + imgs);
		
		bStore.setRepImg(bStore.getRepImg());
		store.setBstore(bStore);
		store.setLoc(loc);
		store.setEval(eval);
		
		log.info("register: " + store);
		
		sService.register(store);
		bizAuthService.updateStusCdToB(brSeq);
		
		
		//지금 나의 생각 입력한 값들이 잘 저장되나 보고싶다.
		//결국 저장된 정보를 볼수있는 페이지는 뭐가잇을까??
		//수정페이지에서 정보를 볼 수있고 정보도 고칠수 있지 
		//그러면 수정페이지를 가지고있어야겠네
		rttr.addFlashAttribute("result", store.getStoreId());
		return "redirect:/dealight/business/";
	}
	
	@GetMapping("/register")
	public void register(Model model, Long brSeq) {
		
		if(brSeq != null) {
			BUserVO buser = bizAuthService.read(brSeq);
			log.info("store register get .......................");
			log.info("buser : "+ buser);
			
			String storeName = buser.getStoreNm();
			String storeTelno = buser.getStoreTelno();
			
			model.addAttribute("storeName", storeName);
			model.addAttribute("storeTelno", storeTelno);
			model.addAttribute("brSeq", brSeq);
		}
	
	}
	
	/*
	 * 밑으로
	 *****[김동인] 
	 * 
	 * 
	 */
	
	// 해당 유저의 매장 리스트를 보여준다.
	@GetMapping("/")
	public String list(Model model,HttpSession session) {
		

		log.info("business store list..");
		
		// 임시로 'aaaa'이라는 아이디의 매장을 보여준다.
		//session.setAttribute("userId", "aaaa");
		String userId = (String) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		
		log.info(".........................................userId : "+userId);
		
		List<StoreVO> list = storeService.getStoreListByUserId(userId);
		
		
		// 현재 심사 대기중인 사업자등록번호
		List<BUserVO> buserList = storeService.comBrListByUserId(userId);
		
		log.info(".................................buser list : " + buserList);
		
		log.info("list............................."+list);
		// 현재 웨이팅, 현재 예약 상태를 가져온다.
		// ***쿼리가 너무 많이 생긴다.
		// 반정규화 고려
		list.stream().forEach((store)->{
			long id = store.getStoreId(); 	
			
			store.setBstore(storeService.getBStore(id));
			store.setCurWaitNum(waitService.curStoreWaitList(id, "W").size());
			store.setCurRsvdNum(rsvdService.readTodayCurRsvdList(id).size());
		});
		
		
		model.addAttribute("storeList", list);
		model.addAttribute("buserList", buserList);
		
		return "/dealight/business/list";
	}
	
	
	// 해당 매장의 관리 화면을 보여준다.
	// 대부분의 로직이 REST FUL 방식으로 변경(Board Controller로 대체되었다.)
	@GetMapping("/manage")
	public String manage(Model model, Long storeId,HttpServletRequest request, String code) {
		
		log.info("business manage..");
		
		HttpSession session = request.getSession();
		
		String userId = (String) session.getAttribute("userId");
		 

		// 오늘 예약한 사용자의 사용자 정보와 예약 정보를 가져온다.
		List<UserWithRsvdDTO> todayRsvdUserList = rsvdService.userListTodayRsvd(storeId);
		
		model.addAttribute("store",storeService.findByStoreIdWithBStore(storeId));
		model.addAttribute("userId",userId);
		model.addAttribute("storeId", storeId);
		model.addAttribute("todayRsvdUserList", todayRsvdUserList);
		
		return "/dealight/business/manage/manage";
	}
		
		@GetMapping("/test")
		public String test(HttpSession session,Model model) {
			
			String userId = (String) session.getAttribute("userId");
			
			model.addAttribute("userId", userId);
			
			ManageSocketHandler handler = ManageSocketHandler.getInstance();
	    	Map<String, WebSocketSession> map = handler.getUserSessions();
	    	
	    	model.addAttribute("map",map);
			
			
			return "/dealight/business/test";
		}
		
		@PostMapping("/test/rsvd")
		public String test(HttpSession session,RsvdRequestDTO dto) {
			
			// 임시로 'kjuioq'의 아이디를 로그인한다.
			String userId = (String) session.getAttribute("userId");
			
			log.info("register rsvd......................");
			
			UserVO user = userService.get(userId);
			
			log.info("register rsvd...................... user : " + user);
			
			List<RsvdDtlsVO> rsvdDtlsList = new ArrayList<>();
			
			RsvdVO rsvd = dto.toEntity();
			
			RsvdDtlsVO dtls = new RsvdDtlsVO();
			dtls.setMenuNm("돈까스");
			dtls.setMenuPrc(7000);
			dtls.setMenuTotQty(3);
			
			rsvdDtlsList.add(dtls);
			
			rsvd.setUserId(userId);
			rsvd.setRevwStus(0);
			rsvd.setStusCd("C");
			rsvd.setRsvdDtlsList(rsvdDtlsList);
			
			log.info("before rsvd.........................."+rsvd);
			
			// rsvd 예약 가능한지 체크
			
			rsvdService.register(rsvd, rsvd.getRsvdDtlsList());
			boolean resultComplete = rsvdService.complete(rsvd.getRsvdId());
			boolean resultAvail = rsvdService.completeUpdateAvail(rsvd.getStoreId(), dto.getTime(), rsvd.getPnum());
			
			log.info("resultComplete : " + resultComplete);
			log.info("resultAvail : " + resultAvail);
			
			log.info("after rsvd.........................."+rsvd);
			
			Long storeId = rsvd.getStoreId();
			Long rsvdId = rsvd.getRsvdId();
			
	    	ManageSocketHandler handler = ManageSocketHandler.getInstance();
	    	Map<String, WebSocketSession> map = handler.getUserSessions();
	    	WebSocketSession ws = map.get(storeService.getBStore(storeId).getBuserId());
	    	if(ws != null) {
	    		TextMessage message = new TextMessage("{\"sendUser\":\""+userId+"\",\"rsvdId\":\""+rsvdId+"\",\"cmd\":\"rsvd\",\"storeId\":\""+storeId+"\"}");
	    		try {
					handler.handleMessage(ws, message);
				} catch (Exception e) {
					
					log.warn("web socket error...............");
					e.printStackTrace();
				}
	    	}
			
			
			return "redirect:/dealight/business/test";
		}
		
		@PostMapping("/test/htdl")
		public String regHtdl(HttpSession session,Long storeId, String startTm, String endTm, String htdlName) {
			
			log.info("htdl socket.......................................");
			
			String userId = (String) session.getAttribute("userId");
			
			ManageSocketHandler handler = ManageSocketHandler.getInstance();
	    	Map<String, WebSocketSession> map = handler.getUserSessions();
	    	WebSocketSession ws = map.get(userId);
	    	if(ws != null) {
	    		TextMessage message = new TextMessage("{\"sendUser\":\""+"dealight"+"\",\"htdlId\":\""+"0"+"\",\"cmd\":\"htdl\",\"storeId\":\""+storeId+"\"}");
	    		try {
					handler.handleMessage(ws, message);
				} catch (Exception e) {
					
					log.warn("web socket error...............");
					e.printStackTrace();
				}
	    	}
			
			
			return "redirect:/dealight/business/test";
		}
}
