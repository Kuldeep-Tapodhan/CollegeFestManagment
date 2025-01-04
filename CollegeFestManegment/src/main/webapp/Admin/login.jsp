<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="../css/s1.css">
    <style>
     header {
            background-color: #3A3F58; /* Darker and more professional color */
            color: white;
            padding: 1em 0;
            text-align: center;
        }
    footer {
            background-color: #3A3F58;
            color: white;
            text-align: center;
            padding: 1em 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }</style>
</head>
<body>

    <header>
        <h1>Admin Login</h1>
    </header>
    
    <main>
        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/eventmangmentsytem"; // Change "eventmangmentsytem" to your actual database name
            String dbUser = "root"; // Change "root" to your database username
            String dbPassword = "root"; // Change "" to your database password

            if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("username") != null && request.getParameter("password") != null) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(url, dbUser, dbPassword);
                    String query = "SELECT * FROM admin WHERE username = ? AND password = ?";
                    PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        // Admin exists, show success message and redirect to admin dashboard
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Login successful! Redirecting to admin dashboard.');");
                        out.println("location='dashboard.jsp';"); // Change to your actual admin dashboard page
                        out.println("</script>");
                    } else {
                        // Admin does not exist, show error message
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Invalid username or password!');");
                        out.println("location='login.jsp';"); // Redirect back to the login page
                        out.println("</script>");
                    }

                    // Close the connection
                    rs.close();
                    pstmt.close();
                    con.close();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('JDBC Driver not found.');");
                    out.println("location='login.jsp';");
                    out.println("</script>");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Database error occurred.');");
                    out.println("location='login.jsp';");
                    out.println("</script>");
                }
            }
        %>
        <form method="post" action="">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <button type="submit" value="Login">Login</button>
        </form>
      
    </main>
    
        <footer>
        <p>&copy; 2024 College Fest Management System. All rights reserved.</p>
    </footer>
</body>
</html>
