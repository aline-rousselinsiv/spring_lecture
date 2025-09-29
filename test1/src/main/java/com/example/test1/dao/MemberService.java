package com.example.test1.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;
	
	public HashMap<String, Object> login(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.memberLogin(map);
		String message = member != null ? "로그인 성공!" : "로그인 실패!";
		String result = member != null ? "success" : "fail";
		
		if(member != null) {
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
		}
		
		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
	}
	
	public HashMap<String, Object> idCheck(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member idCheck = memberMapper.idCheck(map);
		String result = idCheck != null ? "true" : "false";
		
		resultMap.put("result", result);
		
		return resultMap;
	}

}
