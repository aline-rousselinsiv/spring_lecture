package com.example.test1.model;

import lombok.Data;

@Data
public class Comment {
	private String boardno;
	private String commentNo;
	private String contents;
	private String userId;
	private String nickName;
	private String cdateTime;
	private String favorite;
	private String pCommentNo;
	private String uDateTime;
	private String cHour;
}
