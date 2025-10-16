package com.example.test1.model;

import lombok.Data;

@Data
public class Board {
	private int boardno;
	private String title;
	private String userid;
	private int cnt;
	private String cdate;
	private String contents;
	private String contents2;
	private String commentCnt;
	
	private String fileNo;
	private String filePath;
	private String fileName;
}
