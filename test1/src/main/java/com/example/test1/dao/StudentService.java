package com.example.test1.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.StudentMapper;
import com.example.test1.model.Student;

@Service
public class StudentService {
	
	@Autowired
	StudentMapper studentMapper;
	
	public HashMap<String, Object> studentInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service => " + map);
		Student student = studentMapper.studentInfo(map);
		if(student != null) {
			System.out.println(student.getStuName());
			System.out.println(student.getStuDept());
			System.out.println(student.getStuNo());
			
		}
		return resultMap;
	}
}
