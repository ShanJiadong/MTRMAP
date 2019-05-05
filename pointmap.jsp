<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
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
			File file = new File(basePath,"Equipment.txt");		
			FileInputStream in = new FileInputStream(file);
			BufferedReader br = new BufferedReader(new InputStreamReader(in,"GBK"));  //使文件可按行读取并具有缓冲功能		
			String str = br.readLine();
			int i = 1;
			String points = "";
			while(str!=null){
				String[] line = str.split(" "); 
				points += line[1];
				points += ",";
				points += line[2];
				points += ",";
				points += line[0];
				points += " ";%>
				<div class='div_celebrity_row' onClick='changecenter(<%=line[1]%>,<%=line[2]%>)'>
 					<div style='float'>
						<img class='img_celebrity_avatar' src='images/point.png'/> 
					</div>
					<div class='div_celebrity_info'>
						<ul class='ul_celebrity_info'>
							<li><%=line[5]%></li>
							<li>编号：<%=line[0]%></li>
						</ul>
	 				</div>
				</div>
				<%
				i++;
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
	var map = new BMap.Map("allmap");    // 创建Map实例
	map.centerAndZoom("广州",14);      // 初始化地图,用城市名设置地图中心点
	map.setCurrentCity("广州");          // 设置地图显示的城市 此项是必须设置的
	map.enableInertialDragging();
	map.enableContinuousZoom();

	function changecenter(lng,lat){
		//alert(lng + "," + lat);
		map.centerAndZoom(new BMap.Point(lng, lat), 20);
	}

	var points = [];
	var n = document.getElementById('a').value;
	//alert(n);
	var t = n.replace(/(\s$)/g, "");
	var n = t.split(" ");
	for(var i = 0; i<n.length;i++){
		var point = n[i].split(",");
		var equipment = new BMap.Point(point[0],point[1]);
		equipment.id = point[2];
		//alert(equipment.id );
		points.push(equipment);
	}
	if (document.createElement('canvas').getContext) {  // 判断当前浏览器是否支持绘制海量点
        		var options = {
            			shape: BMAP_POINT_SHAPE_WATERDROP
        		}
        		var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
        		pointCollection.addEventListener('click', function (e) {
			//alert('单击的点为：' + e.point.id);  // 监听点击事件
			var an = confirm("你是否要删除设备点" + e.point.id + "？");
			if(an == true){
				deletepoint(e.point.id);
			}
        		});
        		map.addOverlay(pointCollection);  // 添加Overlay
    	} else {
        		alert('请在chrome、safari、IE8+以上浏览器查看本示例');
    	}

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


        	//设备对象
        	function dpoint(id) {  
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
        
        
      	function deletepoint(id){
		var newpoint = new dpoint(id);
		var pointasjson = JSON.stringify(newpoint);
		var url = "servlet/Deletepoint?timeStamp=" + new Date().getTime();  
      
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
 