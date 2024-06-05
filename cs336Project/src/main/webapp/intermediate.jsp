<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
















<%

String make = request.getParameter("make");
String engine_type = request.getParameter("engine_type");
String axle_type = request.getParameter("axle_type");
String trans_type = request.getParameter("trans_type");
String category = request.getParameter("category");




String url = String.format("queryBids.jsp?make=%s&engine_type=%s&axle_type=%s&trans_type=%s&category=%s", make, engine_type, axle_type, trans_type, category);
response.sendRedirect(url);




%>