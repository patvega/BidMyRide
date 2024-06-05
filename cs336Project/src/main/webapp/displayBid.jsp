<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 

	String vin = request.getParameter("id");
	session.setAttribute("vin", vin);

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
	
	//bid history
	sql = "SELECT * FROM bid_history WHERE listing_id=? ORDER BY time_posted;";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, rs.getInt("listing_id"));
	rs2 = pstmt.executeQuery();
	
	

%>
<head>
<title>Bid</title>


<style>
body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

.container {
    width: 80%;
    margin: 50px auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 10px;
    background-color: #f9f9f9;
    text-align: center;
}

h2 {
    color: #333;
}

.details {
    margin-top: 20px;
    text-align: left;
}

.details p {
    margin: 5px 0;
}

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
}
</style>

</head>


<body>

<script>
// Set the date we're counting down to
var countDownDate = <%=rs.getTimestamp("current_time").getTime() %>
var countDownDate = countDownDate + (30 * 60 * 1000) //change the first value to set how many minutes the bid is

// Update the count down every 1 second
var x = setInterval(function() {

  // Get today's date and time
  var now = new Date().getTime();
  
    
  // Find the distance between now and the count down date
  var distance = countDownDate - now;
    
  // Time calculations for days, hours, minutes and seconds
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    
  // Output the result in an element with id="demo"
  document.getElementById("demo").innerHTML = hours + "h "
  + minutes + "m " + seconds + "s ";
    
  // If the count down is over, write some text 
  if (distance < 0) {
    document.getElementById("demo").innerHTML = "EXPIRED";
    window.location.href = 'expireBid.jsp';
  }
}, 1000);
</script>



<%String back = session.getAttribute("prev_url").toString(); %>
<%session.setAttribute("vin", rs.getString("vin"));  %>

 <% if (session.getAttribute("update_message") != null) { %>
 <div>
     <%=session.getAttribute("update_message") %>
 </div>
 	<%session.setAttribute("update_message", null);%>
<% }  %>

<form action="<%=back %>">
    <button class="back-button" type="submit">Back</button>
</form>


<div class="container">
    <h2>Bidding Details</h2>
    <div class="details">
        <p><strong>VIN:</strong> <%= rs.getString("vin") %></p>
        <p><strong>Make:</strong> <%= rs.getString("make") %></p>
        <p><strong>Model:</strong> <%= rs.getString("model") %></p>
        <p><strong>Year:</strong> <%= rs.getInt("year") %></p>
        <p><strong>Miles:</strong> <%= rs.getInt("miles") %></p>
        <p><strong>Engine Type:</strong> <%= rs.getString("engine_type") %></p>
        <p><strong>Axle Type:</strong> <%= rs.getString("axle_type") %></p>
        <p><strong>Category:</strong> <%= rs.getString("category") %></p>
        <p><strong>Transmission Type:</strong> <%= rs.getString("trans_type") %></p>
        <p><strong>Initial Ask:</strong> $<%= rs.getInt("initial_price") %></p>
        <p><strong>Current Ask:</strong> $<%= rs.getInt("current_price") %></p>
        <p>Time Left:</p>
        <p id="demo"></p>
        <p>Bids must be at least $<%=rs.getInt("min_raise") %> over current price! </p>
        <% int seller_id = Integer.parseInt(session.getAttribute("user_id").toString()); %>
        <% if(rs.getInt("seller_id") == seller_id) { %>
        	<p><strong>You cannot bid on your own bid!</strong>
       <%   } else {  %>
            <form action="updateBid.jsp" method="POST">
            
	        <label for="new_price">Bid:</label>
	        <input type="text" id="new_price" name="new_price"><br><br>
	        
	        <p>Bid history:</p>
	        <ul style="list-style-type: none;">
	      <% while(rs2.next()) { %>
				<li><%= rs2.getInt("amount") %>: <%=rs2.getTimestamp("time_posted") %></li>
		<% } %>
	        </ul>
	        <input type="submit" value="Place Bid">
	        
	        </form>
       <%  } %>
    </div>
</div>


<%
pstmt.close();
conn.close();
%>
</body>
</html>