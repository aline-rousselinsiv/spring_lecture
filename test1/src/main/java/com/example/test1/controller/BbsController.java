package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BbsService;
import com.google.gson.Gson;

@Controller
public class BbsController {
	
	@Autowired
	BbsService bbsService;
	
	@RequestMapping("/bbs/list.do") 
    public String list(Model model) throws Exception{

        return "/bbs/list";
    }
	
	@RequestMapping("/bbs/post.do") 
    public String post(Model model) throws Exception{

        return "/bbs/post";
    }
	
	@RequestMapping("/bbs/view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map);
		request.setAttribute("bbsNum", map.get("bbsNum"));
        return "/bbs/view";
    }
	
	@RequestMapping("/bbs/modify.do") 
    public String modify(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("bbsNum", map.get("bbsNum"));
        return "/bbs/modify";
    }
	
	@RequestMapping(value = "/bbs/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.getBbsList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/save.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String savePost(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.insertPost(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deletePost(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.deletePost(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/postDetails.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.getBbsInfo(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/modify.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String modifyPost(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.modifyPost(map);
		
		return new Gson().toJson(resultMap);
	}
	

}
