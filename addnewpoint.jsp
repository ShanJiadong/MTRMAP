<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>新建设备</title>
    <!-- Meta Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="GBK">
    <meta name="keywords" content="" />
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>

    <script src="js/getphotos.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=LFXMqi5h9IlPbf0jBsXYfhRnTzzDutkV"></script>
    <!-- //Meta Tags -->

    <!-- Style-sheets -->

    <link href="css/form.css" rel="stylesheet" type="text/css">
    <link href="css/getphotos.css" rel="stylesheet" type="text/css">
    <!-- Bootstrap Css -->
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <!-- Bootstrap Css -->
    <!-- Common Css -->
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
    <!--// Common Css -->
    <!-- Nav Css -->
    <link rel="stylesheet" href="css/style4.css">
    <!--// Nav Css -->
    <!-- widgets Css -->
    <link href="css/widgets.css" rel="stylesheet">
    <!-- widgets Css -->
    <!-- Fontawesome Css -->
    <link href="css/fontawesome-all.css" rel="stylesheet">
    <!--// Fontawesome Css -->
    <!--// Style-sheets -->

    <!--web-fonts-->
    <link href="http://fonts.googleapis.com/css?family=Poiret+One" rel="stylesheet">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
    <!--//web-fonts-->
</head>

<%
    	String uid=null;
   	
	String name = null;
	String type =null;	
	Cookie[] cookies=request.getCookies();
   	
	boolean flag = false;	
	for(int i=0;i<cookies.length;i++) {
   			
		if(cookies[i].getName().equals("get_id")) {
   				
			uid=cookies[i].getValue();
   
			flag = true;	 
		}
  
		if(cookies[i].getName().equals("get_name")) {
   				
			name=URLDecoder.decode(cookies[i].getValue(), "utf-8");//URLDecoder解码 	 
			flag = true;
		}
 
		if(cookies[i].getName().equals("get_type")) {
   				
			type=cookies[i].getValue();
   	 
			flag = true;
		}
 
 	}
     
	if(flag==false || uid.equals("")){response.sendRedirect("login.html");}//如果没找到cookie，就返回登陆界面 
%>


<body>
    <div class="wrapper">
        <!-- Sidebar Holder -->
         <nav id="sidebar">
            <div class="sidebar-header">
                <h1>
                    <a href="missionmaps.jsp">巡检系统</a>
                </h1>
                <span>M</span>
            </div>
            <div class="profile-bg"></div>
            <ul class="list-unstyled components">
                <li class="active">
                    <a href="missionmaps.jsp">
                        <i class="fas fa-th-large"></i>
                        任务地图
                    </a>
                </li>
	<li>
                    <a href="#homeSubmenu3" data-toggle="collapse" aria-expanded="false">
                        <i class="far fa-window-restore"></i>
                        设备管理
                        <i class="fas fa-angle-down fa-pull-right"></i>
                    </a>
                    <ul class="collapse list-unstyled" id="homeSubmenu3">
                        <li>
                            <a href="addnewpoint.jsp">新建设备</a>
                        </li>
	        <li>
                            <a href="pointmaps.jsp">设备分布</a>
                        </li>
                        <li>
                            <a href="details.jsp">设备详情</a>
                        </li>
                    </ul>
                </li>
	<%if(type.equals("admin")){%>
	<li>
                    <a href="#homeSubmenu1" data-toggle="collapse" aria-expanded="false">
                        <i class="far fa-window-restore"></i>
                        路线管理
                        <i class="fas fa-angle-down fa-pull-right"></i>
                    </a>
                    <ul class="collapse list-unstyled" id="homeSubmenu1">
                        <li>
                            <a href="routemaps.jsp">路线一览</a>
                        </li>
                        <li>
                            <a href="maps.jsp">路线创建</a>
                        </li>
                    </ul>
                </li>
	<li>
                    <a href="#homeSubmenu2" data-toggle="collapse" aria-expanded="false">
                        <i class="fas fa-laptop"></i>
                        任务管理
                        <i class="fas fa-angle-down fa-pull-right"></i>
                    </a>
                    <ul class="collapse list-unstyled" id="homeSubmenu2">
                        <li>
                            <a href="forms.jsp">发布任务</a>
                        </li>
                        <li>
                            <a href="widgets.jsp">任务列表</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="mailbox.jsp">
                        <i class="far fa-envelope"></i>
                        记录管理
                        <span class="badge badge-secondary float-md-right bg-danger">5 New</span>
                    </a>
                </li>
	<%}%>
                <li>
                    <a href="charts.jsp">
                        <i class="fas fa-chart-pie"></i>
                        巡检报表
                    </a>
                </li>
	<%if(type.equals("admin")){%>
                <li>
                    <a href="#pageSubmenu3" data-toggle="collapse" aria-expanded="false">
                        <i class="fas fa-users"></i>
                        用户管理
                        <i class="fas fa-angle-down fa-pull-right"></i>
                    </a>
                    <ul class="collapse list-unstyled" id="pageSubmenu3">
                        <li>
                            <a href="register.html">用户注册</a>
                        </li>
	        <li>
                            <a href="tables.jsp">用户列表</a>
                        </li>
                    </ul>
                </li>
	<%}%>
                <li>
                    <a href="linemaps.jsp">
                        <i class="far fa-map"></i>
                        线网图
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Page Content Holder -->
        <div id="content">
            <!-- top-bar -->
            <nav class="navbar navbar-default mb-xl-5 mb-4">
                <div class="container-fluid">

                    <div class="navbar-header">
                        <button type="button" id="sidebarCollapse" class="btn btn-info navbar-btn">
                            <i class="fas fa-bars"></i>
                        </button>
                    </div>
                    <!-- Search-from -->
                    <form action="#" method="post" class="form-inline mx-auto search-form">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" required="">
                        <button class="btn btn-style my-2 my-sm-0" type="submit">Search</button>
                    </form>
                    <!--// Search-from -->
                    <ul class="top-icons-agileits-w3layouts float-right">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false">
                                <i class="far fa-bell"></i>
                                <span class="badge">4</span>
                            </a>
                            <div class="dropdown-menu top-grid-scroll drop-1">
                                <h3 class="sub-title-w3-agileits">User notifications</h3>
                                <a href="#" class="dropdown-item mt-3">
                                    <div class="notif-img-agileinfo">
                                        <img src="images/clone.jpg" class="img-fluid" alt="Responsive image">
                                    </div>
                                    <div class="notif-content-wthree">
                                        <p class="paragraph-agileits-w3layouts py-2">
                                            <span class="text-diff">John Doe</span> Curabitur non nulla sit amet nisl tempus convallis quis ac lectus.</p>
                                        <h6>4 mins ago</h6>
                                    </div>
                                </a>
                                <a href="#" class="dropdown-item mt-3">
                                    <div class="notif-img-agileinfo">
                                        <img src="images/clone.jpg" class="img-fluid" alt="Responsive image">
                                    </div>
                                    <div class="notif-content-wthree">
                                        <p class="paragraph-agileits-w3layouts py-2">
                                            <span class="text-diff">Diana</span> Curabitur non nulla sit amet nisl tempus convallis quis ac lectus.</p>
                                        <h6>6 mins ago</h6>
                                    </div>
                                </a>
                                <a href="#" class="dropdown-item mt-3">
                                    <div class="notif-img-agileinfo">
                                        <img src="images/clone.jpg" class="img-fluid" alt="Responsive image">
                                    </div>
                                    <div class="notif-content-wthree">
                                        <p class="paragraph-agileits-w3layouts py-2">
                                            <span class="text-diff">Steffie</span> Curabitur non nulla sit amet nisl tempus convallis quis ac lectus.</p>
                                        <h6>12 mins ago</h6>
                                    </div>
                                </a>
                                <a href="#" class="dropdown-item mt-3">
                                    <div class="notif-img-agileinfo">
                                        <img src="images/clone.jpg" class="img-fluid" alt="Responsive image">
                                    </div>
                                    <div class="notif-content-wthree">
                                        <p class="paragraph-agileits-w3layouts py-2">
                                            <span class="text-diff">Jack</span> Curabitur non nulla sit amet nisl tempus convallis quis ac lectus.</p>
                                        <h6>1 days ago</h6>
                                    </div>
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">view all notifications</a>
                            </div>
                        </li>
                        <li class="nav-item dropdown mx-3">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false">
                                <i class="fas fa-spinner"></i>
                            </a>
                            <div class="dropdown-menu top-grid-scroll drop-2">
                                <h3 class="sub-title-w3-agileits">Shortcuts</h3>
                                <a href="#" class="dropdown-item mt-3">
                                    <h4>
                                        <i class="fas fa-chart-pie mr-3"></i>Sed feugiat</h4>
                                </a>
                                <a href="#" class="dropdown-item mt-3">
                                    <h4>
                                        <i class="fab fa-connectdevelop mr-3"></i>Aliquam sed</h4>
                                </a>
                                <a href="#" class="dropdown-item mt-3">
                                    <h4>
                                        <i class="fas fa-tasks mr-3"></i>Lorem ipsum</h4>
                                </a>
                                <a href="#" class="dropdown-item mt-3">
                                    <h4>
                                        <i class="fab fa-superpowers mr-3"></i>Cras rutrum</h4>
                                </a>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false">
                                <i class="far fa-user"></i>
                            </a>
                            <div class="dropdown-menu drop-3">
                                <div class="profile d-flex mr-o">
                                    <div class="profile-l align-self-center">
                                        <img src="images/profile.jpg" class="img-fluid mb-3" alt="Responsive image">
                                    </div>
                                    <div class="profile-r align-self-center">
                                        <h3 class="sub-title-w3-agileits"><%=name%></h3>
                                        <a href="mailto:info@example.com"><%=uid%></a>
                                    </div>
                                </div>
                                <a href="#" class="dropdown-item mt-3">
                                    <h4>
                                        <i class="far fa-user mr-3"></i>My Profile</h4>
                                </a>
                                <a href="#" class="dropdown-item mt-3">
                                    <h4>
                                        <i class="far fa-envelope mr-3"></i>Messages</h4>
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="login.html">Logout</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
            <!--// top-bar -->

            <div class="container">
                <div class="row">
		<div class="dom" style="display: block;margin:auto">
		<table border="0" width="607" height="187" cellspacing="1" cellpadding="0" class="formTable">
		<form>
			<tr>
				<th height="30" width="157">设备编号</th>
				<td width="447"><input id="eid" name="startdate" type="text" required="">
				</td>
			</tr>
			<tr>
				<th height="30">设备类型</th>
				<td><select id="etype" name="WORKTYPE" style=" width:150px;">
						<option value="CZ">车站</option>
						<option value="DL">电缆</option>
					</select>
				</td>
			</tr>
			<tr>
				<th height="30">设备位置</th>
				<td>经度<input id="lng" type="text" required=""> 纬度<input id="lat" type="text" required="">
				<input name="B2" type="submit" value="请求定位" onclick="getlocation()">
			</tr>
			<tr>
				<th>设备描述</th>
				<td><textarea id="edescription" rows="10" cols="50" required=""></textarea>
				</td>
			</tr>
			<tr>
				<th>设备图片</th>
				<td>
					<input id="img_input" type="file" accept="image/*"/ required="">
					<label for="img_input"></label>
					<div class="preview_box"></div>
				</td>
			</tr>
			<tr>
				<td height="30" colspan="2" align="center"><input name="B1" type="submit" value="提交" onclick="addequipment()">
				</td>
			</tr>
		</form>
		</table>
		</div>    
                </div>
	</div>       

            <!-- Copyright -->
            <div class="copyright-w3layouts py-xl-3 py-2 mt-xl-5 mt-4 text-center">
                <p>Copyright &copy; 2018.Company name All rights reserved.<a target="_blank" href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a></p>
            </div>
            <!--// Copyright -->
        </div>
    </div>


    <!-- Required common Js -->
    <script src='js/jquery-2.2.3.min.js'></script>
    <!-- //Required common Js -->

    <!-- Sidebar-nav Js -->
    <script>
        $(document).ready(function () {
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
            });
        });
    </script>
    <!--// Sidebar-nav Js -->

    <!-- dropdown nav -->
    <script>
        $(document).ready(function () {
            $(".dropdown").hover(
                function () {
                    $('.dropdown-menu', this).stop(true, true).slideDown("fast");
                    $(this).toggleClass('open');
                },
                function () {
                    $('.dropdown-menu', this).stop(true, true).slideUp("fast");
                    $(this).toggleClass('open');
                }
            );
        });
    </script>
    <!-- //dropdown nav -->

    <!-- Weather-skycons-icons -->
    <script src="js/skycons.js"></script>
    <script>
        var icons = new Skycons({
                "color": "#FFD700"
            }),
            list = [
                "clear-day"
            ],
            i;

        for (i = list.length; i--;)
            icons.set(list[i], list[i]);

        icons.play();
    </script>
    <script>
        var icons = new Skycons({
                "color": "#f5f5f5"
            }),
            list = [
                "clear-night", "partly-cloudy-day",
                "partly-cloudy-night", "cloudy", "rain", "sleet", "snow", "wind",
                "fog"
            ],
            i;

        for (i = list.length; i--;)
            icons.set(list[i], list[i]);

        icons.play();
    </script>
    <!--// Weather-skycons-icons -->

    <!-- Js for bootstrap working-->
    <script src="js/bootstrap.min.js"></script>
    <!-- //Js for bootstrap working -->
    
    <script>
         function addequipment(){
	//alert(123);
	// 获取当前日期
	var date = new Date();

	// 获取当前月份
	var nowMonth = date.getMonth() + 1;

	// 获取当前是几号
	var strDate = date.getDate();

	// 添加分隔符“-”
	var seperator = "-";

	// 对月份进行处理，1-9月在前面添加一个“0”
	if (nowMonth >= 1 && nowMonth <= 9) {
   		nowMonth = "0" + nowMonth;
	}

	// 对月份进行处理，1-9号在前面添加一个“0”
	if (strDate >= 0 && strDate <= 9) {
   		strDate = "0" + strDate;
	}

	// 最后拼接字符串，得到一个格式为(yyyy-MM-dd)的日期
	var nowDate = date.getFullYear() + seperator + nowMonth + seperator + strDate;

	var xhr=new XMLHttpRequest();
	xhr.open("post","servlet/Newequipment");
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if(xhr.status == 200){
				alert("图片上传成功"); 
			}else{
				alert("图片上传失败")
			}
		}
	};
	var id = document.getElementById("eid").value;
	var rid = id + new Date().getTime();
	var lng = document.getElementById("lng").value;
	var lat = document.getElementById("lat").value;
	var type = document.getElementById("etype").value;
	var description = document.getElementById("edescription").value;
	if(id==""){
		alert("编号不能为空！");
	}
	else if(lng==""){
		alert("经度不能为空！");
	}
	else if(lat==""){
		alert("纬度不能为空！");
	}
	else if(type==""){
		alert("类型不能为空！");
	}
	else if(description==""){
		alert("描述不能为空！");
	}
	else{
	var form_data = new FormData();
 	var file_data = $("#img_input").prop("files")[0];
	//alert(123);
  	//把上传的数据放入form_data
  	form_data.append("rid", rid);
  	form_data.append("eid", id);
  	form_data.append("type", type);
  	form_data.append("lng", lng);
  	form_data.append("lat", lat);
	form_data.append("date", nowDate);
  	form_data.append("description", description);
  	form_data.append("img", file_data);
	//alert(form_data);

  	xhr.send(form_data);
	}
         } 
		 
	function getlocation(){
		var geolocation = new BMap.Geolocation();
		geolocation.getCurrentPosition(function(e){
			var nowlng = e.point.lng;
			var nowlat = e.point.lat;
			document.getElementById("lng").value = nowlng;
			document.getElementById("lat").value = nowlat;
		});
	}

       $("#img_input").on("change", function(e) {

	var file = e.target.files[0]; //获取图片资源

  	// 只选择图片文件
  	if (!file.type.match('image.*')) {
    		return false;
  	}

  	var reader = new FileReader();

  	reader.readAsDataURL(file); // 读取文件

  	// 渲染文件
	reader.onload = function(arg) {
		var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
		$(".preview_box").empty().append(img);
	}
     });
    </script>


</body>

</html>