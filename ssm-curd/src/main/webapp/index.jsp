<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <title>员工列表</title>
    <%
    	pageContext.setAttribute("APP_PATH",request.getContextPath());
     %>
    <!--web路径：
		不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
		以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；
		需要加上项目名http://localhost:3306/crud  -->
      <!--引入Jquery  -->
  <script type="text/javascript" src="${APP_PATH }/static/js/jquery-2.1.4.min.js"></script>
  <!--引入样式  -->
  <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    


  </head>
  
  <body>
  <!--主页面显示框架  -->
    <div class="container">
    <!--表名  -->
    	<div class="row">
	    	<div class="col-md-4 bg-info">
					<h1>SSM-CRUD</h1>
				</div>
    	</div>
    	<!--按钮  -->
    	<div class="row">
	    	<div class="col-md-4 col-md-offset-8">
		    	<button  id="emp_add_modal_btn"  class="btn btn-primary ">添加</button>
		    	<button  id="emp_delete_modal_btn"  class="btn btn-warning ">删除</button>
		    </div>
    	</div>
    	<!--表格数据  -->
    	<div class="row">	
    	<table class="table table-hover" id="emps_table">
    	<thead class="btn-info">
 				<tr>
 						<th><input type="checkbox" id="check_all"/></th>
						<th>id</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
		</thead>
		<tbody>
		</tbody>
		</table>
    	</div>	
    	<!--分页信息  -->
    	 <div class="row">	
    	 <!--显示文字信息  -->
    	 <div class="col-md-6" id="page_info_area">
    	 </div>
    	 <!-- 显示分页条信息 -->
    	 <div class="col-md-6 col-md-offset-7" id="page_nav_area">
			</div>
    	</div>	
    </div>
     <!--添加员工模态对话框样式  -->
	  <div class="modal fade"  id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="MyModalLabel">
	 	 <div class="modal-dialog" role="document">
	   		 <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="exampleModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      <label class="radio-inline">
				  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		      <select class="form-control" name="dId">
		      </select>
		    </div>
		  </div>
		</form>
      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!--编辑员工模态对话框样式  -->
	  <div class="modal fade"  id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="MyModalLabel">
	 	 <div class="modal-dialog" role="document">
	   		 <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="exampleModalLabel">员工编辑</h4>
	      </div>
	      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <p class="form-control-static" id="empName_update_static"></p>
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      <label class="radio-inline">
				  <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		      <select class="form-control" name="dId">
		      </select>
		    </div>
		  </div>
		</form>
      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!--删除员工模态对话框样式  -->
	
		  <div class="modal fade"  id="empDeleteModal" tabindex="-1" role="dialog" aria-labelledby="MyModalLabel">
	 	 <div class="modal-dialog" role="document">
	   		 <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="exampleModalLabel">删除员工</h4>
	      </div>
	      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <p class="form-control-static" id="empName_Delete_static"></p>
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		       <p class="form-control-static" id="email_Delete_static"></p>
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
			 <p class="form-control-static" id="gender_Delete_static"></p>
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		    <p class="form-control-static" id="deptName_Delete_static"></p>
		      <span class="help-block"></span>
		    </div>
		  </div>
		</form>
      </div>
      	<div class="col-sm-4" ><p>您确定要删除这名员工吗</p></div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary" id="emp_Delete_btn">删除</button>
	      </div>
	    </div>
	  </div>
	</div>
<script type="text/javascript">
		//当前的记录数全局变量
		var totalRecord,currentPage;
		
    	$(function(){
    		to_page(1);
    	});
    	/* *************************显示主页面信息***************************** */
    	function to_page(pn)
    	{
    	/*
    		其中的data就是http://tangyuan.com/xiba.jsp?d=1&b=2
    		中的d=1&b=2
    		success返回的结果result参数带的就是整个Json数据串
    	  */
    		$.ajax({
    			url:"${APP_PATH}/emps",
    			data:"pn="+pn,
    			type:"GET",
    			success:function(result)
    			{
    					//1、解析并显示员工信息
    					 build_emps_table(result);
    				   //2、解析并显示分页信息
    				   	 build_page_info(result);
    				   //3、解析并显示分页条信息
    				  	 page_nav(result);
    			}
    		});
    		}
    		//1、解析并显示员工信息
    	function build_emps_table(result)
    		{
    			$("#emps_table tbody").empty();
    			//获取到员工数据列表
    			var emps = result.extend.pageInfo.list;
    			$.each(emps,function(index,item)
    			{
    				var checkBoxTd = $("<td></td>").append("<th><input type='checkbox' class='check_item'/></th>");
    				var	empIdTd = $("<td></td>").append(item.empId);
    				var empNameTd = $("<td></td>").append(item.empName);
					var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
					var emailTd = $("<td></td>").append(item.email);
					var deptNameTd = $("<td></td>").append(item.dept.deptName);
					var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
					//为编辑按钮添加一个自定义的属性，来表示当前员工id，为了后面按员工Id编辑用
					editBtn.attr("edit-id",item.empId);
					var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
									.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
					//为删除按钮添加一个自定义的属性来表示当前删除的员工id
					delBtn.attr("del-id",item.empId);
					//将编辑和删除放在同一个td标签中
					var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
					$("<tr></tr>").append(checkBoxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btnTd)
					.appendTo("#emps_table tbody");
    			});
    		}
    	 //2、解析并显示分页信息
      	function build_page_info(result)
    		 {
    			$("#page_info_area").empty();
    		 	$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum +"页,总"+
					result.extend.pageInfo.pages+"页,总"+
					result.extend.pageInfo.total+"条记录");
					totalRecord = result.extend.pageInfo.total;
					currentPage = result.extend.pageInfo.pageNum;
    		 }
    	//3、解析并显示分页条信息
    	 function page_nav(result)
    		 {
    		 	$("#page_nav_area").empty();
    		 	var ul = $("<ul></ul>").addClass("pagination");
    		 	//构建元素
				var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
				var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
				if(result.extend.pageInfo.hasPreviousPage == false){
						firstPageLi.addClass("disabled");
						prePageLi.addClass("disabled");
					}
				else{
						//为元素添加点击翻页的事件
						firstPageLi.click(function(){
										to_page(1);
									});
						prePageLi.click(function(){
										to_page(result.extend.pageInfo.pageNum -1);
									});
							}
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum +1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi);
			//1,2，3遍历给ul中添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);
			
			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
			
    	}
    	/* **************************添加员工信息******************** */
    	//添加员工模态对话框
    	$("#emp_add_modal_btn").click(function(){
    		//清空表单的内容
    		reset_form("#empAddModal form");
    		//将部门信息显示在下拉框
    		getDepts("#empAddModal select");
    		//显示模态对话框
    		$("#empAddModal").modal({
    		backdrop:"static"
    		});
    	});
    	
    	//将部门信息显示在下拉框
    	function getDepts(ele)
    	{
    		$(ele).empty();
    		$.ajax({
    			url:"${APP_PATH}/depts",
    			type:"GET",
    			success:function(result){
				 $.each(result.extend.depts,function(){
    				var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
    				optionEle.appendTo(ele);
    			}); 
    			}
    			});
    		}
    		//清空表单的内容
    		function reset_form(ele)
    		{
    			//因为Jquery没有reset方法，而Dom有
    			$(ele)[0].reset();
    			$(ele).find(".help-block").text("");
    		}
    		//验证表单信息是否合法
    		function validate_add_form()
    		{
    			//验证用户名
    			var empName = $("#empName_add_input").val();
    			var regName = /(^[a-z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+$)/;
    			if(!regName.test(empName))
    			{
    				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
    				return false;
    			}
    			else{
    				show_validate_msg("empName_add_input","success","");
    			}
    			//验证邮箱
    			var email = $("#email_add_input").val();
    			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    			if(!regEmail.test(email))
    			{
    				show_validate_msg("#email_add_input","error","邮箱格式不正确");
    				return false;
    			} 
    			else{
    				show_validate_msg("#email_add_input","success","");
    			}
    			return true;
    			
    			
    		}
    		//点击保存，保存员工
    		$("#emp_save_btn").click(function()
    		{
      			if(!validate_add_form())
    			{
    				return false;
    			}  
    			
    			$.ajax({
    				url:"${APP_PATH}/emp",
    				type:"POST",
    				data:$("#empAddModal form").serialize(),
    				success:function(result){
    					if(result.code==100)
    					{
    						//数据校验成功则直接关闭对话框和保存数据
	    					$("#empAddModal").modal("hide");
	    					/* totalRecord是记录数，当跳转到一个大于当前页数的时候
	    					pageInfo会自动帮我们跳转到最后一页 */
	    					to_page(totalRecord);
    					}
    					//校验失败，显示校验信息
    					else if(result.code==200)
    					{
    							
    						if(undefined!=result.extend.errorsFields.email)
    						{    	
    							show_validate_msg("#email_add_input","error",result.extend.errorsFields.email);
    						}
    						else if(undefined!=result.extend.errorsFields.empName)
    						{
    							show_validate_msg("#empName_add_input","error",result.extend.errorsFields.empName);
    						}
    						
    					}

    				}
    			
    			});
    		
    		});
    		//显示校验结果的提示信息
    		function show_validate_msg(ele,status,msg){
    			$(ele).parent().removeClass("has-success has-error");
    			$(ele).next("span").text("");
    			if("success"==status)
    			{
    				$(ele).parent().addClass("has-success");
    				$(ele).next("span").text(msg);
    			}
    			else if("error"==status)
    			{
    				$(ele).parent().addClass("has-error");
    				$(ele).next("span").text(msg);
    			}
    		}
    		//检查用户名是否可用,change函数当指定的标签的内容改变时触发函数
    		$("#empName_add_input").change(function()
    		{
    		
    			var empName = this.value;
    			$.ajax({
    				url:"${APP_PATH}/checkuser",
    				data:"empName="+empName,
    				type:"POST",
    				success:function(result){
    					if(result.code==100)
    					{
    						show_validate_msg("#empName_add_input","success","用户名可用");
    						$("#emp_save_btn").attr("ajax-va","success");
    					}
    					else
    					{
    						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
							$("#emp_save_btn").attr("ajax-va","error");
    					}
    				}
    				
    			});
    		});
    		
    	/* **************************编辑员工信息******************** */
    	
    	
    	//1、我们是按钮创建之前就绑定了click，所以绑定不上。
		//1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
		//jquery新版没有live，使用on进行替代
    	$(document).on("click",".edit_btn",function(){
    		//查出部门信息并显示在模态对话框中
    		getDepts("#empUpdateModal select");
    		//查找员工信息并显示在模态对话框中
    		//$(this).attr("edit-id")查找到当前按钮的属性为edit-id 的值
    		getEmp($(this).attr("edit-id"));
    		$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
    		$("#empUpdateModal").modal({
    		backdrop:"static"
    		});
    	 
    	});
    	//更新按钮事件
    	$("#emp_update_btn").click(function(){
    		//验证邮箱信息
    		var email = $("#email_update_input").val();
    		var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    		if(!regEmail.test(email))
    		{
    			show_validate_msg("email_update_input", "error", "邮箱格式不正确");
    		}
    		else{
    			show_validate_msg("email_update_input", "success","");
    		}
    		$.ajax({
    			url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
    			type:"POST",
    			//+"_method=PUT"
    			data:$("#empUpdateModal form").serialize(),
    			success:function(result){
    				$("#empUpdateModal").modal("hide");
    				to_page(currentPage);
    			}
    			
    		});
    	
    	});
    	//查找员工信息并显示在模态对话框
    	function getEmp(id)
    	{
    		$.ajax({
    			url:"${APP_PATH}/emp/"+id,
    			type:"GET",
    			success:function(result){
    				var empData = result.extend.emp;
    				$("#empName_update_static").text(empData.empName);
    				$("#email_update_input").val(empData.email);
    				$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
    			}
    		});
    	}
    	/* **************************删除员工信息******************** */
    	
    	/* +++++++++++++++++删除单个员工 +++++++++++++++*/
    	$(document).on("click",".delete_btn",function(){
    		//查找部门信息并显示在模态对话框
    		getDepts("#empDeleteModal select");
    		//查找员工信息并显示在模态对话框
    		getEmps($(this).attr("del-id"));
    		$("#emp_Delete_btn").attr("del-id",$(this).attr("del-id"));
    		$("#empDeleteModal").modal({
    		backdrop:"static"
    		});
    	});
    	//显示要删除的员工信息
    	function getEmps(id)
    	{
    		$.ajax({
    			url:"${APP_PATH}/emp/"+id,
    			type:"GET",
    			success:function(result){
    				console.log(result);
    				var empData = result.extend.emp;
    				var gender = null;
    				var deptName = null;
    				$("#empName_Delete_static").text(empData.empName);
    				$("#email_Delete_static").text(empData.email);
    				if(empData.gender=="F")
    				{
    					gender = "女";
    				}
    				else if(empData.gender=="M")
    				{
    					gender = "男";
    				}
    				$("#gender_Delete_static").text(gender);
    				if(empData.dId==1)
    				{
    					deptName = "测试部";
    				}
    				else if(empData.dId==2)
    				{
    					deptName = "开发部";
    				}
					$("#deptName_Delete_static").text(deptName);
    			}
    		});
    	}
    	//删除按钮触发删除
    	$("#emp_Delete_btn").click(function(){
    		
    		$.ajax({
    			url:"${APP_PATH}/delete/"+$(this).attr("del-id"),
    			type:"POST",
    			data:$("#empDeleteModal form").serialize(),
    			success:function(){    				
    				$("#empDeleteModal").modal("hide");
    				alert("删除成功");
    				to_page(currentPage);
    			}
    		});
    	});
    	/* +++++++++++++++++批量删除员工 +++++++++++++++*/
    	//全选全不选
    	$("#check_all").click(function(){
    		//attr获取checked是undefined;
			//我们这些dom原生的属性；attr获取自定义属性的值；
			//prop修改和读取dom原生属性的值
    	$(".check_item").prop("checked",$(this).prop("checked"));
    	});
    	//一个个选
    	$(document).on("click",".check_item",function(){
    		//判断选中的个数是否等于总的个数
    		var flag = $(".check_item:checked").length==$(".check_item").length;
    		$("#check_all").prop("checked",flag);
    	});
    	$("#emp_delete_modal_btn").click(function(){
    		var empNames = "";//将所有名字组成串
    		var del_idstr = "";//将所有员工的id组成串
    		$.each($(".check_item:checked"),function(){
    			empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
    			del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
    		});
    		//去掉多余的，
    		empNames = empNames.substring(0, empNames.length-1);
    		//去掉多余的-
    		del_idstr = del_idstr.substring(0, del_idstr.length-1);
    					if(confirm("确认删除【"+empNames+"】吗？")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/delete/"+del_idstr,
					type:"POST",
					success:function(result){
						alert(result.msg);
						$("#check_all").prop("checked",false);
						//回到当前页面
						to_page(currentPage);
					}
				});
			}
    	});
    </script>
  </body>

   
</html>
