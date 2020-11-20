package com.dealight.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dealight.domain.SearchDTO;
import com.dealight.service.SearchService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//현중
@Controller
@Log4j
@RequestMapping("/search/*")
@AllArgsConstructor
public class SearchController {

	private SearchService sService;
	
	
	@GetMapping("/")
	public String list(SearchDTO search, Model model) {
		
		log.info("SearchDTO:" + search +";");
		
		model.addAttribute("search", search);
		
		return "/search/list";
	}
}
