<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<head>
<Title>My Bids</Title>

<style>
    /* back button style */
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
    
    ul {
  	    list-style-type: none;
    }
    
    .container {
        height: 50%;
        padding: 250px 0;
        text-align: center;
    }

    h1 {
        font-size: 2rem;
     } 

    
</style>
</head>



<body>
<%String currentURL = request.getRequestURL().toString(); 
session.setAttribute("prev_url", currentURL);%>


<% String type = session.getAttribute("type").toString();
String redirect = String.format("%sLoginSuccess.jsp", type);%>

<form action="<%= redirect %>">
    <button class="back-button" type="submit">Home</button>
</form>

<ul>

<%  String DBMS_user = "root"; 
	String DBMS_pass = "root";
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
	Statement st = conn.createStatement(); 
	
	
	ResultSet rs;
	String user_id = session.getAttribute("user_id").toString();
	
	String sql = String.format("SELECT * FROM listing WHERE %s_id=?", type);
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(user_id));
	
	rs = pstmt.executeQuery();
	
	if(rs.next() == false) { %>
	<div class="container">
        <h1>You have no bids!</h1>
    </div>
<%	} 
	
	rs.previous();
	while(rs.next()) { %>
	<%String url = String.format("displayBid.jsp?id=%s", rs.getString("vin")); %>
		<li><a href="<%=url %>"><%= rs.getString("vin") %></a></li>
	<% } %>
	
	<% pstmt.close();
    conn.close(); %>
	
</ul>
</body>
</html>