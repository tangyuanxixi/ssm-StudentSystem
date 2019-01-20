# ssm-crud项目
这段时间根据网上的视频学了整合SSM(spring,springmvc,mybatis)的功能来实现增删改查，做一下总结
#### 一、基本的环境配置
>1、创建一个Maven工程，用maven repository在pom.xml导入相应的包：spring，springmvc，mybatis
数据库连接池（c3p0）,数据库驱动，还有其他的jstl,servlet-api,junit.<br>
2、引入bootstrap前端框架https://v3.bootcss.com/<br>
3、编写ssm整合的关键配置文件，web.xml,spring,springmvc,mybatis,使用mybatis逆向工程编写mbg.xml文档，进行
相关的表的配置和生成，生成对应的对应的bean已经Mapper。http://www.mybatis.org/generator/index.html<br>
4、测试Mapper，根据官方文档编写相应的test类，执行之后自动生成bean和mapper
#### 二、tomcat、springmvc、spring、mybatis配置文件

>1、首先在web.xml文件中配置相应的spring,springmvc和其他的一些文件，因为在项目启动的时候，容器（tomcat）首先会
去加载web.xml,所以如果web.xml配置没写好，项目启动都启动不起来。<br>
2、tomcat配置
容器首先会去它的配置文件web.xml读取两个节点:  <listener></listener>和
<context-param></context-param>，父容器是通过监听ServletContextListener上下文事件通过
ContextLoaderListener初始化并加载所需要的容器环境（通过查看源码可以发现ContextLoaderListener实现
ServletContextListener接口），子容器就是当初始化Servlet时加载用于SpringMVC功能的容器环境。这样就实现
了spring和springmvc启动的配置。<br>
3、springmvc配置
springmvc主要实现controller控制层的功能，所以我们在dispatcherServlet-servlet.xml配置中只
拦截controller层的内容。另外还可以配置其他的网页前缀和后缀的格式。还有一些springmvc不能处理的和JSR303校验等。。。<br>
4、spring配置
spring相当于一个集合总站，它处理springmvc没有处理的其余功能，在springmvc处理了控制器的拦截，对拦截的
内容进行相应的处理之后交给spring。所以在applicationContest.xml中首先配置了除了controller之外的其他包
扫描，因为mybatis是交给spring进行处理的，所以配置数据库的数据源MYSQL，还有mybatis的事务控制。。。
spring的事务控制一般都由3部分组成、分别是DataSource、TransactionManager和代理机制这三部分，无论哪种配置方式，
一般变化的只是代理机制这部分。
DataSource、TransactionManager这两部分只是会根据数据访问方式有所变化，比如使用Hibernate进行数据访问
时，DataSource实际为SessionFactory，TransactionManager的实现为HibernateTransactionManager。
而根据代理机制的不同，有几种Spring事务的配置方式，其中有配置式的bean配置，还有用tx标签的注解式配置。<br>
5、mybatis配置，这个就随便配置，可以根据官方文档进行相关的配置，如驼峰命名，还有后面要用到的分页功能。
#### 三、crud运行的过程。
总的过程：<br>启动项目->加载webapp下的index.jsp->javascript中的ajax请求->springmvc拦截请求到相应的函数（RequestMapping）进行处理->根据相应的请求service层的功能->service层调用dao层的实现->相应的mapper里面执行相应的sql语句->
将结果返回->自定义MSG来封装取得的数据和返回的相应信息->一个根据return返回相应的界面，
这里采用Json封装数据，所以返回的是一个json数据（ResponseBody）->json字符串返回到前端，前端根据收到
的数据进行解析->显示在界面

#### 四、注意事项
1、相应的spring、springmvc....版本库要对应的上，不然会报各种你永远无法解决也没头绪的错误<br>
2、类、函数命名要规范，类开头字母大写的驼峰命名，函数开头小写的驼峰命名，拼全函数或者类含义的单词，不要
缩写<br>
3、相关的功能包分好类，比如service层、controller层、dao层、bean应该用相应的包对应起来。
