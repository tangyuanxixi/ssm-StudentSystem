package com.attom.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.attom.crud.bean.Deptment;
import com.attom.crud.dao.DeptmentMapper;

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
