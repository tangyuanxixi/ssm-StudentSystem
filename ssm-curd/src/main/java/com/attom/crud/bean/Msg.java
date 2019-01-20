package com.attom.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {

	//状态码：100-成功，200-失败
	private Integer code;
	//提示信息
	private String msg;
	// 用户要返回给浏览器的信息封装在一个Map中
	private Map<String,Object> extend = new HashMap<String,Object>();
	//处理成功请求
	public static Msg success()
	{
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("处理成功");
		return result;
	}
	//处理失败请求
	public static Msg fail()
	{
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("失败");
		return result;
	}
	//添加数据
	public Msg add(String key,Object value)
	{
		this.getExtend().put(key, value);
		return this;
		
	}
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
	
}
