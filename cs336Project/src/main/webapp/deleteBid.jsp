<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>



<% 
		String vin = session.getAttribute("vin").toString();


		String DBMS_user = "root";
		String DBMS_pass = "root";
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
		Statement st = conn.createStatement();
		
		ResultSet delete_listing;
		
		String sql = "SELECT * FROM listing l JOIN vehicle v on l.vin = v.vin WHERE l.vin=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vin);
		
		delete_listing = pstmt.executeQuery();
		delete_listing.next();
		
		
		sql = "DELETE FROM vehicle WHERE vin=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vin);
		int delete_list = pstmt.executeUpdate();
		
		
		session.setAttribute("delete_message", "Auction deleted!");
		response.sendRedirect("repQueryBids.jsp");
		pstmt.close();
	    conn.close();
		
%>