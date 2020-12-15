package com.dealight.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.AdminPageDTO;
import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;
import com.dealight.service.AdminService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/admin/*")
@AllArgsConstructor
public class AdminController {

	private AdminService service;

	@GetMapping("/main")
	public void adminMain() {
	}

	//---------사업자등록--------------
	@GetMapping("/brnomanage")
	public String bizAuthList(Criteria cri, Model model) {

		log.info("bizAuthList");

		int total = service.getTotal(cri);
		log.info(cri);
		log.info("total : " + total);
		
		if(cri == null || cri.getPageNum() < 1)
			cri = new Criteria(1, 10);
		
		model.addAttribute("list", service.getBUserListWithCri(cri));
		model.addAttribute("pageMaker", new AdminPageDTO(cri, total));

		return "/dealight/admin/brnomanage/list";
	}
	
	@GetMapping("/brnomanage/register")
	public void registerBrno() {
		
	}
	
	@PostMapping("/brnomanage/register")
	public String registerBrno(BUserVO buser, RedirectAttributes rttr) {
		log.info("register :" + buser);
		
		service.registerBUser(buser);
		
		rttr.addFlashAttribute("result", buser.getBrSeq());
		
		return "redirect:/dealight/admin/brnomanamge";
	}
	

	@GetMapping({ "/brnomanage/get", "/brnomanage/modify" })
	public void getBrno(@RequestParam("brSeq") long brSeq, @ModelAttribute("cri")Criteria cri, Model model) {

		log.info("get by brSeq : " + brSeq);

		model.addAttribute("buser", service.readBUser(brSeq));
	}

	@PostMapping("/brnomanage/modify")
	public String modifyBrno(BUserVO buser, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify : " + buser);
		
		if(service.modifyBUser(buser)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		
		return "redirect:/dealight/admin/brnomanage" + cri.getBrnoListLink();
	}
	
	@PostMapping("/brnomanage/remove")
	public String deleteBrno(@RequestParam("brSeq") long brSeq, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove by brSeq : " +brSeq);
		
		if(service.deleteBUser(brSeq)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/dealight/admin/brnomanage" + cri.getBrnoListLink();
	}
	
	//--------------------회원관리
	@GetMapping("/usermanage/user")
	public String userList(Model model) {
		
		log.info("list");
		
		model.addAttribute("list", service.getUserList());
		
		return "/dealight/admin/usermanage/user/list";
	}
	
	@GetMapping({"/usermanage/user/get", "/usermanage/user/modify"})
	public void getUser(@RequestParam("userId") String userId, Model model) {
		log.info("get user by id : " + userId);
		
		model.addAttribute("user", service.readUser(userId));
	}
	
	@PostMapping("/usermanage/user/modify")
	public String modifyUser(UserVO user, RedirectAttributes rttr) {
		log.info("modify user : " + user);
		
		if(service.modifyUser(user)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/dealight/admin/usermanage/user";
	}
	
	@PostMapping("/usermanage/user/delete")
	public String deleteUser(String userId, RedirectAttributes rttr) {
		log.info("remove by userId : " + userId);
		
		if(service.delete(userId))
			rttr.addFlashAttribute("result", "success");
		
		
		return "redirect:/dealight/usermanage/user";
	}

	//-----------------------------매장관리
	@GetMapping("/storemanage")
	public String storeList(Model model) {
		log.info("get store List....................");
		
		model.addAttribute("list", service.getStroeList());
		
		return "/dealight/admin/storemanage/list";
	}
	
	@PostMapping("/storemanage/registerbstore")
	public String registerStore(StoreVO store, RedirectAttributes rttr) {
		log.info("register : " + store);
		
		service.registerStore(store);
		
		return "redirect:/dealight/admin/storemanage";
	}
	
	@GetMapping("/storemanage/registerbstore")
	public void registerStore() {
		
	}
	
	@GetMapping("/storemanage/get")
	public String getStore(@RequestParam("storeId") long storeId, @RequestParam("clsCd") String clsCd, Model model) {
		log.info("get by storeId : " + storeId);
		
		if(clsCd.equals("B")) {
			model.addAttribute("store", service.readStore(storeId));
			return "dealight/admin/storemanage/getbstore";
		}
		
		return "dealight/admin/storemanage/getnstore";
			
	}
	
	@GetMapping("/storemanage/modify")
	public String modifyStore(@RequestParam("storeId") long storeId, @RequestParam("clsCd") String clsCd, Model model) {
		log.info("get by storeId : " + storeId);
		
		if(clsCd.equals("B")) {
			model.addAttribute("store", service.readStore(storeId));
			return "dealight/admin/storemanage/modifybstore";
		}
		
		return "dealight/admin/storemanage/modifynstore";
			
	}
	
	
	@PostMapping("/storemanage/modify")
	public String modfiyStore(StoreVO store, RedirectAttributes rttr) {
		log.info("modify store : " + store);
		
		if(service.modifyStore(store))
			rttr.addFlashAttribute("result", "success");
		
		return "redirect:/dealight/admin/storemanage";
	}
	
	@PostMapping("/storemanage/delete")
	public String deleteStore(@RequestParam("storeId") long storeId, RedirectAttributes rttr) {
		log.info("delete store : " + storeId);
		
		if(service.deleteStore(storeId))
			rttr.addFlashAttribute("result", "success");
		
		return "redirect:/dealight/admin/storemanage";
	}
	
	
	//--------------------------핫딜관리
	@GetMapping("/htdlmanage/{stusCd}")
	public String htdlList(@PathVariable String stusCd, Model model) {
		
		log.info("get htdl list..... ");
//		String htdlStusCd = service.getHtdlList(stusCd).get(0).getStusCd();
		
		model.addAttribute("stusCd", stusCd);
		model.addAttribute("lists", service.getHtdlList(stusCd));
		return "/dealight/admin/htdlmanage/list";
	}
	

	@GetMapping({"/htdlmanage/get", "/htdlmanage/modify"})
	public void getHtdl(String stusCd, Long htdlId, Model model) {
		log.info("========stusCd: " + stusCd);
		
			HtdlVO htdlVO = service.readHtdl(stusCd, htdlId);
			log.info("=====htdlVO : " + htdlVO);
			log.info("=======time: " + htdlVO.getStartTm()+"," + htdlVO.getEndTm());
			log.info("=======price: " + htdlVO.getHtdlDtls().get(0).getMenuPrice());
			
			model.addAttribute("htdl", htdlVO);
			
		
	}
	
	
}
