package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
	
	// 결제 정보 저장
	int paymentInfo(HashMap<String, Object> map);
	
}
