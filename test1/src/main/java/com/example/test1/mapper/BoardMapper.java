package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Student;

@Mapper
public interface BoardMapper {
	// 게시글 목록  : board list
	List <Board> boardList (HashMap<String, Object> map);
	
	// 게시글 삭제
	int deleteBoard(HashMap<String, Object> map);
	
	// 게시글 추가
	List <Board> boardAdd (HashMap<String, Object> map);
}
