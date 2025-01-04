<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Events List</title>
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
            max-width: 800px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #005f87;
            color: #fff;
        }
        th:nth-child(3), td:nth-child(3) {
            width: 20%;
        }
        button {
            padding: 10px 20px;
            background-color: #005f87;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background-color: #004466;
        }
    </style>
</head>
<body>
    <header>
        <h1>Events List</h1>
    </header>
    <main>
        <h2>Available Events</h2>
        <table>
            <thead>
                <tr>
                    <th>Event Name</th>
                    <th>Description</th>
                    <th style="width: 20%;">Date</th>
                    <th>Seats (Remaining/Total)</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection
                    String jdbcURL = "jdbc:mysql://localhost:3306/eventmangmentsytem";
                    String dbUser = "root";
                    String dbPassword = "root";
                    
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        // Query to retrieve events
                        String sql = "SELECT eventid, eventName, eventDesc, eventDate, totalSeats, remainingSeats FROM events";
                        PreparedStatement statement = connection.prepareStatement(sql);
                        ResultSet resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            String eventId = resultSet.getString("eventid");
                            String eventName = resultSet.getString("eventName");
                            String eventDesc = resultSet.getString("eventDesc");
                            String eventDate = resultSet.getString("eventDate");
                            int totalSeats = resultSet.getInt("totalSeats");
                            int remainingSeats = resultSet.getInt("remainingSeats");
                %>
                <tr>
                    <td><%= eventName %></td>
                    <td><%= eventDesc %></td>
                    <td><%= eventDate %></td>
                    <td><%= remainingSeats %> / <%= totalSeats %></td>
                    <td>
                        <form action="RegisterParticipateDetails.jsp" method="GET">
    <input type="hidden" name="eventName" value="<%= eventName %>">
    <button type="submit">Show More</button>
</form>
                    </td>
                </tr>
                <%
                        }
                        connection.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </main>
</body>
</html>
