<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="java.io.*" %>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
	body, html {float: left;width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	#allmap {float: left;width: 67%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	#l-map{height:60%; width:100%;}
      	.right {background-color: white; margin-left: 250px; height: 100%; }
	.img_celebrity_avatar{	
		width:80px;
		height:80px; 
		vertical-align:middle;
		float:left; 	
		#border:1px solid green; 
	} 
	.div_celebrity_row{
		width:300px;
		height:80px;
		margin:8px;
		background:#eee;
		border:3px solid white;
		box-shadow: 5px 5px 5px #888888;
	}
	.div_celebrity_list{
		margin-left: 250px; 
		height: 100%;
		overflow-y:scroll;
		padding:4px;
 		border:2px dashed #aaa;} 
	.ul_celebrity_info{
		margin:0;
		padding:0;
		#border:1px solid red;
		 list-style:none; 
	}
	.div_celebrity_info{
		float:left;
		width:150px;
		margin-top:25px;
		margin-left:25px;
		#border:1px solid red; 
	}
	#r-result,#r-result table{width:100%;overflow:scroll;height:40%;}
	</style>
	<script type="text/javascript" 
	            src="http://api.map.baidu.com/api?v=2.0&ak=LFXMqi5h9IlPbf0jBsXYfhRnTzzDutkV">
	</script>
	<title>地图展示</title>
</head>
<body>
	<div id="allmap">
		<div id="l-map"></div>
		<div id="r-result"></div>
	</div>
	<script src="jquery-1.4.2.min.js"></script> 
	<div class="div_celebrity_list">	
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
     
			String path = request.getRealPath("");
			String basePath = path + "/database" ;	
			File file = new File(basePath,"Workorder.txt");		
			FileInputStream in = new FileInputStream(file);
			BufferedReader br = new BufferedReader(new InputStreamReader(in,"GBK"));  //使文件可按行读取并具有缓冲功能		
			String str = br.readLine();
			String points = "";
			while(str!=null){
				String[] line = str.split(" "); 
				if(line[5].equals(uid) || type.equals("admin")){
				points += line[8];
				points += ",";
				points += line[9];
				points += ",";
				points += line[7];
				points += " ";
				if(line[4].equals("null")){%>
				<div class='div_celebrity_row' onClick='changecenter(<%=line[8]%>,<%=line[9]%>)'>
 					<div style='float'>
						<img class='img_celebrity_avatar' src='images/mission.jpg'/> 
					</div>
					<div class='div_celebrity_info'>
						<ul class='ul_celebrity_info'>
							<li><%=line[7]%></li>
							<li>编号：<%=line[10]%></li>
						</ul>
	 				</div>
				</div>
				<%}
				}
				str = br.readLine();		
			}		
			br.close();    //关闭输入流
		%>
		<input type="hidden" name="a" id="a" value="<%=points%>">
	</div> 
</body>
</html>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("l-map");    // 创建Map实例
	map.centerAndZoom("广州",14);      // 初始化地图,用城市名设置地图中心点
	map.setCurrentCity("广州");          // 设置地图显示的城市 此项是必须设置的
	//map.setMapType(BMAP_PERSPECTIVE_MAP);     //修改地图类型为3D地图
	map.enableInertialDragging();
	map.enableContinuousZoom();
	var geoc = new BMap.Geocoder();   

	var equipment_table;

	function changecenter(lng,lat){
		map.clearOverlays();
		addpoint();
		equipment_table = new BMap.Point(lng, lat);
		getLocation(2);
	}

	var equipment;

	var points = [];
	var n = document.getElementById('a').value;
	//alert(n);
	var t = n.replace(/(\s$)/g, "");
	var n = t.split(" ");
	for(var i = 0; i<n.length;i++){
		var point = n[i].split(",");
		var temp = new BMap.Point(point[0],point[1]);
		temp.id = point[2];
		points.push(temp);
	}
	function addpoint(){
		if (document.createElement('canvas').getContext) {  // 判断当前浏览器是否支持绘制海量点
        			var options = {
            				shape: BMAP_POINT_SHAPE_WATERDROP
        			}
        			var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
        			pointCollection.addEventListener('click', function (e) {
				equipment = e.point;
				getLocation(1);
        			});
        			map.addOverlay(pointCollection);  // 添加Overlay
    		} else {
        			alert('请在chrome、safari、IE8+以上浏览器查看本示例');
    		}
	}

	function getLocation(flag)
	{
		if (navigator.geolocation&&flag=="1")
		{  navigator.geolocation.getCurrentPosition(showPosition); }
		else if (navigator.geolocation&&flag=="2")
		{  navigator.geolocation.getCurrentPosition(success); }
		else if (navigator.geolocation&&flag=="3")
		{  navigator.geolocation.getCurrentPosition(locate); }
		else
		{ x.innerHTML="该浏览器不支持获取地理位置。"; }
	}

	function success(position) {   
		//var latlon = position.coords.latitude+','+position.coords.longitude;   
             		//alert(latlon);
		var ggPoint = new BMap.Point(position.coords.longitude,position.coords.latitude);
           		//坐标转换完之后的回调函数
          		translateCallback = function (data){
          			if(data.status === 0) {
			var driving = new BMap.DrivingRoute(map, {renderOptions: {map: map, panel: "r-result", autoViewport: true}});
			driving.search(data.points[0], equipment_table);
          		}}

         		setTimeout(function(){
        			var convertor = new BMap.Convertor();
        			var pointArr = [];
        			pointArr.push(ggPoint);
        			convertor.translate(pointArr, 1, 5, translateCallback)
          		}, 1000);
	};

         	function showPosition(position) {   
             		//var latlon = position.coords.latitude+','+position.coords.longitude;   
             		//alert(latlon);
             		var ggPoint = new BMap.Point(position.coords.longitude,position.coords.latitude);
		//alert(equipment.id);
           		//坐标转换完之后的回调函数
          		translateCallback = function (data){
          			if(data.status === 0) {
			var distance = (map.getDistance(equipment,data.points[0])).toFixed(2); 
			var an=confirm( "你是否要考勤？你与设备" + equipment.id +  "的距离为" + distance + "米");
			if (an==true && distance <= 300)
			{
				attendance(equipment.id);
    				alert("考勤成功!");
			}
			else
			{
   				alert("你尚未抵达设备区域！");
			}
          		}}

         		setTimeout(function(){
        			var convertor = new BMap.Convertor();
        			var pointArr = [];
        			pointArr.push(ggPoint);
        			convertor.translate(pointArr, 1, 5, translateCallback)
          		}, 1000);
	};

	function locate(position) {   
             		//var latlon = position.coords.latitude+','+position.coords.longitude;   
             		//alert(latlon);
             		var ggPoint = new BMap.Point(position.coords.longitude,position.coords.latitude);
           		//坐标转换完之后的回调函数
          		translateCallback = function (data){
          			if(data.status === 0) {
			var pt = data.points[0];
			var marker = new BMap.Marker(pt);
			map.addOverlay(marker);
			map.centerAndZoom(pt, 20);
			geoc.getLocation(pt, function(rs){
				var addComp = rs.addressComponents;
				alert(addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
			});      
          		}}

         		setTimeout(function(){
        			var convertor = new BMap.Convertor();
        			var pointArr = [];
        			pointArr.push(ggPoint);
        			convertor.translate(pointArr, 1, 5, translateCallback)
          		}, 1000);
	};

	//添加地图类型控件
	map.addControl(new BMap.MapTypeControl({
		mapTypes:[
                BMAP_NORMAL_MAP,
                BMAP_HYBRID_MAP,
	BMAP_PERSPECTIVE_MAP]}));	

	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

	// 覆盖区域图层测试
	map.addTileLayer(new BMap.PanoramaCoverageLayer());
	var stCtrl = new BMap.PanoramaControl(); //构造全景控件
	stCtrl.setOffset(new BMap.Size(15, 35));
	map.addControl(stCtrl);//添加全景控件  

	var top_left_control 
		= new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	map.addControl(top_left_control);    
	var top_left_navigation 
		= new BMap.NavigationControl();
	map.addControl(top_left_navigation);

	// 添加定位控件
 	// var geolocationControl = new BMap.GeolocationControl();
  	//geolocationControl.addEventListener("locationSuccess", function(e){
  		// 定位成功事件
  		//var address = '';
  		//address += e.addressComponent.province;
  		//address += e.addressComponent.city;
  		//address += e.addressComponent.district;
 		//address += e.addressComponent.street;
 		//address += e.addressComponent.streetNumber;
		//alert("当前定位地址为：" + address);
	//});
	//geolocationControl.addEventListener("locationError",function(e){
    		// 定位失败事件
		//alert(e.message);
	//});
		

	//map.addControl(geolocationControl);

	// 定义一个控件类,即function
	function ZoomControl(){
		// 默认停靠位置和偏移量
	  	this.defaultAnchor = BMAP_ANCHOR_BOTTOM_LEFT;
	  	this.defaultOffset = new BMap.Size(10, 50);
	}

	// 通过JavaScript的prototype属性继承于BMap.Control
	ZoomControl.prototype = new BMap.Control();

	// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
	// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
	ZoomControl.prototype.initialize = function(map){
		// 创建一个DOM元素
		var div = document.createElement("div");
		// 添加文字说明
		div.appendChild(document.createTextNode("当前位置"));
		// 设置样式
		div.style.cursor = "pointer";
		div.style.border = "1px solid gray";
		div.style.backgroundColor = "white";
		// 绑定事件,点击一次放大两级
		div.onclick = function(e){
			getLocation(3);
		}
		// 添加DOM元素到地图中
		map.getContainer().appendChild(div);
		// 将DOM元素返回
		return div;
	}
	// 创建控件
	var myZoomCtrl = new ZoomControl();
	// 添加到地图当中
	map.addControl(myZoomCtrl);

	var size = new BMap.Size(40, 40);
	map.addControl(new BMap.CityListControl({
    		anchor: BMAP_ANCHOR_BOTTOM_RIGHT,
    		offset: size,
	}));


        	//设备对象
        	function attendancepoint(id, finidate) {  
		//alert(id + finidate);
    		this.id = id; 
		this.finidate = finidate;
        	}  
        
        	var xmlHttp; 

        	function createXMLHttpRequest() {//创建xmlhttprequest对象。 
    		if (window.ActiveXObject) { 
     			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP"); 
    		} 
    		else if (window.XMLHttpRequest) { 
        			xmlHttp = new XMLHttpRequest(); 
   		} 
       	 }
        
        
      	function attendance(id){
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
		//alert(nowDate);
		var apoint = new attendancepoint(id, nowDate);
		//alert(id);
		var pointasjson = JSON.stringify(apoint);
		//alert(pointasjson);
		var url = "servlet/Attendance?timeStamp=" + new Date().getTime();  
      
    		createXMLHttpRequest(); 
    		xmlHttp.open("POST", url, true);  
    		xmlHttp.onreadystatechange = handleStateChange;  
    		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");      
    		xmlHttp.send(pointasjson);
         	} 

        	//状态改变处理函数  
        	function handleStateChange() {  
    		if(xmlHttp.readyState == 4) {  
        			if(xmlHttp.status == 200) {  
            				alert("设备删除成功！"); 
        			} 
			else if(xmlHttp.status == 404){
				alert(404);	
			}
		}  
	}
</script>
 