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
	#allmap {float: left;width: 70%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
      	.right {background-color: white; margin-left: 250px; height: 100%; }
	.img_celebrity_avatar{	
		width:80px;
		height:75px; 
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
		margin-left: 30px; 
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
		width:160px;
		margin-top:25px;
		margin-left:25px;
		#border:1px solid red; 
	}
	#img_input2 { display: none; }
	#img_label2 { background-color: #f2d547; border-radius: 5px; display: inline-block; padding: 10px; }
	</style>
	<!-- Style-sheets -->
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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=LFXMqi5h9IlPbf0jBsXYfhRnTzzDutkV"></script>
	<title>设备列表</title>
</head>
<body>
	<script src="jquery-1.4.2.min.js"></script> 
	<div id="allmap">    
		<iframe id="myframe" frameborder=0 width=100% height=100% marginheight=0 marginwidth=0 scrolling=yes src="cards.jsp"></iframe> 
	</div>
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
				points += " ";%>
				<div class='div_celebrity_row' onClick='changecards("<%=line[0]%>","<%=line[1]%>","<%=line[2]%>")'>
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
	function changecards(id,lng,lat){
		//alert(id);
		document.getElementById("myframe").src="cards.jsp?equipment="+id+"&lng="+lng+"&lat="+lat;
		//window.frames[0].show(id);
	}
</script>
 