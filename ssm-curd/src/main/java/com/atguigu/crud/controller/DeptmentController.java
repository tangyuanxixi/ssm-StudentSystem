package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Deptment;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.DeptmentService;

@Controller
public class DeptmentController {
	
	@Autowired
	DeptmentService deptmentService;
	
	
	/**
	 * 返回所有的部门信息
	 * @return
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts()
	{
		
		List<Deptment> list = deptmentService.getDepts();
		return Msg.success().add("depts", list);
	}
}
