<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<title>Search Bids</title>


<style>
.back-button {
    position: absolute;
    top: 20px;
    right: 20px;
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
</style>
</head>








<body>
<% String type = session.getAttribute("type").toString();
String redirect = String.format("%sLoginSuccess.jsp", type);%>


<form action="<%= redirect %>">
    <button class="back-button" type="submit">Home</button>
</form>



<h2>Enter vehicle details and price below!</h2>
<form action="intermediate.jsp" method="POST">	
	<label for="make">Make:</label>
	<select name="make" id="make">
		<option value="Toyota">Toyota</option>
		<option value="Honda">Honda</option>
		<option value="Ford">Ford</option>
		<option value="Chevrolet">Chevrolet</option>
		<option value="BMW">BMW</option>
		<option value="Mercedes-Benz">Mercedes-Benz</option>
		<option value="Audi">Audi</option>
		<option value="Volkswagen">Volkswagen</option>
		<option value="Tesla">Tesla</option>
		<option value="Nissan">Nissan</option>
		<option value="Hyundai">Hyundai</option>
		<option value="Kia">Kia</option>
		<option value="Subaru">Subaru</option>
		<option value="Mazda">Mazda</option>
		<option value="Volvo">Volvo</option>
		<option value="Porsche">Porsche</option>
		<option value="Lexus">Lexus</option>
		<option value="Jeep">Jeep</option>
		<option value="Land Rover">Land Rover</option>
		<option value="Ferrari">Ferrari</option>
		<option value="Maserati">Maserati</option>
		<option value="Bentley">Bentley</option>
		<option value="Bugatti">Bugatti</option>
		<option value="McLaren">McLaren</option>
		<option value="Rolls-Royce">Rolls-Royce</option>
		<option value="Aston Martin">Aston Martin</option>
		<option value="Lamborghini">Lamborghini</option>
		<option value="Alfa Romeo">Alfa Romeo</option>
		<option value="Jaguar">Jaguar</option>
		<option value="Dodge">Dodge</option>
		<option value="Chrysler">Chrysler</option>
		<option value="Buick">Buick</option>
		<option value="Cadillac">Cadillac</option>
		<option value="Lincoln">Lincoln</option>
		<option value="GMC">GMC</option>
		<option value="Infiniti">Infiniti</option>
		<option value="Acura">Acura</option>
		<option value="Mercury">Mercury</option>
    </select><br><br>
	
	
	<label for="engine_type">Engine Type:</label>
	<select name="engine_type" id="engine_type">
		<option value="Straight">Straight</option>
		<option value="Inline">Inline</option>
		<option value="V">V</option>
		<option value="Flat">Flat</option>
		<option value="Electric Motor">Electric Motor</option>
	</select><br><br>
	
	<label for="axle_type">Axle Type:</label>
	<select name="axle_type" id="axle_type">
		<option value="AWD">AWD</option>
		<option value="RWD">RWD</option>
		<option value="FWD">FWD</option>
	</select><br><br>
	
	<label for="trans_type">Transmission Type:</label>
	<select name="trans_type" id="trans_type">
		<option value="Automatic">Automatic</option>
		<option value="Manual">Manual</option>
	</select><br><br>
	
	<label for="category">Category:</label>
	<select name="category" id="category">
		<option value="Gas">Gas</option>
		<option value="Hybrid">Hybrid</option>
		<option value="Electric">Electric</option>
	</select><br><br>
	
	<input type="submit" value="Search">
</form>
</body>
</html>
