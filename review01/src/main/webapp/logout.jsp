<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.removeAttribute("uid");
	response.sendRedirect("login.jsp");
%>