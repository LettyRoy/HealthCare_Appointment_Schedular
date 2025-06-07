<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("fullname");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String message = request.getParameter("message");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        // Load Oracle JDBC Driver
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Connect to Oracle DB
        // Replace your DB URL, username and password
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "Gnsu@321");

        // Insert query
        String query = "INSERT INTO contact_messages (full_name, email, phone, message) VALUES (?, ?, ?, ?)";

        ps = con.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, message);

        int rowsInserted = ps.executeUpdate();

        if (rowsInserted > 0) {
            out.println("<h3>Thank you! Your message has been received.</h3>");
        } else {
            out.println("<h3>Error occurred while saving your message.</h3>");
        }

    } catch (Exception e) {
        out.println("Database error: " + e.getMessage());
    } finally {
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("Closing error: " + e.getMessage());
        }
    }
%>

