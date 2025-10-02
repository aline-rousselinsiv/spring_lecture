package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.AreaMapper;
import com.example.test1.mapper.UserMapper;
import com.example.test1.model.Area;
import com.example.test1.model.User;

@Service
public class AreaService {
	
	@Autowired
	AreaMapper areaMapper;
	
	public HashMap<String, Object> areaInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List <Area> areaList = areaMapper.selectArea(map);
		int cnt = areaMapper.areaCnt(map);
		
		resultMap.put("list", areaList);
		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getSiList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List <Area> areaList = areaMapper.selectSiList(map);
		
		resultMap.put("list", areaList);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getGuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List <Area> guList = areaMapper.selectGuList(map);
		
		resultMap.put("guList", guList);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getDongList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List <Area> dongList = areaMapper.selectDongList(map);
		
		resultMap.put("dongList", dongList);
		resultMap.put("result", "success");
		return resultMap;
	}
}
