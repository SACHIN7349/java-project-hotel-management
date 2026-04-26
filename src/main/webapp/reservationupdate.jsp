<%-- File: WebContent/reservationupdate.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Reservation</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .header h1 { font-size: 1.8em; }
        .form-container { padding: 30px; }
        .form-group { margin-bottom: 20px; }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #4a5568;
        }
        input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1em;
        }
        input:focus {
            outline: none;
            border-color: #667eea;
        }
        .btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
        }
        .btn:hover { opacity: 0.9; }
        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        .message.success { background: #c6f6d5; color: #22543d; }
        .message.error { background: #fed7d7; color: #742a2a; }
        .back-link { text-align: center; margin-top: 20px; }
        .back-link a { color: #667eea; text-decoration: none; }
        .search-section {
            background: #f7fafc;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
        }
        .search-btn {
            background: #48bb78;
            margin-top: 10px;
        }
        hr { margin: 20px 0; border: none; border-top: 1px solid #e2e8f0; }
    </style>
    <script>
        function loadReservation() {
            let id = document.getElementById("searchId").value;
            if (id) {
                window.location.href = "updateReservation?id=" + id;
            } else {
                alert("Please enter a Reservation ID");
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✏️ Update Reservation</h1>
            <p>Modify existing booking details</p>
        </div>
        <div class="form-container">
            <div class="search-section">
                <label>Search Reservation by ID:</label>
                <input type="number" id="searchId" placeholder="Enter Reservation ID">
                <button onclick="loadReservation()" class="btn search-btn">🔍 Load Reservation</button>
            </div>
            
            <% if (request.getAttribute("reservation") != null) { 
                Reservation r = (Reservation) request.getAttribute("reservation");
            %>
                <hr>
                <% 
                    String message = (String) request.getAttribute("message");
                    String messageType = (String) request.getAttribute("messageType");
                    if (message != null) {
                %>
                    <div class="message <%= messageType %>"><%= message %></div>
                <% } %>
                
                <form action="updateReservation" method="post">
                    <div class="form-group">
                        <label>Reservation ID</label>
                        <input type="text" name="reservationId" value="<%= r.getReservationId() %>" readonly style="background:#edf2f7">
                    </div>
                    <div class="form-group">
                        <label>Customer Name *</label>
                        <input type="text" name="customerName" value="<%= r.getCustomerName() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Room Number *</label>
                        <input type="text" name="roomNumber" value="<%= r.getRoomNumber() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Check-In Date *</label>
                        <input type="date" name="checkIn" value="<%= r.getCheckIn() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Check-Out Date *</label>
                        <input type="date" name="checkOut" value="<%= r.getCheckOut() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Total Amount ($) *</label>
                        <input type="number" step="0.01" name="totalAmount" value="<%= r.getTotalAmount() %>" required>
                    </div>
                    <button type="submit" class="btn">💾 Update Reservation</button>
                </form>
            <% } else if (request.getAttribute("message") == null) { %>
                <p style="text-align: center; color: #718096; margin-top: 20px;">Enter a Reservation ID above to load details for editing.</p>
            <% } %>
            
            <div class="back-link">
                <a href="index.jsp">← Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>