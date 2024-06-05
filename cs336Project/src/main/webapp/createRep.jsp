<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import= "java.time.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<title>Create representative</title>

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
 <% if (session.getAttribute("account_error") != null) {%>
 <div><%=session.getAttribute("account_error") %></div>
 <%session.setAttribute("account_error", null);%>
<%} %>


<form action="adminLoginSuccess.jsp">
    <button class="back-button" type="submit">Back</button>
</form>

<h2>Enter their details below!</h2>
<form action="saveAccount.jsp" method="POST">
	<label for="first_name">First Name:</label>
	<input type="text" id="first_name" name="first_name"><br><br>
	<label for="last_name">Last Name:</label>
	<input type="text" id="last_name" name="last_name"><br><br>
	<label for="dob">Date of Birth:</label>
	<input type="date" id="dob" name="dob"><br><br>
	<label for="address">Address:</label>
	<input type="text" id="address" name="address"><br><br>
	<label for="email">Email:</label>
	<input type="text" id="email" name="email"><br><br>
	<label for="password">Password:</label>
	<input type="password" id="password" name="password"><br><br>
	<label for="type">User Type:</label>
	<input type="radio" id="rep" name="type" value="rep" checked>Representative
	<input type="submit" value="Create Account">
</form>
</body>
</html>