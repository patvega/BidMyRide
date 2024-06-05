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
<%String currentURL = request.getRequestURL().toString(); 
session.setAttribute("prev_url", currentURL);%>

<form action="searchBids.jsp">
    <button class="back-button" type="submit">Back</button>
</form>


	<h2>Results</h2>
			<ul style="list-style-type: none;">
<% 

				String DBMS_user = "root";
				String DBMS_pass = "root";
				
				
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
				Statement st = conn.createStatement();
				
				String make = request.getParameter("make");
				String engine_type = request.getParameter("engine_type");
				String axle_type = request.getParameter("axle_type");
				String trans_type = request.getParameter("trans_type");
				String category = request.getParameter("category");
				String type = request.getParameter("type");
				String sort_type = request.getParameter("sort");
				
				System.out.println(make);
				System.out.println(engine_type);
				System.out.println(axle_type);
				System.out.println(trans_type);
				System.out.println(category);
				System.out.println(type);
				System.out.println(sort_type);
				
				String sort_url = String.format("queryBids.jsp?make=%s&engine_type=%s&axle_type=%s&trans_type=%s&category=%s", make, engine_type, axle_type, trans_type, category);
				
				ResultSet rs;
				
				String sort = "";
				if(type != null) {
					sort = String.format(" ORDER BY %s %s", type, sort_type);
				}
				System.out.println(sort);
				String sql = "SELECT * FROM listing l JOIN vehicle v on l.vin = v.vin WHERE v.make=? AND v.engine_type=? AND v.axle_type=? AND trans_type=? AND v.category=?" + sort;
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, make);
				pstmt.setString(2, engine_type);
				pstmt.setString(3, axle_type);
				pstmt.setString(4, trans_type);
				pstmt.setString(5, category);
				
				rs = pstmt.executeQuery();
				
				if(rs.next() == false) { %>
				<div class="container">
			        <h1>No results!</h1>
			    </div>
			<%	} 
				
				rs.previous();
				while(rs.next()) { %>
				<%String url = String.format("displayBid.jsp?id=%s", rs.getString("vin")); %>
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
				<% } %>
		</ul>
		
	<div style="position: absolute; top: 0; right: 0; margin-top: 20px; margin-right: 175px;">
		<form action="<%=sort_url %>" method="POST">
			<label for="type">Category:
				<select name="type" id="type">
				<option value="initial_price">Price</option>
				<option value="current_time">Time Posted</option>
				<option value="year">Year</option>
				<option value="miles">Miles</option>
				</select>
			</label>
			
			<label for="sort">Sort:
				<select name="sort" id="sort">
				<option value="ASC">Ascending</option>
				<option value="DESC">Descending</option>
				</select>
			</label>
			<input type="submit" value="Sort">
		</form>
	</div>
	
	

<%
pstmt.close();
conn.close();
%>


</body>
</html>