<%-- File: WebContent/reservationadd.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Reservation</title>
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
        .header p { opacity: 0.9; margin-top: 5px; }
        .form-container { padding: 30px; }
        .form-group { margin-bottom: 20px; }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #4a5568;
        }
        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
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
            transition: opacity 0.3s;
        }
        .btn:hover { opacity: 0.9; }
        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        .message.success {
            background: #c6f6d5;
            color: #22543d;
            border: 1px solid #9ae6b4;
        }
        .message.error {
            background: #fed7d7;
            color: #742a2a;
            border: 1px solid #fc8181;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: #667eea;
            text-decoration: none;
        }
        .back-link a:hover { text-decoration: underline; }
        .hint {
            font-size: 0.85em;
            color: #a0aec0;
            margin-top: 5px;
        }
    </style>
    <script>
        function validateForm() {
            let name = document.forms["addForm"]["customerName"].value;
            let nameRegex = /^[A-Za-z\s]{2,100}$/;
            if (!nameRegex.test(name)) {
                alert("Customer name must contain only letters and spaces (2-100 characters)");
                return false;
            }
            
            let room = document.forms["addForm"]["roomNumber"].value;
            let roomRegex = /^[1-9][0-9]{0,2}[A-Z]?$/;
            if (!roomRegex.test(room)) {
                alert("Invalid room number format! (e.g., 101, 202A)");
                return false;
            }
            
            let id = parseInt(document.forms["addForm"]["reservationId"].value);
            if (id <= 0) {
                alert("Reservation ID must be a positive number");
                return false;
            }
            
            let amount = parseFloat(document.forms["addForm"]["totalAmount"].value);
            if (amount <= 0) {
                alert("Total amount must be greater than 0");
                return false;
            }
            
            let checkIn = document.forms["addForm"]["checkIn"].value;
            let checkOut = document.forms["addForm"]["checkOut"].value;
            if (checkIn > checkOut) {
                alert("Check-Out date must be after Check-In date");
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📝 Add New Reservation</h1>
            <p>Enter customer and booking details</p>
        </div>
        <div class="form-container">
            <% 
                String message = (String) request.getAttribute("message");
                String messageType = (String) request.getAttribute("messageType");
                if (message != null) {
            %>
                <div class="message <%= messageType %>"><%= message %></div>
            <% } %>
            
            <form name="addForm" action="addReservation" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label>Reservation ID *</label>
                    <input type="number" name="reservationId" required placeholder="e.g., 1001" min="1">
                    <div class="hint">Unique numeric identifier (positive number)</div>
                </div>
                <div class="form-group">
                    <label>Customer Name *</label>
                    <input type="text" name="customerName" required placeholder="Full name">
                    <div class="hint">Only letters and spaces (2-100 characters)</div>
                </div>
                <div class="form-group">
                    <label>Room Number *</label>
                    <input type="text" name="roomNumber" required placeholder="e.g., 101, 202A">
                    <div class="hint">Valid format: 101, 202A, 305B</div>
                </div>
                <div class="form-group">
                    <label>Check-In Date *</label>
                    <input type="date" name="checkIn" required>
                </div>
                <div class="form-group">
                    <label>Check-Out Date *</label>
                    <input type="date" name="checkOut" required>
                </div>
                <div class="form-group">
                    <label>Total Amount ($) *</label>
                    <input type="number" step="0.01" name="totalAmount" required placeholder="0.00" min="0.01">
                    <div class="hint">Positive decimal number</div>
                </div>
                <button type="submit" class="btn">➕ Add Reservation</button>
            </form>
            <div class="back-link">
                <a href="index.jsp">← Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>