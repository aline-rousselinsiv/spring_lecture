package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;

@Mapper
public interface StudentMapper {
	
	Student studentInfo (HashMap<String, Object> map);
	
	List <Student> stuList (HashMap<String, Object> map);
	
	//학생 삭제
	int stuDelete (HashMap<String, Object> map);
	
	// 상세 정보 조회
	Student studentView (HashMap<String, Object> map);
	
}
