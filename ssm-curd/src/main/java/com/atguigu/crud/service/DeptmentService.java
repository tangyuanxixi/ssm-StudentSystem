package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Deptment;
import com.atguigu.crud.dao.DeptmentMapper;

@Service
public class DeptmentService {
	
	@Autowired
	DeptmentMapper deptmentMapper; 
	
	public List<Deptment> getDepts()
	{
		List<Deptment> list = deptmentMapper.selectByExample(null);
		return list;
		
	}
}
