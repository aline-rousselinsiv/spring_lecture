package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

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
		resultMap.put("info", student);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getStuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List <Student> list = studentMapper.stuList(map);
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> deleteStuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = studentMapper.stuDelete(map);

		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getStudentView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service => " + map);
		Student info = studentMapper.studentView(map);
		
		resultMap.put("info", info);
		resultMap.put("result", "success");
		return resultMap;
	}
}
