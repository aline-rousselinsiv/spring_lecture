package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Mapper
public interface ProductMapper {
	// 제품 목록
	List <Product> productList(HashMap<String, Object> map);
	
	// 메뉴 목록
	List <Menu> selectMenuList(HashMap<String, Object> map);
	
	// 음식 등록
	int insertFood (HashMap<String, Object> map);
	
	// 첨부파일 (이미지) 업로드	
	int insertFoodImg(HashMap<String, Object> map);
	
	// 음식 상세 정보
	Product selectProduct(HashMap<String, Object> map);
	
	
}
