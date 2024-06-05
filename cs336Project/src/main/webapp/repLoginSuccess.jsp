<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<Title>VehicleBid</Title>
  <style>
       .banner {
            background-color: #3498db;
            color: #fff;
            padding: 6px;
            text-align: left;
            display: flex;
            justify-content: end;
            align-items: center;
        }
        

        .notification-icon {
            margin-right: 10px; /* Adjust margin to move the icon closer to the right */
        }

        .notification-icon img {
            width: 30px; /* Adjust size as needed */
            height: 30px; /* Adjust size as needed */
            cursor: pointer;
            background: transparent;
        }

        .logout-button {
            margin-right: 10px; /* Adjust margin to move the button closer to the right */
        }

        .center-buttons {
            text-align: center;
            margin-top: 50px;
        }

        .center-buttons button {
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
  </style>
</head>

<body>
<div class="banner">
<h1 style="margin-right: auto">VehicleBids</h1>   
	<div class="logout-button">
	<form action="logout.jsp">
		<input type="submit" value="Log Out">
	</form>
	</div>

</div>



<h2>Welcome Representative <%=session.getAttribute("first_name") %> </h2>

<div class="center-buttons">

<button type="button" onclick="location.href='queryUsers.jsp';">Edit Accounts</button>
<button type="button" onclick="location.href='repQueryBids.jsp';">Edit Bids</button>
<button type="button" onclick="location.href='repFaq.jsp';">Questions</button>
</div>


</body>
</html>