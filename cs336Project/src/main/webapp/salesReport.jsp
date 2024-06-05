<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 

	String DBMS_user = "root";
	String DBMS_pass = "root";
 
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
	Statement st = conn.createStatement();
	
	ResultSet total; 
	ResultSet make;
	ResultSet year;
	ResultSet buyer;
	ResultSet seller;
	
	String sql = "SELECT SUM(final_price) AS total_sales FROM sold";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	total = pstmt.executeQuery();
	total.next();
	
	sql = "SELECT make, SUM(final_price) AS total_sales FROM sold s Join vehicle v on s.vin=v.vin GROUP BY make";
	pstmt = conn.prepareStatement(sql);
	make = pstmt.executeQuery();
	
	sql = "SELECT year, SUM(final_price) AS total_sales FROM sold s Join vehicle v on s.vin=v.vin GROUP BY year";
	pstmt = conn.prepareStatement(sql);
	year = pstmt.executeQuery();
	
	sql= "SELECT buyer_id, SUM(final_price) AS total_sales FROM sold s GROUP BY buyer_id ORDER BY total_sales DESC LIMIT 1";
	pstmt = conn.prepareStatement(sql);
	buyer = pstmt.executeQuery();
	buyer.next();
	
	sql= "SELECT seller_id, SUM(final_price) AS total_sales FROM sold s GROUP BY seller_id ORDER BY total_sales DESC LIMIT 1";
	pstmt = conn.prepareStatement(sql);
	seller = pstmt.executeQuery();
	seller.next();
	

%>
<head>
<title>Bid</title>


<style>
body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

.container {
    width: 80%;
    margin: 50px auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 10px;
    background-color: #f9f9f9;
    text-align: center;
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
</style>

</head>


<body>

<form action="adminLoginSuccess.jsp">
    <button class="back-button" type="submit">Back</button>
</form>


<div class="container">
    <h2>Sales Report</h2>
    <div class="details">
        <p><strong>Total Sales:</strong> $<%= total.getInt("total_sales") %></p>
        <p><strong> Sales by Make:</strong></p>
         <ul style="list-style-type: none;">
	      <% while(make.next()) { %>
				<li><%=make.getString("make") %>: $<%=make.getInt("total_sales") %></li>
		<% } %>
	        </ul>
        
        <p><strong> Sales by Year:</strong></p>
         <ul style="list-style-type: none;">
	      <% while(year.next()) { %>
				<li><%=year.getString("year") %>: $<%=year.getInt("total_sales") %></li>
		<% } %>
	        </ul>
	        
	    <p><strong>Highest Buyer:</strong> User <%= buyer.getInt("buyer_id") %>: $<%=buyer.getInt("total_sales") %></p>
	    <p><strong>Highest Seller:</strong> User <%= seller.getInt("seller_id") %>: $<%=seller.getInt("total_sales") %></p>

    </div>
</div>


<%
pstmt.close();
conn.close();
%>
</body>
</html>