<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<head>
<title>Answer Question</title>
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
<form action="repFaq.jsp">
    <button class="back-button" type="submit">Back</button>
</form>



<%session.setAttribute("faq_id", request.getParameter("id")); %>
<h2>Answer question below:</h2>
<form action="saveAnswer.jsp" method="POST">
	<label for="answer">Submit answer (no more than 500 characters):</label><br>
	<textarea id="answer" name="answer" cols=50 rows=3></textarea><br><br>
	<input type="submit" value="Add Answer">
</form>
</body>
</html>