<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            message = "Passwords do not match!";
        } else {
            Connection conn = null;
            PreparedStatement pst = null;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "Gnsu@321");

                String query = "INSERT INTO DOCTOR_REGISTRATION (FULL_NAME, EMAIL, PHONE, PASSWORD) VALUES (?, ?, ?, ?)";
                pst = conn.prepareStatement(query);
                pst.setString(1, fullname);
                pst.setString(2, email);
                pst.setString(3, phone);
                pst.setString(4, password); // Ideally, hash password here

                int row = pst.executeUpdate();

                if (row > 0) {
                    // Redirect to login page after success

                    response.sendRedirect("login.jsp");

                    return;
                } else {
                    message = "Error occurred during registration.";
                }

            } catch (Exception e) {
                message = "Exception: " + e.getMessage();
            } finally {
                try {
                    if (pst != null) {
                        pst.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<html>
    <head>
        <title>Doctor Signup</title>
    </head>
    <body>
        <% if (!message.equals("")) {%>
        <p style="color:red;"><%= message%></p>
        <% }%>
    </body>
</html>
