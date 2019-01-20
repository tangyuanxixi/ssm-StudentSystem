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
  <script type="text/javascript" src="${APP_PATH} /static/js/jquery-2.1.4.min.js"></script>
  <!--引入样式  -->
  <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    


  </head>
  
  <body>
    <div class="container">
    <!--表名  -->
    	<div class="row">
	    	<div class="col-md-4 bg-info">
					<h1>SSM-CRUD</h1>
				</div>
    	</div>
    	<!--按钮  -->
    	<div class="row">
    	<button type="button" class="btn btn-primary col-md-offset-10">添加</button>
    	<button type="button" class="btn btn-warning ">删除</button>
    	</div>
    	<!--表格数据  -->
    	<div class="row">	
    	<table class="table table-hover">
    	<thead class="btn-info">
 				<tr>
						<th>id</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
		</thead>
		<tbody>
			<c:forEach items="${pageInfo.list }"  var="emp">
				<tr>
					<th>${emp.empId }</th>
					<th>${emp.empName }</th>
					<th>${emp.gender }</th>
					<th>${emp.email }</th>
					<th>${emp.dept.deptName }</th>
					<th>6</th>
				</tr>
				</c:forEach>
				</tbody>
		</table>
    	</div>	
    	<!--分页信息  -->
    	 <div class="row">	
    	 <div class="col-md-6">
    	 当前第 ${pageInfo.pageNum }，总共有 ${pageInfo.pages }，总共有${pageInfo.total }条记录
    	 </div>
    	 <div class="col-md-6 col-md-offset-7">
		    	 <nav aria-label="Page navigation">
					  <ul class="pagination">
					     <li>
					      <a href="${APP_PATH}/emps?pn=1" aria-label="Previous">
					        <span aria-hidden="true">首页</span>
					      </a>
					    </li>
					    <li>
					    	<c:if test="${pageInfo.hasPreviousPage}">
					      		<a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					   </c:if>
					    </li>
						<c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
							<c:if test="${page_Num == pageInfo.pageNum }">
								<li class="active"><a href="#">${page_Num }</a></li>
							</c:if>
							<c:if test="${page_Num != pageInfo.pageNum }">
								<li><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
							</c:if>
						</c:forEach>
						<li>
					     <c:if test="${pageInfo.hasNextPage }">
					      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					       </c:if>	
					       </li>	    
					       <li>
					      	<a href="${APP_PATH}/emps?pn=${pageInfo.pages}" aria-label="Previous">
					        <span aria-hidden="true">尾页</span>
					      </a>
					    </li>
					  </ul>
			</nav>
			</div>
    	</div>	
    </div>
  </body>
</html>
