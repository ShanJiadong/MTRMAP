<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
	body, html {float: left;width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"΢���ź�";}
	#allmap {float: left;width: 67%;height: 100%;overflow: hidden;margin:0;font-family:"΢���ź�";}
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
	<title>��ͼչʾ</title>
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
			BufferedReader br = new BufferedReader(new InputStreamReader(in,"GBK"));  //ʹ�ļ��ɰ��ж�ȡ�����л��幦��		
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
							<li>��ţ�<%=line[0]%><input type="button"  value="ɾ��·�� " id="<%=line[0]%>" onClick='deleteline("<%=line[0]%>")'/></li>
						</ul>
	 				</div>
				</div>
				<%
				str = br.readLine();		
			}		
			br.close();    //�ر�������

			File file1 = new File(basePath,"Equipment.txt");		
			FileInputStream in1 = new FileInputStream(file1);
			BufferedReader br1 = new BufferedReader(new InputStreamReader(in1,"GBK"));  //ʹ�ļ��ɰ��ж�ȡ�����л��幦��		
			String equiplist="";
			String str1 = br1.readLine();
			while(str1!=null){
				equiplist += (str1+",");
				str1 = br1.readLine();		
			}		
			br1.close();    //�ر�������
		%>
	</div> 
	<input type="hidden" name="a" id="a" value="<%=equiplist%>">
</body>
</html>
<script type="text/javascript">
	// �ٶȵ�ͼAPI����
	var map = new BMap.Map("allmap");    // ����Mapʵ��
	map.centerAndZoom("����",14);      // ��ʼ����ͼ,�ó��������õ�ͼ���ĵ�
	map.setCurrentCity("����");          // ���õ�ͼ��ʾ�ĳ��� �����Ǳ������õ�
	map.enableInertialDragging();
	map.enableContinuousZoom();

	//��ӵ�ͼ���Ϳؼ�
	map.addControl(new BMap.MapTypeControl({
		mapTypes:[
                BMAP_NORMAL_MAP,
                BMAP_HYBRID_MAP]}));	

	map.enableScrollWheelZoom(true);     //��������������

	// ��������ͼ�����
	map.addTileLayer(new BMap.PanoramaCoverageLayer());
	var stCtrl = new BMap.PanoramaControl(); //����ȫ���ؼ�
	stCtrl.setOffset(new BMap.Size(15, 35));
	map.addControl(stCtrl);//���ȫ���ؼ�  

	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// ���Ͻǣ���ӱ�����
	var top_left_navigation = new BMap.NavigationControl();  //���Ͻǣ����Ĭ������ƽ�ƿؼ�
	map.addControl(top_left_control);        
	map.addControl(top_left_navigation);

	// ��Ӷ�λ�ؼ�
 	 var geolocationControl = new BMap.GeolocationControl();
  	geolocationControl.addEventListener("locationSuccess", function(e){
  	// ��λ�ɹ��¼�
  	var address = '';
  	address += e.addressComponent.province;
  	address += e.addressComponent.city;
  	address += e.addressComponent.district;
 	address += e.addressComponent.street;
 	address += e.addressComponent.streetNumber;
	alert("��ǰ��λ��ַΪ��" + address);});
	geolocationControl.addEventListener("locationError",function(e){
    	// ��λʧ���¼�
	alert(e.message);});
	map.addControl(geolocationControl);

	var size = new BMap.Size(40, 40);
	map.addControl(new BMap.CityListControl({
    		anchor: BMAP_ANCHOR_BOTTOM_RIGHT,
    		offset: size,}));
				// ��д�Զ��庯��,������ע
	
	function addMarker(point){
		var marker = new BMap.Marker(point);
		marker.addEventListener("click",function(e){
			var r=confirm("�Ƿ���Ҫ���豸" + point.id + "��·�����Ƴ�?");
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
             
						//ͨ���ݳ�ʵ�������һϵ�е������
             
						var pts= plan.getRoute(j).getPath();    
             
						var polyline = new BMap.Polyline(pts);  
						polyline.setStrokeColor("red"); 
             
						map.addOverlay(polyline); //���ƹ켣
            
					}
     
				}
        
			}});

			driving.search(startandend[0], startandend[1],{waypoints:WayPoints});//waypoints��ʾ;����
		}
		else{
			alert("�Ҳ���·��");
		}
	}

        	//·�߶���  
        	function line(id) {  
    			this.id = id;  
        	}  
        		
        	        	//·�߶���  
        	function rpoint(id) {  
    			this.id = id;  
        	}  
        
        	var xmlHttp; 

        	function createXMLHttpRequest() {//����xmlhttprequest���� 
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

        	//״̬�ı䴦����  
        	function handleStateChange() {  
    		if(xmlHttp.readyState == 4) {  
        			if(xmlHttp.status == 200) {  
            				alert("ɾ���ɹ���"); 
        			} 
			else if(xmlHttp.status == 404){
				alert(404);	
			}
		}  
	}

</script>
 