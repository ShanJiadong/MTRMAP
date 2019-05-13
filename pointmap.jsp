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
			File file = new File(basePath,"Equipment.txt");		
			FileInputStream in = new FileInputStream(file);
			BufferedReader br = new BufferedReader(new InputStreamReader(in,"GBK"));  //ʹ�ļ��ɰ��ж�ȡ�����л��幦��		
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
	if (document.createElement('canvas').getContext) {  // �жϵ�ǰ������Ƿ�֧�ֻ��ƺ�����
        		var options = {
            			shape: BMAP_POINT_SHAPE_WATERDROP
        		}
        		var pointCollection = new BMap.PointCollection(points, options);  // ��ʼ��PointCollection
        		pointCollection.addEventListener('click', function (e) {
			//alert('�����ĵ�Ϊ��' + e.point.id);  // ��������¼�
			var an = confirm("���Ƿ�Ҫɾ���豸��" + e.point.id + "��");
			if(an == true){
				deletepoint(e.point.id);
			}
        		});
        		map.addOverlay(pointCollection);  // ���Overlay
    	} else {
        		alert('����chrome��safari��IE8+����������鿴��ʾ��');
    	}

	function getLocation(flag)
	{
		if (navigator.geolocation&&flag=="3")
		{  navigator.geolocation.getCurrentPosition(locate); }
		else
		{ x.innerHTML="���������֧�ֻ�ȡ����λ�á�"; }
	}


	function locate(position) {   
             		//var latlon = position.coords.latitude+','+position.coords.longitude;   
             		//alert(latlon);
             		var ggPoint = new BMap.Point(position.coords.longitude,position.coords.latitude);
           		//����ת����֮��Ļص�����
          		translateCallback = function (data){
          			if(data.status === 0) {
			var pt = data.points[0];
			var marker = new BMap.Marker(pt);
			map.addOverlay(marker);
			map.centerAndZoom(pt, 20);
			geoc.getLocation(pt, function(rs){
				var addComp = rs.addressComponents;
				alert(addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
				var label = new BMap.Label("�������ֱ�עŶ",{offset:new BMap.Size(20,-10)});
				marker.setLabel(label);
			});      
          		}}

         		setTimeout(function(){
        			var convertor = new BMap.Convertor();
        			var pointArr = [];
        			pointArr.push(ggPoint);
        			convertor.translate(pointArr, 1, 5, translateCallback)
          		}, 1000);
	};

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
	function ZoomControl(){
		// Ĭ��ͣ��λ�ú�ƫ����
	  	this.defaultAnchor = BMAP_ANCHOR_BOTTOM_LEFT;
	  	this.defaultOffset = new BMap.Size(10, 50);
	}

	// ͨ��JavaScript��prototype���Լ̳���BMap.Control
	ZoomControl.prototype = new BMap.Control();

	// �Զ���ؼ�����ʵ���Լ���initialize����,���ҽ��ؼ���DOMԪ�ط���
	// �ڱ������д�����divԪ����Ϊ�ؼ�������,��������ӵ���ͼ������
	ZoomControl.prototype.initialize = function(map){
		// ����һ��DOMԪ��
		var div = document.createElement("div");
		// �������˵��
		div.appendChild(document.createTextNode("��ǰλ��"));
		// ������ʽ
		div.style.cursor = "pointer";
		div.style.border = "1px solid gray";
		div.style.backgroundColor = "white";
		// ���¼�,���һ�ηŴ�����
		div.onclick = function(e){
			getLocation(3);
		}
		// ���DOMԪ�ص���ͼ��
		map.getContainer().appendChild(div);
		// ��DOMԪ�ط���
		return div;
	}
	// �����ؼ�
	var myZoomCtrl = new ZoomControl();
	// ��ӵ���ͼ����
	map.addControl(myZoomCtrl);

	var size = new BMap.Size(40, 40);
	map.addControl(new BMap.CityListControl({
    		anchor: BMAP_ANCHOR_BOTTOM_RIGHT,
    		offset: size,}));


        	//�豸����
        	function dpoint(id) {  
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

        	//״̬�ı䴦����  
        	function handleStateChange() {  
    		if(xmlHttp.readyState == 4) {  
        			if(xmlHttp.status == 200) {  
            				alert("�豸ɾ���ɹ���"); 
        			} 
			else if(xmlHttp.status == 404){
				alert(404);	
			}
		}  
	}
</script>
 