<%-- File: WebContent/reservationdisplay.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Reservation" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Reservations</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
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
        .content { padding: 30px; }
        .stats-bar {
            background: #f7fafc;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
        .total-count {
            font-size: 1.2em;
            font-weight: bold;
            color: #4a5568;
        }
        .total-count span {
            color: #667eea;
            font-size: 1.5em;
        }
        .btn-print {
            background: #48bb78;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            background: #667eea;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #e2e8f0;
        }
        tr:hover {
            background: #f7fafc;
        }
        .empty-row td {
            text-align: center;
            padding: 40px;
            color: #a0aec0;
            font-size: 1.1em;
        }
        .back-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }
        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr { display: block; }
            thead tr { display: none; }
            tr { margin-bottom: 15px; border: 1px solid #e2e8f0; border-radius: 10px; }
            td { display: flex; justify-content: space-between; padding: 10px; }
            td:before { content: attr(data-label); font-weight: bold; color: #4a5568; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 All Reservations</h1>
            <p>Complete list of hotel bookings</p>
        </div>
        <div class="content">
            <div class="stats-bar">
                <div class="total-count">Total Reservations: <span><%= request.getAttribute("count") != null ? request.getAttribute("count") : "0" %></span></div>
                <button class="btn-print" onclick="window.print()">🖨️ Print Report</button>
            </div>
            
            <table>
                <thead>
                    <tr><th>ID</th><th>Customer Name</th><th>Room No</th><th>Check-In</th><th>Check-Out</th><th>Total Amount</th></tr>
                </thead>
                <tbody>
                    <%
                        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
                        if (reservations != null && !reservations.isEmpty()) {
                            for (Reservation r : reservations) {
                    %>
                        <tr>
                            <td data-label="ID"><%= r.getReservationId() %></td>
                            <td data-label="Customer"><%= r.getCustomerName() %></td>
                            <td data-label="Room"><%= r.getRoomNumber() %></td>
                            <td data-label="Check-In"><%= r.getCheckIn() %></td>
                            <td data-label="Check-Out"><%= r.getCheckOut() %></td>
                            <td data-label="Amount">$<%= r.getTotalAmount() %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr class="empty-row"><td colspan="6">No reservations found. Add some reservations to see them here.</td></tr>
                    <% } %>
                </tbody>
            </table>
            
            <div class="back-link">
                <a href="index.jsp">← Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>