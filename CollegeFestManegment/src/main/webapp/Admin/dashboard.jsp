<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }
        header {
            background-color: #3A3F58; /* Darker and more professional color */
            color: white;
            padding: 1em 0;
            text-align: center;
        }
        main {
            padding: 2em;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        main p {
            font-size: 1.2em;
            margin-bottom: 1.5em;
        }
        ul {
            list-style: none;
            padding: 0;
            display: flex;
            flex-wrap: wrap;
            gap: 1em;
            justify-content: center; /* Center-align buttons */
        }
        ul li {
            margin: 0;
        }
        ul a {
            text-decoration: none;
            color: white;
            font-weight: bold;
            background-color: #4CAF50; /* Green buttons */
            padding: 0.7em 1.5em;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s, transform 0.2s;
            display: inline-block;
        }
        ul a:hover {
            background-color: #388E3C;
            transform: translateY(-3px); /* Subtle hover effect */
        }
        footer {
            background-color: #3A3F58;
            color: white;
            text-align: center;
            padding: 1em 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <header>
        <h1>Admin Dashboard</h1>
    </header>
    <main>
        <p>Welcome, Admin!</p>
        <ul>
            <li><a href="addevent.jsp">Add Event</a></li>
            <li><a href="showevent.jsp">Show Events</a></li>
            <li><a href="login.jsp">Logout</a></li>
        </ul>
    </main>
    <footer>
        <p>&copy; 2024 College Fest Management System. All rights reserved.</p>
    </footer>
</body>
</html>
