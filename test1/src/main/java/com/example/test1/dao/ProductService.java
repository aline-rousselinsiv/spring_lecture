package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Service
public class ProductService {
	@Autowired
	ProductMapper productMapper;
	
	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List <Product> list = productMapper.productList(map);
		List <Menu> menuList = productMapper.selectMenuList(map);
		
		resultMap.put("list", list);
		resultMap.put("menuList", menuList);
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> getMenuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List <Menu> menuList = productMapper.selectMenuList(map);

		resultMap.put("menuList", menuList);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> addFood(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = productMapper.insertFood(map);
		
		resultMap.put("foodNo", map.get("foodNo"));
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public void addFoodImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = productMapper.insertFoodImg(map);
	}

	public HashMap<String, Object> getProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Product info = productMapper.selectProduct(map);
		
		resultMap.put("info", info);
		return resultMap;
	}
	
}
