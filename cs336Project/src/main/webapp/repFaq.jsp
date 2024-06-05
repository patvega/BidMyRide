<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<head>
<title>FAQ</title>
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

.details {
    margin-top: 20px;
    text-align: left;
}

.details p {
    margin: 5px 0;
}
</style>

</head>


<body>
<form action="repLoginSuccess.jsp">
    <button class="back-button" type="submit">Home</button>
</form>

 <% if (session.getAttribute("answer_error") != null) {%>
 <div><%=session.getAttribute("answer_error") %></div>
 <%session.setAttribute("answer_error", null);%>
<%} %>



	<h2>Frequently Asked Questions:</h2>
			<ul style="list-style-type: none;">

<% 

		String DBMS_user = "root";
		String DBMS_pass = "root";
		
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
		Statement st = conn.createStatement();
		
		ResultSet rs;
		
		String sql = "SELECT * FROM faq";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();


		while(rs.next()) { %>
			<%String url = String.format("answerQuestion.jsp?id=%s", rs.getInt("faq_id")); %>
			<li style="width: 50%; margin: 50px auto; padding: 10px; border: 1px solid #ccc; border-radius: 5px; background-color: #f9f9f9; text-align: left;">
			<div class="details">
			<a href="<%=url %>" style="text-decoration:none; color: black;">
				    <p> Posted by user <%=rs.getInt("user_id") %></p> 
				    <p> Question: <%= rs.getString("question") %> </p>
				    <p> Answer: <%= rs.getString("answer") %> </p>
				    <p> Posted: <%= rs.getTimestamp("time_posted") %> </p>
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