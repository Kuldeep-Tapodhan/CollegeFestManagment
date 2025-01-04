<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Sign Up</title>
    <link rel="stylesheet" href="../css/s1.css">
</head>
<body>
    <header>
        <h1>User Sign Up</h1>
    </header>
    <main>
        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/eventmangmentsytem"; // Change "eventmangmentsytem" to your actual database name
            String dbUser = "root"; // Change "root" to your database username
            String dbPassword = "root"; // Change "" to your database password

            if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("username") != null && request.getParameter("password") != null) {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("confirmPassword");

                if (password.equals(confirmPassword)) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection(url, dbUser, dbPassword);
                        String query = "INSERT INTO participateuser (username, email, password) VALUES (?, ?, ?)";
                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, username);
                        pstmt.setString(2, email);
                        pstmt.setString(3, password);
                        pstmt.executeUpdate();

                        // Close the connection
                        pstmt.close();
                        con.close();

                        // Display success message and redirect to login page
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Registration successful! Please log in.');");
                        out.println("location='login.jsp';");
                        out.println("</script>");
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('JDBC Driver not found.');");
                        out.println("location='SignUp.jsp';");
                        out.println("</script>");
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Database error occurred.');");
                        out.println("location='SignUp.jsp';");
                        out.println("</script>");
                    }
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Passwords do not match.');");
                    out.println("location='SignUp.jsp';");
                    out.println("</script>");
                }
            }
        %>
        <form method="post" action="">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            
            <button type="submit">Sign Up</button>
        </form>
    </main>
</body>
</html>
