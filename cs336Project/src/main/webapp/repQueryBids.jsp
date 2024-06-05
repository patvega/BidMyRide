<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<title>Results</title>
<style>
.back-button {
    position: absolute;
    top: 20px;
    right: 20px;
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

.container {
    height: 50%;
    padding: 250px 0;
    text-align: center;
}

h1 {
    font-size: 2rem;
 } 

h2 {
    color: #333;
}

.details {
    margin-top: 20px;
    text-align: left;
}

.details p {
    margin: 5px 0;
}


ul li {
  	list-style-type: none;
}

</style>
</head>


<body>
 <% if (session.getAttribute("delete_message") != null) { %>
 <div>
     <%=session.getAttribute("delete_message") %>
 </div>
 	<%session.setAttribute("delete_message", null);%>
<% }  %>

<%String currentURL = request.getRequestURL().toString(); 
session.setAttribute("prev_url", currentURL);%>

<form action="repLoginSuccess.jsp">
    <button class="back-button" type="submit">Home</button>
</form>

	<h2>Results</h2>
			<ul style="list-style-type: none;">
<% 

				String DBMS_user = "root";
				String DBMS_pass = "root";
				
				
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
				Statement st = conn.createStatement();
				
				ResultSet rs;
				
				String sql = "SELECT * FROM listing l JOIN vehicle v on l.vin = v.vin";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next() == false) { %>
				<div class="container">
			        <h1>No results!</h1>
			    </div>
			<%	} 
				
				rs.previous();
				while(rs.next()) { %>
				<%String url = String.format("repDisplayBid.jsp?id=%s", rs.getString("vin")); %>
					<li style="width: 50%; margin: 50px auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px; background-color: #f9f9f9; text-align: left;">
					<div class="details">
						<a href="<%=url %>" style="text-decoration:none;">
						    <p> VIN: <%= rs.getString("vin") %></p> 
						    <p> Miles: <%= rs.getString("miles") %> </p>
						    <p> Year: <%= rs.getString("year") %> </p>
						    <p> Price: $<%= rs.getString("current_price") %> </p>
						</a>
					</div>	
					</li>
				<% } 

%>
		</ul>

<%
pstmt.close();
conn.close();
%>
</body>
</html>