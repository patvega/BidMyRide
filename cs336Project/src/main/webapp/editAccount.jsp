<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import= "java.time.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<title>Edit account</title>
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

</style>
</head>

<body>

<form action="repLoginSuccess.jsp">
    <button class="back-button" type="submit">Home</button>
</form>




<%
	String DBMS_user = "root";
	String DBMS_pass = "root";
	

	
	int user = Integer.parseInt(request.getParameter("user"));
	session.setAttribute("update_user", Integer.toString(user));
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
	Statement st = conn.createStatement();
	
	ResultSet rs;
	
	String sql = "SELECT * FROM user WHERE user_id=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, user);
	rs = pstmt.executeQuery();
	rs.next();
%>

<h2>Edit Account details below! Re-enter any details you won't change</h2>
<form action="updateAccount.jsp" method="POST">
	<label for="first_name">First Name:</label>
	<input type="text" id="first_name" name="first_name" placeholder="<%=rs.getString("first_name") %>"><br><br>
	<label for="last_name">Last Name:</label>
	<input type="text" id="last_name" name="last_name" placeholder="<%=rs.getString("last_name") %>"><br><br>
	<label for="dob">Date of Birth:</label>
	<input type="date" id="dob" name="dob" placeholder="<%=rs.getDate("dob") %>"><br><br>
	<label for="address">Address:</label>
	<input type="text" id="address" name="address" placeholder="<%=rs.getString("address") %>"><br><br>
	<label for="email">Email:</label>
	<input type="text" id="email" name="email" placeholder="<%=rs.getString("email") %>"><br><br>
	<label for="password">Password:</label>
	<input type="password" id="password" name="password" placeholder="<%=rs.getString("password") %>"><br><br>
	<input type="submit" value="Edit Account">
</form>

<%    
pstmt.close();
conn.close(); 
%>

</body>
</html>