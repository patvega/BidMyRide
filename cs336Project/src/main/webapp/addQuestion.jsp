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
		
		String question = request.getParameter("question");
		System.out.println(question);
		int user_id = Integer.parseInt(session.getAttribute("user_id").toString());
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		
		ResultSet question_set;
		
		String sql = "INSERT INTO faq(user_id, question, time_posted) VALUES (?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, user_id);
		pstmt.setString(2, question);
		pstmt.setTimestamp(3, currentTime);
		
		try {
	    	int result = pstmt.executeUpdate();
	    	response.sendRedirect("faq.jsp");
	    	pstmt.close();
	    	conn.close();
	    	return;
	      } catch (Exception e) {
	    	  session.setAttribute("question_error", "Too long of a question! Limit is 500 characters");
	    	  response.sendRedirect("faq.jsp");
	    	  pstmt.close();
	    	  conn.close();
	    	  return;
	      }

%>