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
		
		ResultSet rs;
		ResultSet rs2;
		
		String sql = "SELECT * FROM listing l JOIN vehicle v on l.vin = v.vin WHERE l.vin=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vin);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		
		if(rs.getInt("reserve_price") > rs.getInt("current_price")) {
			sql = "INSERT INTO alerts(user_id, status) VALUES (?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rs.getInt("buyer_id"));
			pstmt.setString(2, "Lost bid, not higher than reserve price");
			int expire = pstmt.executeUpdate();
			
			
			sql = "DELETE FROM bid_history WHERE listing_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rs.getInt("listing_id"));
			int delete_list = pstmt.executeUpdate();
			
			sql = "DELETE FROM listing WHERE listing_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rs.getInt("listing_id"));
			delete_list = pstmt.executeUpdate();
			
			sql = "DELETE FROM vehicle WHERE vin=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vin);
			delete_list = pstmt.executeUpdate();
			
			
		} else {
			sql = "INSERT INTO alerts(user_id, status) VALUES (?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rs.getInt("buyer_id"));
			pstmt.setString(2, "Won bid on listing " + rs.getInt("listing_id"));
			int expire = pstmt.executeUpdate();
			
			sql = "INSERT INTO sold(buyer_id, seller_id, final_price, vin) VALUES (?,?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rs.getInt("buyer_id"));
			pstmt.setInt(2, rs.getInt("seller_id"));
			pstmt.setInt(3, rs.getInt("current_price"));
			pstmt.setString(4, rs.getString("vin"));
			int sell = pstmt.executeUpdate();
			
			
			sql = "DELETE FROM bid_history WHERE listing_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rs.getInt("listing_id"));
			int delete_list = pstmt.executeUpdate();
			
			
			
			sql = "DELETE FROM listing WHERE listing_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rs.getInt("listing_id"));
			delete_list = pstmt.executeUpdate();
		}


		response.sendRedirect("myBids.jsp");
		pstmt.close();
	    conn.close();

%>