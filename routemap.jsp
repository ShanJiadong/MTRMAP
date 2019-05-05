<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
	body, html {float: left;width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	#allmap {float: left;width: 67%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
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
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=LFXMqi5h9IlPbf0jBsXYfhRnTzzDutkV"></script>
	<title>地图展示</title>
</head>
<body>
	<div id="allmap"></div>
	<script src="jquery-1.4.2.min.js"></script> 
	<div class="div_celebrity_list">	
		<%
			String path = request.getRealPath("");
			String basePath = path + "/database" ;	
			File file = new File(basePath,"Line.txt");		
			FileInputStream in = new FileInputStream(file);
			BufferedReader br = new BufferedReader(new InputStreamReader(in,"GBK"));  //使文件可按行读取并具有缓冲功能		
			String str = br.readLine();
			while(str!=null){
				String[] line = str.split(" "); %>
				<div class='div_celebrity_row' onClick='show("<%=line[0]%>")'>
 					<div style='float'>
						<img class='img_celebrity_avatar' src='images/route.jpg'/> 
					</div>
					<div class='div_celebrity_info'>
						<ul class='ul_celebrity_info'>
							<li><%=line[1]%></li>
							<li>编号：<%=line[0]%><input type="button"  value="删除路线 " id="<%=line[0]%>" onClick='deleteline("<%=line[0]%>")'/></li>
						</ul>
	 				</div>
				</div>
				<%
				str = br.readLine();		
			}		
			br.close();    //关闭输入流

			File file1 = new File(basePath,"Equipment.txt");		
			FileInputStream in1 = new FileInputStream(file1);
			BufferedReader br1 = new BufferedReader(new InputStreamReader(in1,"GBK"));  //使文件可按行读取并具有缓冲功能		
			String equiplist="";
			String str1 = br1.readLine();
			while(str1!=null){
				equiplist += (str1+",");
				str1 = br1.readLine();		
			}		
			br1.close();    //关闭输入流
		%>
	</div> 
	<input type="hidden" name="a" id="a" value="<%=equiplist%>">
</body>
</html>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap");    // 创建Map实例
	map.centerAndZoom("广州",14);      // 初始化地图,用城市名设置地图中心点
	map.setCurrentCity("广州");          // 设置地图显示的城市 此项是必须设置的
	map.enableInertialDragging();
	map.enableContinuousZoom();

	//添加地图类型控件
	map.addControl(new BMap.MapTypeControl({
		mapTypes:[
                BMAP_NORMAL_MAP,
                BMAP_HYBRID_MAP]}));	

	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

	// 覆盖区域图层测试
	map.addTileLayer(new BMap.PanoramaCoverageLayer());
	var stCtrl = new BMap.PanoramaControl(); //构造全景控件
	stCtrl.setOffset(new BMap.Size(15, 35));
	map.addControl(stCtrl);//添加全景控件  

	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	map.addControl(top_left_control);        
	map.addControl(top_left_navigation);

	// 添加定位控件
 	 var geolocationControl = new BMap.GeolocationControl();
  	geolocationControl.addEventListener("locationSuccess", function(e){
  	// 定位成功事件
  	var address = '';
  	address += e.addressComponent.province;
  	address += e.addressComponent.city;
  	address += e.addressComponent.district;
 	address += e.addressComponent.street;
 	address += e.addressComponent.streetNumber;
	alert("当前定位地址为：" + address);});
	geolocationControl.addEventListener("locationError",function(e){
    	// 定位失败事件
	alert(e.message);});
	map.addControl(geolocationControl);

	var size = new BMap.Size(40, 40);
	map.addControl(new BMap.CityListControl({
    		anchor: BMAP_ANCHOR_BOTTOM_RIGHT,
    		offset: size,}));
				// 编写自定义函数,创建标注
	
	function addMarker(point){
		var marker = new BMap.Marker(point);
		marker.addEventListener("click",function(e){
			var r=confirm("是否需要将设备" + point.id + "从路线中移除?");
			if (r==true)
			{
   				removepoint(point.id);
			}
		});
		map.addOverlay(marker);
	}

	function show(line){
		//alert(line);
		map.clearOverlays();
		var points = [];
		var startandend = [];
		var WayPoints = [];
		var n = document.getElementById('a').value;
		var equipments = n.split(",");
		for(var i = 0; i<equipments.length; i++){
			if(equipments[i] != ""){
				var point = equipments[i].split(" ");
				if(point[3]==line){
					var temp = new BMap.Point(point[1],point[2]);
					temp.id = point[0];
					points.push(temp);
				}
			}
		}
		//alert(points.length);
		if(points.length!=0){
			for(var i = 0; i<points.length; i++){
				//alert(points[i].lng + " " + points[i].lat);
				if(i==0 || i==points.length-1){
					var temp = points[i];
					temp.id = points[i].id;
					//alert(temp.id);
					startandend.push(temp);
					//alert(123);
				}
				else{
					//alert(points[i].lng + " " + points[i].lat);
					var temp = points[i];
					temp.id = points[i].id;
					//alert(temp.id);
					WayPoints.push(temp);
				}
			}
			//alert(WayPoints.length);
			for (var i = 0; i < startandend.length; i ++) {
				map.centerAndZoom(startandend[i], 20);
				//alert(startandend[i].id);
				addMarker(startandend[i]);
			}
			//alert(123);
			for (var i = 0; i < WayPoints.length; i ++) {
				//alert(WayPoints[i].lng + " " + WayPoints[i].lat);
				addMarker(WayPoints[i]);
			}
			//alert(123);
			var driving = new BMap.DrivingRoute( map, {onSearchComplete: function(results){

				if (driving.getStatus() == BMAP_STATUS_SUCCESS){

					var plan = driving.getResults().getPlan(0);
        
					var  num = plan.getNumRoutes();
             
					for(var j =0;j<num ;j++){
             
						//通过驾车实例，获得一系列点的数组
             
						var pts= plan.getRoute(j).getPath();    
             
						var polyline = new BMap.Polyline(pts);  
						polyline.setStrokeColor("red"); 
             
						map.addOverlay(polyline); //绘制轨迹
            
					}
     
				}
        
			}});

			driving.search(startandend[0], startandend[1],{waypoints:WayPoints});//waypoints表示途经点
		}
		else{
			alert("找不到路线");
		}
	}

        	//路线对象  
        	function line(id) {  
    			this.id = id;  
        	}  
        		
        	        	//路线对象  
        	function rpoint(id) {  
    			this.id = id;  
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
        
	function removepoint(id){
		//alert(id);
		var newpoint = new rpoint(id);
		var pointasjson = JSON.stringify(newpoint);
		alert(pointasjson);  
		var url = "servlet/Removepoint?timeStamp=" + new Date().getTime();  
      
    		createXMLHttpRequest(); 
    		xmlHttp.open("POST", url, true);  
    		xmlHttp.onreadystatechange = handleStateChange;  
    		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");  
    		//alert(pointasjson);    
    		xmlHttp.send(pointasjson);
	}
        
      	 function deleteline(id){
		var newline = new line(id);
		var lineasjson = JSON.stringify(newline);
		var url = "servlet/Deleteline?timeStamp=" + new Date().getTime();  
      
    		createXMLHttpRequest(); 
    		xmlHttp.open("POST", url, true);  
    		xmlHttp.onreadystatechange = handleStateChange;  
    		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");      
    		xmlHttp.send(lineasjson);
         	} 

        	//状态改变处理函数  
        	function handleStateChange() {  
    		if(xmlHttp.readyState == 4) {  
        			if(xmlHttp.status == 200) {  
            				alert("删除成功！"); 
        			} 
			else if(xmlHttp.status == 404){
				alert(404);	
			}
		}  
	}

</script>
 