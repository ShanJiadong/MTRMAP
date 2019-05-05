<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">

<%
      String id = request.getParameter("equipment");
      String lng = request.getParameter("lng");
      String lat = request.getParameter("lat");
      String newrecord_url = "newrecord.jsp?equipment=" + id + "&lng=" + lng + "&lat=" + lat;
%>

<head>
    <title>过往记录</title>
    <!-- Meta Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="GBK">
    <meta name="keywords" content="" />
    <link href="css/tab.css" rel="stylesheet">
    <link href="css/form.css" rel="stylesheet" type="text/css">
    <script src="js/tab.js" type="text/javascript"></script>
    <!-- //Meta Tags -->

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

    <!--web-fonts-->
    <link href="http://fonts.googleapis.com/css?family=Poiret+One" rel="stylesheet">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
    <!--//web-fonts-->
</head>

<body>

<div id="tab">
        
	<!--选项的头部-->
        
	<div id="tab-header">
		<ul>
			<li class="selected">过往记录</li>
			<li>新增记录</li>
		</ul>
	</div>
        
	<!--主要内容-->
        
	<div id="tab-content">
            
		<div class="dom" style="display: block;">
                	<ul>
                        	<div class="wrapper">
        		<!-- Page Content Holder -->
        		<div id="content">
            		<!-- main-heading -->
            		<h2 class="main-title-w3layouts mb-2 text-center">设备过往记录</h2>
            		<!--// main-heading -->
            		<!-- Cards content -->
            		<section class="cards-section">
                		<div class="card-columns">
			<%
			String path = request.getRealPath("");
			String basePath = path + "/database" ;	
			File file = new File(basePath,"Record.txt");		
			FileInputStream in = new FileInputStream(file);
			BufferedReader br = new BufferedReader(new InputStreamReader(in,"UTF-8"));  //使文件可按行读取并具有缓冲功能		
			String str = br.readLine();
			while(str!=null){
				String[] line = str.split(" ");
				if(line[2].equals(id)&&line[10].equals("p")){ %>
	   			<div class="card">
                        			<img class="card-img-top" src="<%="images/equipment/" + line[8]%>" alt="Card image cap">
                       			 <div class="card-body">
                            				<h5 class="card-title"><%=line[7]%></h5>
                            				<p class="card-text"><%=line[2]+"\n"+line[6]%></p>
                            				<a href="#" class="btn more mt-3" data-toggle="modal" data-target="#exampleModal">查看大图</a>
                            				<!-- Modal -->
                            				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel1" aria-hidden="true">
                                				<div class="modal-dialog" role="document">
                                    					<div class="modal-content">
                                        						<div class="modal-header">
                                            							<h5 class="modal-title" id="exampleModalLabel1"><%=line[7]%></h5>
                                            							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                							<span aria-hidden="true">&times;</span>
                                            							</button>
                                        						</div>
                                        						<div class="modal-body">
                                            							<img class="card-img-top" src="<%="images/equipment/" + line[8]%>" alt="Card image cap">
                                            							<p class="paragraph-agileits-w3layouts my-3"><%=line[2]+"\n"+line[6]%></p>
                                        						</div>
                                    					</div>
                                				</div>
                            				</div>
                            				<!-- /Modal -->
                        			</div>
                    			</div>
				<%}
				str = br.readLine();		
			}		
			br.close();    //关闭输入流
			%>
                		</div>
            		</section>

            		<!--// Cards content -->
        		</div>
    		</div>
		</ul>
		</div>

            		<div class="dom">

		<ul>
		<iframe frameborder=0 width=100% height=500px marginheight=0 marginwidth=0 scrolling=yes src="<%=newrecord_url%>"></iframe> 
		</ul>
            		</div>
	</div>
</body>
</html>