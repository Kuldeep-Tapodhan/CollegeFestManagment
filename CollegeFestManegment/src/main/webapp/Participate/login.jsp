<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Participant Login</title>
    <link rel="stylesheet" href="../css/s1.css">
</head>
<body>
    <header>
        <h1>Participant Login</h1>
    </header>
    <main>
        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/eventmangmentsytem"; // Change "eventmangmentsytem" to your actual database name
            String dbUser = "root"; // Change "root" to your database username
            String dbPassword = "root"; // Change "" to your database password

            if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("username") != null && request.getParameter("password") != null) {
                String username = request.getParameter("username");
                String userPassword = request.getParameter("password");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(url, dbUser, dbPassword);
                    Statement stmt = con.createStatement();

                    // Query to check if the user exists in the database
                    String query = "SELECT * FROM participateuser WHERE username = '" + username + "' AND password = '" + userPassword + "'";
                    ResultSet rs = stmt.executeQuery(query);

                    if (rs.next()) {
                        // User exists, show success message and redirect to event page
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Login successful! Redirecting to event page.');");
                        out.println("location='../event/events.jsp';"); // Change to your actual event page
                        out.println("</script>");
                    } else {
                        // User does not exist, show error message
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('User not found! Please check your credentials or sign up.');");
                        out.println("location='login.jsp';"); // Redirect back to the login page
                        out.println("</script>");
                    }

                    // Close the connection
                    rs.close();
                    stmt.close();
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
            <button type="submit">Login</button>
            <button type="button" onclick="window.location.href='SignUp.jsp';">Sign-up</button>
        </form>
    </main>
</body>
</html>
