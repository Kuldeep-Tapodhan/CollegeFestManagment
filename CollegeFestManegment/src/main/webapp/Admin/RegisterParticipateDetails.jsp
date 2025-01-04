<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Participant Details</title>
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
    </style>
</head>
<body>
    <header>
        <h1>Participant Details</h1>
    </header>
    <main>
        <h2>Participants for Event: <%= request.getParameter("eventName") %></h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Username</th>
                    <th>Payment</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Retrieve eventName from the request
                    String eventName = request.getParameter("eventName");
                    String jdbcURL = "jdbc:mysql://localhost:3306/eventmangmentsytem";
                    String dbUser = "root";
                    String dbPassword = "root";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        // Replace spaces or special characters in eventName for table naming
                        String sanitizedEventName = eventName.replaceAll("\\s+", "").toLowerCase();

                        // Construct table name dynamically
                        String tableName = "event_" + sanitizedEventName + "_participants";

                        // Query to fetch participant details
                        String sql = "SELECT id, name, email, phone, username, payment FROM " + tableName;
                        PreparedStatement statement = connection.prepareStatement(sql);
                        ResultSet resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            int id = resultSet.getInt("id");
                            String name = resultSet.getString("name");
                            String email = resultSet.getString("email");
                            String phone = resultSet.getString("phone");
                            String username = resultSet.getString("username");
                            String payment = resultSet.getString("payment");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= email %></td>
                    <td><%= phone %></td>
                    <td><%= username %></td>
                    <td><%= payment %></td>
                </tr>
                <%
                        }
                        connection.close();
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6'>Unexpected Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </main>
</body>
</html>
