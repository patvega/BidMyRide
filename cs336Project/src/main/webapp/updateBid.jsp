<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.Timestamp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 


		String vin = session.getAttribute("vin").toString();
		String user = session.getAttribute("user_id").toString();
		
		String DBMS_user = "root";
		String DBMS_pass = "root";
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
		Statement st = conn.createStatement();
		
		ResultSet rs;
		
		int newBid = Integer.parseInt(request.getParameter("new_price"));
		
		String sql = "SELECT * FROM listing l JOIN vehicle v on l.vin = v.vin WHERE l.vin=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vin);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		if(newBid < rs.getInt("current_price") + rs.getInt("min_raise")) {
			response.sendRedirect(String.format("displayBid.jsp?id=%s", vin));
			session.setAttribute("update_message", "Bid is not high enough!");
			pstmt.close();
		    conn.close();
		    return;
		}
		
		if((rs.getInt("buyer_id") > 0) && rs.getInt("buyer_id") != Integer.parseInt(user))  {
			sql = "INSERT INTO alerts(user_id, status) VALUES (?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rs.getInt("buyer_id"));
			pstmt.setString(2, "Outbid by another buyer!");
			System.out.println(pstmt);
			int outbid = pstmt.executeUpdate();			
		}
		
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		sql = "UPDATE listing SET buyer_id=?, current_price=?, `current_time`=? WHERE vin=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,Integer.parseInt(user));
		pstmt.setInt(2, newBid);
		pstmt.setTimestamp(3, currentTime);
		pstmt.setString(4, vin);
		int update = pstmt.executeUpdate();
		
		sql = "INSERT INTO bid_history(seller_id, listing_id, amount, time_posted) VALUES (?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, rs.getInt("seller_id"));
		pstmt.setInt(2, rs.getInt("listing_id"));
		pstmt.setInt(3, newBid);
		pstmt.setTimestamp(4, currentTime);
		int history = pstmt.executeUpdate();
		
		response.sendRedirect(String.format("displayBid.jsp?id=%s", vin));
		session.setAttribute("update_message", "Bid updated");
		pstmt.close();
	    conn.close();
%>