package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Product;

@Mapper
public interface ProductMapper {
	// 제품 목록
	List <Product> productList(HashMap<String, Object> map);
	
}
