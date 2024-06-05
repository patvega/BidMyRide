<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<head>
<title>Alerts</title>
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

<% String type = session.getAttribute("type").toString();
String redirect = String.format("%sLoginSuccess.jsp", type);%>

<form action="<%= redirect %>">
    <button class="back-button" type="submit">Home</button>
</form>


<ul>

	<% 
		String user = session.getAttribute("user_id").toString();
		
		String DBMS_user = "root";
		String DBMS_pass = "root";
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
		Statement st = conn.createStatement();
		
		ResultSet rs;
		
		String sql = "SELECT * FROM alerts WHERE user_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(user));
		rs = pstmt.executeQuery();
		
		if(rs.next() == false) { %>
		<div class="container">
	        <h1>You have no alerts!</h1>
	    </div>
	<%	} 
		
		rs.previous();
		while(rs.next()) { %>
			<li style="width: 50%; margin: 50px auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px; background-color: #f9f9f9; text-align: left;"><%= rs.getString("status") %></li>
		<% } %>
		
		<% 
		
		sql = "DELETE FROM alerts WHERE user_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(user));
		int delete = pstmt.executeUpdate();
		
		pstmt.close();
	    conn.close(); 
	       
	    
	    %>

</ul>
</body>
</html>