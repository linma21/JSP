<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    String proNo = request.getParameter("proNo");
    String prodName = request.getParameter("prodName");
    String stock = request.getParameter("stock");
    String price = request.getParameter("price");
    String company = request.getParameter("company");

    try{
        Context ctx = (Context) new InitialContext().lookup("java:comp/env");
        DataSource ds = (DataSource) ctx.lookup("jdbc/shop");
        Connection conn = ds.getConnection();

        String sql = "INSERT INTO `Product` VALUES (?, ?, ?, ?, ?)";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, proNo);
        psmt.setString(2, prodName);
        psmt.setString(3, stock);
        psmt.setString(4, price);
        psmt.setString(5, company);

        psmt.executeUpdate();

        psmt.close();
        conn.close();

    } catch(Exception e){
        e.printStackTrace();
    }
    response.sendRedirect("./list.jsp");
%>
