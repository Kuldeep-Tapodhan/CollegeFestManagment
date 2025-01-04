<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Participant Registration</title>
    <link rel="stylesheet" href="../css/s1.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }
        header {
            background-color: #005f87;
            color: #fff;
            padding: 20px;
            text-align: center;
        }
        main {
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin: 10px 0 5px;
            font-weight: bold;
        }
        input, select, button {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            background-color: #005f87;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #004466;
        }
    </style>
</head>
<body>
    <header>
        <h1>Register as a Participant</h1>
    </header>
    <main>
        <%
            // Retrieve and process eventName from the request
            String eventName = request.getParameter("eventName");

            if (eventName == null || eventName.trim().isEmpty()) {
        %>
                <h2>Error: Event Name is missing. Please select an event first.</h2>
                <a href="events.jsp"><button>Go Back to Events</button></a>
        <%
                return;
            }
            String evn = eventName.replaceAll("\\s+", "").toLowerCase();
            // Format eventName to match table naming conventions
            String formattedEventName = "event_" + evn + "_participants";
        %>

        <!-- Registration Form -->
        <form method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" required>

            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="payment">Payment Status:</label>
            <select id="payment" name="payment" required>
                <option value="paid">Paid</option>
                <option value="unpaid">Unpaid</option>
            </select>

            <!-- Hidden input to pass the eventName -->
            <input type="hidden" name="eventName" value="<%= eventName %>">

            <button type="submit">Register</button>
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String username = request.getParameter("username");
                String payment = request.getParameter("payment");

                // Database connection details
                String url = "jdbc:mysql://localhost:3306/eventmangmentsytem";
                String dbUser = "root";
                String dbPassword = "root";

                Connection con = null;
                PreparedStatement pstmt = null;
                PreparedStatement updateStmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, dbUser, dbPassword);

                    // Start transaction
                    con.setAutoCommit(false);

                    // Insert participant data
                    String insertParticipant = "INSERT INTO " + formattedEventName + " (name, email, phone, username, payment) VALUES (?, ?, ?, ?, ?)";
                    pstmt = con.prepareStatement(insertParticipant);
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, phone);
                    pstmt.setString(4, username);
                    pstmt.setString(5, payment);
                    pstmt.executeUpdate();

                    // Update event seats
                    String updateSeats = "UPDATE events SET filledSeats = filledSeats + 1, remainingSeats = remainingSeats - 1 WHERE eventName = ?";
                    updateStmt = con.prepareStatement(updateSeats);
                    updateStmt.setString(1, eventName);
                    int rowsUpdated = updateStmt.executeUpdate();

                    if (rowsUpdated == 0) {
                        throw new SQLException("No event found with the given name.");
                    }

                    // Commit transaction
                    con.commit();

                    out.println("<h2>Registration successful for the event!</h2>");
                    out.println("<a href='events.jsp'><button>Go Back to Events</button></a>");
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    if (con != null) {
                        try {
                            con.rollback();
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                    out.println("<h2>Registration failed: " + e.getMessage() + "</h2>");
                    out.println("<a href='events.jsp'><button>Go Back to Events</button></a>");
                } finally {
                    try {
                        if (pstmt != null) pstmt.close();
                        if (updateStmt != null) updateStmt.close();
                        if (con != null) con.setAutoCommit(true);
                        if (con != null) con.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            }
        %>
    </main>
</body>
</html>
