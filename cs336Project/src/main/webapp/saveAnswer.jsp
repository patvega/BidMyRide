<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>





<%

		String DBMS_user = "root";
		String DBMS_pass = "root";
		
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_auction_project", DBMS_user, DBMS_pass);
		Statement st = conn.createStatement();
		
		String answer = request.getParameter("answer");
		int rep_id = Integer.parseInt(session.getAttribute("user_id").toString());
		int faq_id = Integer.parseInt(session.getAttribute("faq_id").toString());
		ResultSet question_set;
		
		String sql = "UPDATE faq SET rep_id=?, answer=? WHERE faq_id=?;";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, rep_id);
		pstmt.setString(2, answer);
		pstmt.setInt(3, faq_id);
		
		
		try {
	    	int result = pstmt.executeUpdate();
	    	response.sendRedirect("repFaq.jsp");
	    	pstmt.close();
	    	conn.close();
	    	return;
	      } catch (Exception e) {
	    	  session.setAttribute("answer_error", "Too long of an answer! Limit is 500 characters");
	    	  response.sendRedirect("repFaq.jsp");
	    	  pstmt.close();
	    	  conn.close();
	    	  return;
	      }
		
%>