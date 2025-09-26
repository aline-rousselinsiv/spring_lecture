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

import com.example.test1.dao.BoardService;
import com.google.gson.Gson;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;
	
	@RequestMapping("/board-list.do") 
    public String login(Model model) throws Exception{

        return "/board-list";
    }
	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = boardService.getBoardList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = boardService.removeBoard(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/board-add.do") 
    public String add(Model model) throws Exception{

        return "/board-add";
    }
	@RequestMapping(value = "/board-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = boardService.addBoardList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/board-view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map);
		request.setAttribute("boardno", map.get("boardno"));
        return "/board-view";
    }
	
	@RequestMapping(value = "/board-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = boardService.getBoard(map);
		
		return new Gson().toJson(resultMap);
	}
}
