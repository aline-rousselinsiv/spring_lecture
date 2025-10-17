package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;

@Mapper
public interface BbsMapper {
	
	// 게시글 목록
	List <Bbs> selectBbsList(HashMap<String, Object> map);
	
	// 게시글 전체 개수
	int bbsCnt(HashMap<String, Object> map);
	
	// 게시글 등록
	int insertPost(HashMap<String, Object> map);
	
	// 게시글 삭제
	int deletePost(HashMap<String, Object> map);
	
	// 게시글 상세 정보
	Bbs selectBbsInfo(HashMap<String, Object> map);
	
	// 게시글 수정
	int updatePost(HashMap<String, Object> map);
	
	// 게시글 목록 삭제
	int deleteBbsList(HashMap<String, Object> map);
	
	// 첨부파일 (이미지) 업로드	
	int insertBbsImg(HashMap<String, Object> map);
}
