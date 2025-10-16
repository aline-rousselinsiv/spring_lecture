package com.example.test1.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.PaymentMapper;

@Service
public class PaymentService {
	@Autowired
	PaymentMapper paymentMapper;
	
	public HashMap<String, Object> insertPaymentInfo(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int paymentInfo = paymentMapper.paymentInfo(map);
			
			resultMap.put("info", paymentInfo);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
}
