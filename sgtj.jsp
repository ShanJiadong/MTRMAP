<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>任务设置</title>
<meta name="GENERATOR" content="MSHTML 10.00.9200.17116">
<link href="css/form.css" rel="stylesheet" type="text/css">
<script>
        //用户对象  
        function order(id, startdate, enddate, line, type, worker) {  
        this.id = id;
    	this.startdate = startdate;  
    	this.enddate = enddate;  
		this.line = line
    	this.type = type;  
    	this.worker = worker;  
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
      
         function addmission(){
	var startdate = document.getElementById("startdate").value;
	var enddate = document.getElementById("enddate").value;

	if(startdate=="" || startdate=="null"){
		alert("请选择开始日期!");
	}
	else if(enddate==""||enddate=="null"){
		alert("请选择结束日期!");
	}
	else{
		startdate=Date.parse(new Date(startdate.replace(/-/g, "/")));
		
enddate=Date.parse(new Date(enddate.replace(/-/g, "/")));
		
var millTime=enddate-startdate;  //时间差的毫秒数
		
if(millTime < 0)
		{    alert("活动结束日期不能早于活动开始日期!");  }

		else{
			var line = document.getElementById("line").value;
			var type = document.getElementById("type").value;
			var worker = document.getElementById("worker").value;
			var id = line + worker + new Date().getTime();
			var neworder = new order(id, startdate, enddate, line, type, worker);
			var orderasjson = JSON.stringify(neworder);
			var url = "servlet/Addmission?timeStamp=" + new Date().getTime();  
      
    			createXMLHttpRequest(); 
    			xmlHttp.open("POST", url, true);  
    			xmlHttp.onreadystatechange = handleStateChange;  
    			xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");      
    			xmlHttp.send(orderasjson);
			//alert(xmlHttp.responseText);
			//alert(123);
		}
	}
         } 

         //状态改变处理函数  
         function handleStateChange() {  
    	if(xmlHttp.readyState == 4) {  
		//alert(123);
        		if(xmlHttp.status == 200) {  
            			alert("任务创建成功！"); 
        		} 
		else if(xmlHttp.status == 404){
			alert(404);	
		}
	}  
           }
</script>
</head>
<body>
	<SCRIPT src="js/calendar.js"></SCRIPT>
	<div class="header">
		<h3>任务添加</h3>
	</div>
	<div class="container">
			<table border="0" width="607" height="187" cellspacing="1"
				cellpadding="0" class="formTable">
				<tr>
					<th height="30" width="157">开始日期</th>
					<td width="447">
						<input id="startdate" type="date"
						onClick="fPopCalendar(startdate,startdate);return false">
						至<input id="enddate" type="date"
						onClick="fPopCalendar(enddate,enddate);return false">
					</td>
				</tr>
				<tr>
					<th height="30" width="157">线路</th>
					<td width="447"><select id="line" style=" width:150px;">
						<%
							String path = request.getRealPath("");
							String basePath = path + "/database" ;		
							File file = new File(basePath,"Line.txt");		
							FileInputStream in = new FileInputStream(file);
							BufferedReader br = new BufferedReader(new InputStreamReader(in,"GBK"));  //使文件可按行读取并具有缓冲功能		
							String str = br.readLine();	
							int i = 0;	
							while(str!=null){
								String[] line = str.split(" "); %>
								<option value="<%=line[0]%>" ><%=line[1]%></option>
								
							<%	
								str = br.readLine();		
							}		
							br.close();    //关闭输入流
						%>
						</select>
						</td>
				</tr>

				<tr>
					<th height="30">作业类型</th>
					<td><select id="type" style=" width:150px;">
							<option value="lx" >例行巡查</option>
							<option value="gz">故障抢修</option>
					</select>
					</td>
				</tr>
				<tr>
					<th>作业人员</th>
					<td>
					<select id="worker" style=" width:150px;">
						<%		
							File file1 = new File(basePath,"User.txt");		
							FileInputStream in1 = new FileInputStream(file1);
							BufferedReader br1 = new BufferedReader(new InputStreamReader(in1,"GBK"));  //使文件可按行读取并具有缓冲功能		
							String str1 = br1.readLine();	
							while(str1!=null){			
								String[] line1 = str1.split(" "); 
								if(line1[2].equals("worker")){%>
								<option value="<%=line1[0]%>" ><%=line1[1]%></option>
							<%}str1 = br1.readLine();		
							}		
							br1.close();    //关闭输入流
						%>
					</select>
					</td>
				</tr>
				<tr>
					<td height="30" colspan="2" align="center"><input type="submit" value="提交" onclick="addmission()">
					</td>
				</tr>


			</table>
	</div>
</body>
</html>