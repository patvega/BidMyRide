<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<head>
<title>Users</title>
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


 <% if (session.getAttribute("update_message") != null) {%>
 <div><%=session.getAttribute("update_message") %></div>
 <%session.setAttribute("update_message", null);%>
<%} %>


<form action="repLoginSuccess.jsp">
    <button class="back-button" type="submit">Back</button>
</form>


<%
	
	String DBMS_user = "root";
	String DBMS_pass = "root";
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
	Statement st = conn.createStatement();
	
	ResultSet rs;
	
	String sql = "SELECT * FROM user WHERE user_type IN ('buyer', 'seller');";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

%>



<form action="editAccount.jsp" method="POST">
	<label for="user">Select User:</label>
	<select name="user" id="user">

	<% while(rs.next()) { %>
		<option value="<%=rs.getInt("user_id") %>">User <%=rs.getInt("user_id")%>: <%=rs.getString("first_name") %> <%=rs.getString("last_name") %></option>
	<% } %>
	</select>
	<input type="submit" value="Select User">
</form>

</body>
<% 
pstmt.close();
conn.close(); 
%>
</html>