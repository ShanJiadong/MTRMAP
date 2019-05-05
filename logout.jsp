
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

	//Ïú»Ùsession£º

	session.invalidate();

	//Çå³ýcookie£º
	Cookie cookie1 = new Cookie("get_id", null);

	cookie1.setMaxAge(-1);

	response.addCookie(cookie1);

	Cookie cookie2 = new Cookie("get_name", null);

	cookie2.setMaxAge(-1);

	response.addCookie(cookie2);

	Cookie cookie3 = new Cookie("get_type", null);

	cookie3.setMaxAge(-1);

	response.addCookie(cookie3);

	response.sendRedirect("./login.html");

%>
