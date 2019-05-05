<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>

<html lang="en">

<head>
    
	<meta charset="GBK">
    
	<title>选项卡</title>
    
	<link href="css/tab.css" rel="stylesheet">
    
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
    	<!-- Fontawesome Css -->
    	<link href="css/fontawesome-all.css" rel="stylesheet">
    	<!--// Fontawesome Css -->
    	<!--// Style-sheets -->
	<style type="text/css">
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
		margin-right: 250px; 
		height: 900px;
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
	<script src="js/tab.js" type="text/javascript"></script>

	<script src="js/getphotos.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=LFXMqi5h9IlPbf0jBsXYfhRnTzzDutkV"></script>
	<script>
		
	//用户对象  
        	function equipment(id, lng, lat, type, description,rid) {  
    		this.id = id;  
    		this.lng = lng;  
    		this.lat = lat;  
    		this.type = type;  
    		this.description = description;
		this.rid = rid;
        	}  

	function record(rid) {  
    		this.rid = rid;  
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

         	//状态改变处理函数  
         	function handleStateChange() {  
    		if(xmlHttp.readyState == 4) {  
        		if(xmlHttp.status == 200) {  
            			alert("审核成功！"); 
        		} 
				else if(xmlHttp.status == 404){
					alert(404);	
				}
			}  
		 }

	function check_ok(id, lng, lat, type, description, rid){
		//alert(id);
		var newpoint = new equipment(id, lng, lat, type, description, rid);
		var pointasjson = JSON.stringify(newpoint);
		//alert(pointasjson);  
		var url = "servlet/Recordtoequipment?timeStamp=" + new Date().getTime();  
      
    		createXMLHttpRequest(); 
    		xmlHttp.open("POST", url, true);  
    		xmlHttp.onreadystatechange = handleStateChange;  
    		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");  
    		//alert(pointasjson);    
    		xmlHttp.send(pointasjson);
	}

	function check_notok(rid){
		//alert(id);
		var newrecord = new record(rid);
		var recordasjson = JSON.stringify(newrecord);
		alert(recordasjson);  
		var url = "servlet/Unpassrecord?timeStamp=" + new Date().getTime();  
      
    		createXMLHttpRequest(); 
    		xmlHttp.open("POST", url, true);  
    		xmlHttp.onreadystatechange = handleStateChange;  
    		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");  
    		xmlHttp.send(recordasjson);
	}
	</script>
</head>

<body>
    
    
	<div id="tab">
        
	<!--选项的头部-->
        
	<div id="tab-header">
		<ul>
			<li class="selected">记录审核</li>
		</ul>
	</div>
        
	<!--主要内容-->
        
	<div id="tab-content">
            
		<div class="dom" style="display: block;">

                	<ul>
                    
			<!-- table3 -->
                		<div class="outer-w3-agile mt-3">
                  		<h4 class="tittle-w3-agileits mb-4">记录列表</h4>
                    		<table class="table table-striped">
                        		<thead>
                            		<tr>
                                		<th scope="col">记录编号</th>
                                		<th scope="col">设备编码</th>
                                		<th scope="col">是否新增</th>
                                		<th scope="col">设备描述</th>
				<th scope="col">上传时间</th>
				<th scope="col">附件图片</th>
                                		<th scope="col">操作</th>
                            		</tr>
                        		</thead>
                        		<tbody>
				<tr>
				<%
				String path = request.getRealPath("");
				String basePath = path + "/database" ;	
				File file = new File(basePath,"Record.txt");		
				FileInputStream in = new FileInputStream(file);
				BufferedReader br = new BufferedReader(new InputStreamReader(in,"UTF-8"));  //使文件可按行读取并具有缓冲功能		
				String str = br.readLine();
				while(str!=null){
					String[] line = str.split(" "); 
					String photo = "images" + "/" + "equipment" + "/" + line[8];
					if(line[9].equals("n")){%>
					<tr>
					<th scope="row"><%=line[0]%></th>
                               				<td><%=line[2]%></td>
					<%if(line[1].equals("new")){%>
                                			<td>是</td>
					<%}else{%>
					<td>否</td>
					<%}%>
                                			<td><%=line[6]%></td>
                                			<td><%=line[7]%></td>
					<td><a href="<%=photo%>" target="view_window">查看图片</a></td>
                                			<td>
						<input type="button" onclick="check_ok('<%=line[2]%>','<%=line[4]%>','<%=line[5]%>','<%=line[3]%>','<%=line[6]%>','<%=line[0]%>')" value="审核通过" />
						<input type="button" onclick="check_notok('<%=line[0]%>')" value="拒绝通过" />
					</td>
                         	   			</tr>
					<%
					}str = br.readLine();		
				}		
				br.close();    //关闭输入流
				%>
                         	   		</tr>
                       		 </tbody>
                    		</table>
		</ul>
            
		</div>
            
	</div>
    
	</div>
</body>

</html>