<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import= "java.io.*,java.util.*" %>
<%
session.invalidate();
response.sendRedirect("login.jsp");
 
%>