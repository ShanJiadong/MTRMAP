<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.io.*" %>
<%@page import="java.net.URLEncoder"%>
<%
String path = request.getRealPath("");
String basePath = path + "/database" ;	
File file = new File(basePath,"User.txt");		
FileInputStream in = new FileInputStream(file);
BufferedReader br = new BufferedReader(new InputStreamReader(in,"GBK"));  //使文件可按行读取并具有缓冲功能		
String str = br.readLine();
int flag = 0;
while(str!=null){
	String[] line = str.split(" "); 
	String uid = request.getParameter("uid");
	String password = request.getParameter("password");
	String name = URLEncoder.encode(line[1],"utf-8");
	String type = line[2];
	if(request.getParameter("uid").equals(line[0]) && request.getParameter("password").equals(line[3])){
		session.setAttribute("login","ok");
		session.setMaxInactiveInterval(-1);
		flag = 1;
		Cookie a=new Cookie("get_id",uid);
		a.setMaxAge(600);
		response.addCookie(a);
		Cookie b=new Cookie("get_name",name);
		b.setMaxAge(600);
		response.addCookie(b);
		Cookie c=new Cookie("get_type",type);
		c.setMaxAge(600);
		response.addCookie(c);
		response.sendRedirect("./missionmaps.jsp");

	}
	str = br.readLine();		
}		
br.close();    //关闭输入流
if(flag == 0){out.println("user id or password error");}
%>
