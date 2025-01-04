<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Events</title>
    <link rel="stylesheet" href="../css/style1.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            background-image: url('../images/background.jpg'); /* Ensure you have an appropriate background image */
            background-size: cover;
            background-position: center;
        }
        header {
            background-color: #007bff;
            color: #fff;
            padding: 20px;
            text-align: center;
            width: 100%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        main {
            width: 100%;
            max-width: 1200px;
            margin: 20px auto;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .events {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .event {
            background-color: #fff;
            border: 1px solid #ced4da;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap; /* Allow wrapping for smaller screens */
            gap: 15px;
        }
        .event-details {
            flex: 1;
            min-width: 200px;
        }
        .event h3 {
            font-size: 1.75em;
            margin: 10px 0;
            color: #007bff;
        }
        .event p {
            font-size: 1em;
            color: #495057;
            margin: 5px 0;
        }
        .event a {
            text-decoration: none;
        }
        .event button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .event button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <h1>Available Events</h1>
    </header>
    <main>
        <section class="events">
            <h4>List of Events</h4>
            <%
                // Database connection parameters
                String url = "jdbc:mysql://localhost:3306/eventmangmentsytem"; // Change "eventmangmentsytem" to your actual database name
                String dbUser = "root"; // Change "root" to your database username
                String dbPassword = "root"; // Change "" to your database password

                try (Connection con = DriverManager.getConnection(url, dbUser, dbPassword)) {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String query = "SELECT * FROM events";
                    try (PreparedStatement pstmt = con.prepareStatement(query);
                         ResultSet rs = pstmt.executeQuery()) {

                        while (rs.next()) {
                            int eventId = rs.getInt("eventId"); // Assuming "eventId" is the primary key in your table
                            String eventName = rs.getString("eventName");
                            String eventDesc = rs.getString("eventDesc");
                            String eventDate = rs.getString("eventDate");
                            String eventDuration = rs.getString("eventDuration");
                            int totalSeats = rs.getInt("totalSeats");
                            int filledSeats = rs.getInt("filledSeats");
                            int remainingSeats = rs.getInt("remainingSeats");

                            %>
                            <div class="event">
                                <div class="event-details">
                                    <h3><%= eventName %></h3>
                                    <p><strong>Description:</strong> <%= eventDesc %></p>
                                    <p><strong>Date:</strong> <%= eventDate %></p>
                                    <p><strong>Duration:</strong> <%= eventDuration %> hours</p>
                                    <p><strong>Total Seats:</strong> <%= totalSeats %></p>
                                    <p><strong>Filled Seats:</strong> <%= filledSeats %></p>
                                    <p><strong>Remaining Seats:</strong> <%= remainingSeats %></p>
                                </div>
                                <!-- Pass eventId as a query parameter -->
                                <form method="get" action="Register.jsp">
    <input type="hidden" name="eventName" value="<%= eventName %>">
    <button type="submit">Register Now <%= eventName %></button>
</form>
                            </div>
                            <%
                        }
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </section>
    </main>
</body>
</html>
