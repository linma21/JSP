<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	if(uid != null && pass.equals("1234")){
		session.setAttribute("uid", uid);
	}
	response.sendRedirect("loginIndex.jsp");
%>