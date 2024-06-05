<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String DBMS_user = "root";
	String DBMS_pass = "root";
	

	
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
	Statement st = conn.createStatement();
	
	ResultSet rs;
	
	String sql = "SELECT * FROM user WHERE email=? AND password=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, email);
	pstmt.setString(2, password);
	rs = pstmt.executeQuery();
	
	if(rs.next()) {
		session.setAttribute("first_name", rs.getString("first_name"));
		session.setAttribute("user_id", Integer.toString(rs.getInt("user_id")));
		System.out.println(rs.getInt("user_id"));
		String type = rs.getString("user_type");
		session.setAttribute("type", type);
		response.sendRedirect(String.format("%sLoginSuccess.jsp", type));
	} else {
		response.sendRedirect("login.jsp");
		session.setAttribute("login_message", "Email and password combination does not exist, try again!");
	}


    pstmt.close();
    conn.close();
%>

