<%-- 
    Document   : login
    Created on : May 19, 2025, 11:47:03 AM
    Author     : asus1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%--@ page contentType="text/html;charset=UTF-8" language="java" --%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
     <%  
    // Login form se values lo
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Database connection variables
    String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; // 🔁 Change if needed
    String dbUser = "system"; // 🔁 Replace with your Oracle username
    String dbPass = "Gnsu@321"; // 🔁 Replace with your Oracle password

    boolean isValidUser = false;

    try {
        // Oracle JDBC Driver load karo
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Connection banao
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // SQL query prepare karo
        String sql = "SELECT * FROM DOCTOR_REGISTRATION WHERE email = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, password);

        // ResultSet check karo
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            isValidUser = true;
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Database Error: " + e.getMessage() + "</p>");
    }

    if (isValidUser) {
        // Redirect to index2.html
        response.sendRedirect("index2.html");
    } else {
%>
        <script>
            alert("successfully!");
            window.location.href = "login.html";
        </script>
<%
    }
%>

    </body>
</html>
