<%-- File: WebContent/reservationdelete.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cancel Reservation</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #e53e3e, #c53030);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .header h1 { font-size: 1.8em; }
        .form-container { padding: 30px; }
        .form-group { margin-bottom: 25px; }
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
        .btn {
            width: 100%;
            padding: 14px;
            background: #e53e3e;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn:hover { background: #c53030; }
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
        .warning {
            background: #fef5e7;
            border-left: 4px solid #e53e3e;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            color: #744210;
        }
    </style>
    <script>
        function confirmDelete() {
            let id = document.getElementById("reservationId").value;
            if (!id) {
                alert("Please enter a Reservation ID");
                return false;
            }
            return confirm("Are you sure you want to cancel Reservation #" + id + "? This action cannot be undone.");
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>❌ Cancel Reservation</h1>
            <p>Remove an existing booking</p>
        </div>
        <div class="form-container">
            <div class="warning">
                ⚠️ Warning: This action is permanent and cannot be reversed.
            </div>
            
            <% 
                String message = (String) request.getAttribute("message");
                String messageType = (String) request.getAttribute("messageType");
                if (message != null) {
            %>
                <div class="message <%= messageType %>"><%= message %></div>
            <% } %>
            
            <form action="deleteReservation" method="post" onsubmit="return confirmDelete()">
                <div class="form-group">
                    <label>Reservation ID to Cancel *</label>
                    <input type="number" name="reservationId" id="reservationId" required placeholder="Enter Reservation ID" min="1">
                </div>
                <button type="submit" class="btn">🗑️ Cancel Reservation</button>
            </form>
            <div class="back-link">
                <a href="index.jsp">← Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>