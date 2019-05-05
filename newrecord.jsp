<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
      String id = request.getParameter("equipment");
      String lng = request.getParameter("lng");
      String lat = request.getParameter("lat");
%>
<head>
<title>添加新记录</title>
<meta name="GENERATOR" content="MSHTML 10.00.9200.17116">
<link href="css/form.css" rel="stylesheet" type="text/css">
<script src='js/jquery-2.2.3.min.js'></script>
</head>
<body>
	<SCRIPT src="js/calendar.js"></SCRIPT>
	<div class="header">
		<h3>创建新记录</h3>
	</div>
	<div class="container">
		<table border="0" width="607" height="187" cellspacing="1" cellpadding="0" class="formTable">
			<tr>
				<th height="30" width="157">设备编号</th>
				<td width="447"><input id="eid" name="eid" type="text" value="<%=id%>">
				</td>
			</tr>

			<tr>
				<th height="30">设备类型</th>
				<td><select id="type" name="WORKTYPE" style=" width:150px;">
					<option value="CZ">车站</option>
					<option value="DL">电缆</option>
				</select>
				</td>
			</tr>
			<tr>
				<th height="30">设备位置</th>
				<td>经度<input id="lng" type="text" value="<%=lng%>"> 纬度<input id="lat" type="text" value="<%=lat%>">
				</td>
			</tr>
			<tr>
				<th>设备描述</th>
				<td><textarea id="description" rows="10" cols="50"></textarea>
				</td>
			</tr>
			<tr>
				<th>设备图片</th>
				<td>
					<input id="img_input" type="file" accept="image/*"/>
					<label for="img_input"></label>
					<div class="preview_box"></div>
				</td>
			</tr>
			<tr>
				<td height="30" colspan="2" align="center"><input name="B1" type="submit" value="提交" onclick="upload()">
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
<script>

function upload(){
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

	var xhr=new XMLHttpRequest();
	xhr.open("post","servlet/Fileupload");
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if(xhr.status == 200){
				alert("图片上传成功"); 
			}else{
				alert("图片上传失败")
			}
		}
	};
	var id = document.getElementById("eid").value;
	var rid = id + new Date().getTime();
	var type = document.getElementById("type").value;
	var lng = document.getElementById("lng").value;
	var lat = document.getElementById("lat").value;
	var description = document.getElementById("description").value;
	if(id=="" || id=="null"){
		alert("编号不能为空！");
	}
	else if(lng=="" || id=="null"){
		alert("经度不能为空！");
	}
	else if(lat=="" || id=="null"){
		alert("纬度不能为空！");
	}
	else if(type=="" || id=="null"){
		alert("类型不能为空！");
	}
	else if(description=="" || id=="null"){
		alert("描述不能为空！");
	}
	else{
	//alert(id + type + lng + " " + lat + description);
	var form_data = new FormData();
 	var file_data = $("#img_input").prop("files")[0];
	//alert(123);
  	//把上传的数据放入form_data
  	form_data.append("rid", rid);
	form_data.append("eid", id);
  	form_data.append("type", type);
  	form_data.append("lng", lng);
  	form_data.append("lat", lat);
	form_data.append("date", nowDate);
  	form_data.append("description", description);
  	form_data.append("img", file_data);
	//alert(form_data);

  	xhr.send(form_data);
	}
}

$("#img_input").on("change", function(e) {

	var file = e.target.files[0]; //获取图片资源

  	// 只选择图片文件
  	if (!file.type.match('image.*')) {
    		return false;
  	}

  	var reader = new FileReader();

  	reader.readAsDataURL(file); // 读取文件

  	// 渲染文件
	reader.onload = function(arg) {
		var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
		$(".preview_box").empty().append(img);
	}
});
</script>