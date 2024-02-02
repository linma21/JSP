<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String uid = request.getParameter("uid");
    String name = request.getParameter("name");
    String birth = request.getParameter("birth");
    String addr = request.getParameter("addr");

    try {
        Context initCtx = new InitialContext();
        Context ctx = (Context) initCtx.lookup("java:comp/env");

        DataSource ds = (DataSource) ctx.lookup("jdbc/studydb");
        Connection conn = ds.getConnection();

        String sql = "UPDATE `User2` SET ";
        sql += "`name`=?, ";
        sql += "`birth`=?, ";
        sql += "`addr`=? ";
        sql += "WHERE `uid` = ?";

        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, name);
        psmt.setString(2, birth);
        psmt.setString(3, addr);
        psmt.setString(4, uid);

        psmt.executeUpdate();

        psmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("./list.jsp");
%>
