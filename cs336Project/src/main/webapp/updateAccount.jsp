<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import= "java.time.*" %>




<% 

		String DBMS_user = "root";
		String DBMS_pass = "root";
		
		int update_user = Integer.parseInt(session.getAttribute("update_user").toString());
		
		
		
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String f_name = request.getParameter("first_name");
		String l_name = request.getParameter("last_name");
		String address = request.getParameter("address");
		String type = request.getParameter("type");
		String dob = request.getParameter("dob");
		
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
		Statement st = conn.createStatement();
		
		ResultSet email_check;
		
		String sql = "SELECT * FROM user WHERE email=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		email_check = pstmt.executeQuery();
		
		
		
		if((email_check.next()) && (update_user != email_check.getInt("user_id"))) {
			response.sendRedirect("queryUsers.jsp");
			session.setAttribute("update_message", "Email is already in use!");
			return;
		}
		email_check.previous();
		
		if(password.length() > 20) {
			response.sendRedirect("queryUsers.jsp");
			session.setAttribute("update_message", "Account creation failed, password is too long!");
			return;
		}

		ResultSet account_update;
		
		sql = "UPDATE user SET email=?, password=?, first_name=?, last_name=?, address=?, dob=str_to_date(?, '%Y-%m-%d') WHERE user_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, password);
		pstmt.setString(3, f_name);
		pstmt.setString(4, l_name);
		pstmt.setString(5, address);
		pstmt.setString(6, dob);
		pstmt.setInt(7, update_user);
		int result = pstmt.executeUpdate();


		response.sendRedirect("queryUsers.jsp");
		session.setAttribute("update_message", "Account updated");
		pstmt.close();
	    conn.close();


%>