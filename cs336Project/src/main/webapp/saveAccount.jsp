<%@ page language="java" contentType="text/html; chaemail_checket=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date" %>

<% 
	String DBMS_user = "root";
	String DBMS_pass = "root";
	
	
	
	
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
	
	//checking for repeat email
	ResultSet email_check;
	
	String sql = "SELECT * FROM user WHERE email=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, email);
	email_check = pstmt.executeQuery();
	
	
	
	if(email_check.next()) {
		response.sendRedirect("createAccount.jsp");
		session.setAttribute("account_error", "Email is already in use!");
		return;
	}
	
	if(password.length() > 20) {
		response.sendRedirect("createAccount.jsp");
		session.setAttribute("account_error", "Account creation failed, password is too long!");
		return;
	}
	
	//now creating the account 
	ResultSet account_create;
	
	sql = "INSERT INTO user(first_name, last_name, email, password, address, user_type, dob) VALUES (?,?,?,?,?,?, str_to_date(?, '%Y-%m-%d'))";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, f_name);
	pstmt.setString(2, l_name);
	pstmt.setString(3, email);
	pstmt.setString(4, password);
	pstmt.setString(5, address);
	pstmt.setString(6, type);
	pstmt.setString(7, dob);
	int result = pstmt.executeUpdate();
	
	
	if(result > 0) {
		session.setAttribute("login_message", "Account created successfully!");
		response.sendRedirect("login.jsp");
	} else {
		response.sendRedirect("createAccount.jsp");
		session.setAttribute("account_error", "Error with creating account and these details!");
	}
	
    pstmt.close();
    conn.close();
%>