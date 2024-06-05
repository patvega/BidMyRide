<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.Timestamp" %>

<% 
	String DBMS_user = "root";
	String DBMS_pass = "root";
	
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
	Statement st = conn.createStatement();
	
	String vin = request.getParameter("vin");
	String make = request.getParameter("make");
	String model = request.getParameter("model");
	int year = Integer.parseInt(request.getParameter("year"));
	String engine_type = request.getParameter("engine_type");
	String axle_type = request.getParameter("axle_type");
	int miles = Integer.parseInt(request.getParameter("miles"));
	String trans_type = request.getParameter("trans_type");
	String category = request.getParameter("category");
	
	
	int initial_price = Integer.parseInt(request.getParameter("initial_price"));
	int min_raise = Integer.parseInt(request.getParameter("min_price"));
	int reserve_price = Integer.parseInt(request.getParameter("reserve_price"));
	Timestamp currentTime = new Timestamp(System.currentTimeMillis());
	
	
	ResultSet rs;
	
	String sql = "INSERT INTO vehicle(vin, make, model, year, engine_type, axle_type, category, miles, trans_type) VALUES (?,?,?,?,?,?,?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, vin);
	pstmt.setString(2, make);
	pstmt.setString(3, model);
	pstmt.setInt(4, year);
	pstmt.setString(5, engine_type);
	pstmt.setString(6, axle_type);
	pstmt.setString(7, category);
	pstmt.setInt(8, miles);
	pstmt.setString(9, trans_type);
	
	
    try {
    	int result = pstmt.executeUpdate();
    	
    	if(result > 0) {
    		String id = session.getAttribute("user_id").toString();
    		int seller_id = Integer.parseInt(id);
    		sql = "INSERT INTO listing(vin, seller_id, initial_price, current_price, min_raise, reserve_price, `current_time`) VALUES (?,?,?,?,?,?,?)";
    		pstmt = conn.prepareStatement(sql);
    		
    		pstmt.setString(1, vin);
    		pstmt.setInt(2, seller_id);
    		pstmt.setInt(3, initial_price);
    		pstmt.setInt(4, initial_price);
    		pstmt.setInt(5, min_raise);
    		pstmt.setInt(6, reserve_price);
    		pstmt.setTimestamp(7, currentTime);
    		
    		System.out.println(pstmt);
    		
    		int result2 = pstmt.executeUpdate();
    		
    		
    		session.setAttribute("bid_response", "Created bid!");
    		response.sendRedirect("createBids.jsp");
    	    pstmt.close();
    	    conn.close();
    	    return;
    	} 
      } catch (Exception e) {
    	  session.setAttribute("bid_response", "Error with creating bid!");
    	  response.sendRedirect("createBids.jsp");
    	  pstmt.close();
    	  conn.close();
    	  return;
      }
	
	
	
	

%>