<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Event</title>
    <link rel="stylesheet" href="../css/s1.css">
     <style>
        /* General styling for the body */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #eaf2f8; /* Light blue-gray for a soft and professional look */
            color: #333; /* Dark gray text for readability */
            line-height: 1.6;
        }

        /* Container with background color and shadow */
        .container {
            max-width: 800px;
            margin: 50px auto;
            background: #ffffff; /* White background for a clean look */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            border-radius: 10px; /* Rounded corners for a modern feel */
            overflow: hidden;
            padding: 20px; /* Added padding for spacing */
        }

        /* Header styling */
        header {
            background-color: #005f87; /* Professional deep blue for header */
            color: #ffffff; /* White text for contrast */
            padding: 20px;
            text-align: center;
            font-size: 1.8em;
            font-weight: bold;
            border-bottom: 2px solid #004466; /* Subtle border for separation */
        }

        /* Main form area */
        main {
            padding: 20px;
        }

        /* Form grid layout for labels and inputs */
        form {
            display: grid;
            grid-template-columns: 1fr 2fr; /* Labels take 1/3, inputs take 2/3 */
            gap: 20px 15px; /* Space between rows and columns */
            align-items: center;
        }

        /* Align buttons to span both columns */
        button {
            grid-column: 1 / -1; /* Span across all columns */
            background-color: #005f87; /* Match header for uniformity */
            color: #ffffff;
            border: none;
            padding: 10px 15px;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #003d5c; /* Slightly darker blue on hover */
        }

        /* Label styling */
        label {
            font-weight: bold;
            color: #555;
            text-align: right; /* Align labels to the right for better pairing with inputs */
        }

        /* Input and textarea styling */
        input[type="text"],
        input[type="date"],
        input[type="number"],
        textarea {
            width: 100%; /* Full width inside the allocated grid cell */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: #f9f9f9; /* Light gray for input fields */
            font-size: 1em;
        }

        /* Textarea for description */
        textarea {
            resize: none;
            height: 100px;
        }

        /* Add responsiveness */
        @media (max-width: 600px) {
            .container {
                margin: 20px;
            }

            form {
                grid-template-columns: 1fr; /* Switch to single-column layout on small screens */
            }

            label {
                text-align: left; /* Align labels to the left for mobile view */
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Add Event</h1>
        </header>
        <main>
            <form method="post" action="">
                <label for="eventid">Event ID:</label>
                <input type="number" id="eventId" name="eventId" required>
                <label for="eventName">Event Name:</label>
                <input type="text" id="eventName" name="eventName" required>
                <label for="eventDesc">Description:</label>
                <textarea id="eventDesc" name="eventDesc" required></textarea>
                <label for="eventDate">Date:</label>
                <input type="date" id="eventDate" name="eventDate" required>
                <label for="eventDuration">Duration (in hours):</label>
                <input type="text" id="eventDuration" name="eventDuration" required>
                <label for="totalSeats">Total Available Seats:</label>
                <input type="number" id="totalSeats" name="totalSeats" required>
                <button type="submit">Add Event</button>
            </form>
            <%
                // Database connection parameters
                String url = "jdbc:mysql://localhost:3306/eventmangmentsytem"; // Change "eventmangmentsytem" to your actual database name
                String dbUser = "root"; // Change "root" to your database username
                String dbPassword = "root"; // Change "Deep@143" to your database password

                if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("eventName") != null) {
                    // Retrieve form parameters
                    int eventId = Integer.parseInt(request.getParameter("eventId"));
                    String eventName = request.getParameter("eventName");
                    String eventDesc = request.getParameter("eventDesc");
                    String eventDate = request.getParameter("eventDate");
                    String eventDuration = request.getParameter("eventDuration");
                    int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));
                    int filledSeats = 0;
                    int remainingSeats = totalSeats;

                    Connection con = null;
                    PreparedStatement pstmt = null;
                    Statement stmt = null;

                    try {
                        // Load JDBC driver and establish connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(url, dbUser, dbPassword);

                        // Insert the event details into the events table
                        String insertEventQuery = "INSERT INTO events (eventid, eventName, eventDesc, eventDate, eventDuration, totalSeats, filledSeats, remainingSeats) "
                                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                        pstmt = con.prepareStatement(insertEventQuery);
                        pstmt.setInt(1, eventId);
                        pstmt.setString(2, eventName);
                        pstmt.setString(3, eventDesc);
                        pstmt.setString(4, eventDate);
                        pstmt.setString(5, eventDuration);
                        pstmt.setInt(6, totalSeats);
                        pstmt.setInt(7, filledSeats);
                        pstmt.setInt(8, remainingSeats);
                        pstmt.executeUpdate();
                        
                        // Create the participant table for the event
                        String eventss = eventName.replaceAll("\\s", "").toLowerCase();
                        String participantTableName = "event_" + eventss + "_participants";
                        String createTableQuery = "CREATE TABLE `" + participantTableName + "` ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                                + "name VARCHAR(100), "
                                + "email VARCHAR(100), "
                                + "phone VARCHAR(15), "
                                + "username VARCHAR(50), "
                                + "payment VARCHAR(10) "
                                + ")";
                        
                        stmt = con.createStatement();
                        stmt.executeUpdate(createTableQuery);

                        // Success message and redirection
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Events details have been inserted and participant table created successfully! Redirecting to events list.');");
                        out.println("location='../event/events.jsp';"); // Change to your actual events list page
                        out.println("</script>");
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('JDBC Driver not found.');");
                        out.println("location='addEvent.jsp';");
                        out.println("</script>");
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Database error occurred.');");
                        out.println("location='addEvent.jsp';");
                        out.println("</script>");
                    } finally {
                        try {
                            if (stmt != null) stmt.close();
                            if (pstmt != null) pstmt.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </main>
    </div>
</body>
</html>
