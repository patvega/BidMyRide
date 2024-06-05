<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<head>
<Title>Login to VehicleBid!</Title>
</head>

<body>
 
 <% if (session.getAttribute("login_message") != null) { %>
 <div>
     <%=session.getAttribute("login_message") %>
 </div>
 	<%session.setAttribute("login_message", null);%>
<% }  %>
	  

<h2>Enter email and password!</h2>
<form action="verifyCredentials.jsp" method="post">
	<label for="email">email:</label>
	<input type="text" id="email" name="email"><br><br>
	<label for="password">Password:</label>
	<input type="password" id="password" name="password"><br><br>
	<input type="submit" value="login">
</form>
<div style="padding-top: 20px">
Don't have an account? Create one <a href="createAccount.jsp">here</a>
</div>

</body>
</html>
