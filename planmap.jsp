<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
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
		height: 89%;
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
			File file = new File(basePath,"Equipment.txt");		
			FileInputStream in = new FileInputStream(file);
			BufferedReader br = new BufferedReader(new InputStreamReader(in,"GBK"));  //ʹ�ļ��ɰ��ж�ȡ�����л��幦��		
			String str = br.readLine();
			int i = 1;
			String points = "";
			String details = "";
			while(str!=null){
				String[] line = str.split(" "); 
				points += line[1];
				points += ",";
				points += line[2];
				points += " ";
				details += line[0];
				details += " ";%>
				<div class='div_celebrity_row' onClick='changecenter(<%=line[1]%>,<%=line[2]%>)'>
 					<div style='float'>
						<img class='img_celebrity_avatar' src='images/point.png'/> 
					</div>
					<div class='div_celebrity_info'>
						<ul class='ul_celebrity_info'>
							<li><%=line[5]%></li>
							<li>��ţ�<%=line[0]%></li>
						</ul>
	 				</div>
				</div>
				<%
				i++;
				str = br.readLine();		
			}		
			br.close();    //�ر�������
		%>
		<input type="hidden" name="a" id="a" value="<%=points%>">
		<input type="hidden" name="d" id="d" value="<%=details%>">
	</div> 
	<div>
		<label>������·�߱�ţ�</label>
		<input type="text" id="lid"/>
		<br>
		<label>������·��������</label>
		<input type="text" id="ldescription"/>
		<input type="button" onclick="addline();" value="ȷ�����" />
		<input type="button" onclick="reselect();" value="����ѡ��" />
	</div>
</body>
</html>
<script type="text/javascript">
	// �ٶȵ�ͼAPI����
	var map = new BMap.Map("allmap");    // ����Mapʵ��
	map.centerAndZoom("����",14);      // ��ʼ����ͼ,�ó��������õ�ͼ���ĵ�
	map.setCurrentCity("����");          // ���õ�ͼ��ʾ�ĳ��� �����Ǳ������õ�
	map.enableInertialDragging();
	map.enableContinuousZoom();

	function changecenter(lng,lat){
		//alert(lng + "," + lat);
		map.centerAndZoom(new BMap.Point(lng, lat), 20);
	}

	var points = [];
	var equipnum = document.getElementById('d').value;
	var n = document.getElementById('a').value;
	var t = n.replace(/(\s$)/g, "");
	var n = t.split(" ");
	//alert(equipnum);
	var en = equipnum.replace(/(\s$)/g, "");
	var m = en.split(" ");
	for(var i = 0; i<n.length;i++){
		var point = n[i].split(",");
		var p = new BMap.Point(point[0],point[1]);
		p.num=m[i];
		points.push(p);
	}
	if (document.createElement('canvas').getContext) {  // �жϵ�ǰ������Ƿ�֧�ֻ��ƺ�����
		var options = {
            shape: BMAP_POINT_SHAPE_WATERDROP
        }
        var pointCollection = new BMap.PointCollection(points, options);  // ��ʼ��PointCollection
		var newline = [];
        pointCollection.addEventListener('click', function (e) {
			newline.push(e.point);
			var startandend = [];
			var WayPoints = [];
			if(newline.length>=2){
				for(var i =0; i<newline.length;i++){
					if(i == 0 || i == newline.length-1){
						startandend.push(newline[i]);
					}
					else{
						WayPoints.push(newline[i]);
					}
				}
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
        });
		
		//����  
    	function line(id,description,equiplist) {  
    		this.id = id;  
    		this.description = description;
    		this.equiplist = equiplist;
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
      
    	function addline(){
    		var linenum="";
		if(newline.length==0){
			alert("������ѡ��һ���豸��");
		}
		else{
		for(var i = 0; i<newline.length;i++){
			linenum += newline[i].num + ",";
		}
		var id = document.getElementById("lid").value;
		var description = document.getElementById("ldescription").value;
	
		if(id==""){
			alert("·�߱�Ų���Ϊ�գ�");
		}
		else if(description==""){
			alert("·����������Ϊ�գ�");
		}
		else{
		var thenewline = new line(id,description,linenum);
		var lineasjson = JSON.stringify(thenewline);
		var url = "servlet/Addline?timeStamp=" + new Date().getTime();  
      
    		createXMLHttpRequest(); 
    		xmlHttp.open("POST", url, true);  
    		xmlHttp.onreadystatechange = handleStateChange;  
    		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");      
    		xmlHttp.send(lineasjson);}}
    	} 

    	//״̬�ı䴦����  
    	function handleStateChange() {  
    		if(xmlHttp.readyState == 4) {  
        		if(xmlHttp.status == 200) {  
            		alert("·�ߴ����ɹ���"); 
        		} 
				else if(xmlHttp.status == 404){
					alert(404);	
				}
			}  
		}
        map.addOverlay(pointCollection);  // ���Overlay
    } else {
        alert('����chrome��safari��IE8+����������鿴��ʾ��');
    }

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
</script>
 