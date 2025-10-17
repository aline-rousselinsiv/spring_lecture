package com.example.test1.model;

import lombok.Data;

@Data
public class Bbs {
	private String bbsNum;
	private String title;
	private String contents;
	private String hit;
	private String userid;
	private String cDateTime;
	private int cnt;
	
	private String fileNo;
	private String filePath;
	private String fileName;
}
