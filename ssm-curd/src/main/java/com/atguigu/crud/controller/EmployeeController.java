package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.context.config.ContextNamespaceHandler;
/*
 * 处理Employee的CRUD请求
 * */
/**
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn ,Model model)
	{
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn,5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		Msg msg = Msg.success();
		msg.add("pageInfo", page);
		return msg;
	}
	/**
	 * 保存员工信息，保存时
	 *支持JSR303校验
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result)
	{
		
		if(result.hasErrors())
		{
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名:"+fieldError.getField());
				System.out.println("错误信息:"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorsFields",map);
		}
	 else
		{
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	/**
	 * 检查用户名是否合法
	 * @param empName
	 * @return
	 */
	@RequestMapping("checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName)
	{
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		//检查用户名是否合法
		if(!empName.matches(regex)){
			return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
		}
		boolean b = employeeService.checkUser(empName);
		if(b)
		{
			return Msg.success();
		}else
		{
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	/**
	 * PathVariable声明id是来自路径的id值
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	/**
	 * 更新员工信息
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.POST)
	public Msg updateEmp(Employee employee){
		employeeService.updateEmp(employee);
		return Msg.success();
		
	}
	@ResponseBody
	@RequestMapping(value="/delete/{empId}",method=RequestMethod.POST)
	public Msg deleteEmp(@PathVariable("empId")String empId){
		if(empId.contains("-")){
			List<Integer> list = new ArrayList<Integer>();
			String[] str_ids = empId.split("-");
			for (String str_id : str_ids) {
				list.add(Integer.parseInt(str_id));
			}
			employeeService.deleteBatch(list);
		}else{
			Integer Id = Integer.parseInt(empId);
			employeeService.deleteEmp(Id);
		}
		
		
		return Msg.success();
		
	}
	/*
	 * 分页查询所有员工信息
	 * 
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn ,Model model)
	{
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn,5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
	*/
}
