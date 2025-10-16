package com.example.test1.model;

import lombok.Data;

@Data
public class Payment {
	private int orderId;
	private int userId;
	private int amount;
	private int productNo;
	private String paymentDate;
	
}
