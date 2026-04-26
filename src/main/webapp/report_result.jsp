<%-- File: WebContent/report_result.jsp (COMPLETE VERSION) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Reservation, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Result</title>
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
        .report-info {
            background: #f7fafc;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }
        .report-title {
            font-size: 1.2em;
            font-weight: bold;
            color: #4a5568;
        }
        .report-title span {
            color: #667eea;
        }
        .total-revenue {
            background: #48bb78;
            color: white;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: bold;
            font-size: 1.1em;
        }
        .btn-group {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 8px 16px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-print { background: #48bb78; }
        .btn-back { background: #718096; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        }
        .room-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .room-card {
            background: #f7fafc;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
        }
        .room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .room-number {
            font-size: 1.8em;
            font-weight: bold;
            color: #667eea;
        }
        .booking-count {
            font-size: 1.2em;
            color: #4a5568;
            margin-top: 10px;
        }
        .booking-count span {
            font-size: 2em;
            font-weight: bold;
            color: #48bb78;
        }
        .revenue-amount {
            font-size: 2em;
            font-weight: bold;
            color: #48bb78;
            text-align: center;
            padding: 30px;
            background: linear-gradient(135deg, #f7fafc, #edf2f7);
            border-radius: 15px;
            margin-top: 20px;
        }
        .back-link {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }
        .error-message {
            background: #fed7d7;
            color: #742a2a;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
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
            <h1>📊 Report Result</h1>
            <p>Generated Report</p>
        </div>
        <div class="content">
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="error-message">❌ <%= error %></div>
            <%
                } else {
                    String reportType = (String) request.getAttribute("reportType");
                    
                    if ("dateRange".equals(reportType)) {
                        String startDate = (String) request.getAttribute("startDate");
                        String endDate = (String) request.getAttribute("endDate");
                        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
                        BigDecimal totalRevenue = (BigDecimal) request.getAttribute("totalRevenue");
            %>
                        <div class="report-info">
                            <div class="report-title">📅 Reservations from <span><%= startDate %></span> to <span><%= endDate %></span></div>
                            <div class="btn-group">
                                <button class="btn btn-print" onclick="window.print()">🖨️ Print</button>
                                <a href="reports.jsp" class="btn btn-back">← Back</a>
                            </div>
                        </div>
                        
                        <% if (totalRevenue != null && totalRevenue.compareTo(BigDecimal.ZERO) > 0) { %>
                            <div class="total-revenue" style="margin-bottom: 20px;">
                                💰 Total Revenue for this period: $<%= totalRevenue %>
                            </div>
                        <% } %>
                        
                        <% if (reservations != null && !reservations.isEmpty()) { %>
                            <table>
                                <thead>
                                    <tr><th>ID</th><th>Customer Name</th><th>Room No</th><th>Check-In</th><th>Check-Out</th><th>Amount</th></tr>
                                </thead>
                                <tbody>
                                    <% for (Reservation r : reservations) { %>
                                        <tr>
                                            <td data-label="ID"><%= r.getReservationId() %></td>
                                            <td data-label="Customer"><%= r.getCustomerName() %></td>
                                            <td data-label="Room"><%= r.getRoomNumber() %></td>
                                            <td data-label="Check-In"><%= r.getCheckIn() %></td>
                                            <td data-label="Check-Out"><%= r.getCheckOut() %></td>
                                            <td data-label="Amount">$<%= r.getTotalAmount() %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        <% } else { %>
                            <div class="error-message">No reservations found in this date range.</div>
                        <% } %>
                        
            <%
                    } else if ("mostBooked".equals(reportType)) {
                        List<Object[]> roomStats = (List<Object[]>) request.getAttribute("roomStats");
            %>
                        <div class="report-info">
                            <div class="report-title">🏆 Most Frequently Booked Rooms</div>
                            <div class="btn-group">
                                <button class="btn btn-print" onclick="window.print()">🖨️ Print</button>
                                <a href="reports.jsp" class="btn btn-back">← Back</a>
                            </div>
                        </div>
                        
                        <% if (roomStats != null && !roomStats.isEmpty()) { %>
                            <div class="room-stats">
                                <% for (Object[] stat : roomStats) { %>
                                    <div class="room-card">
                                        <div class="room-number">Room <%= stat[0] %></div>
                                        <div class="booking-count">Booked <span><%= stat[1] %></span> times</div>
                                    </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <div class="error-message">No booking data available.</div>
                        <% } %>
                        
            <%
                    } else if ("revenue".equals(reportType)) {
                        String startDate = (String) request.getAttribute("startDate");
                        String endDate = (String) request.getAttribute("endDate");
                        BigDecimal revenue = (BigDecimal) request.getAttribute("revenue");
                        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
            %>
                        <div class="report-info">
                            <div class="report-title">💰 Revenue Report: <span><%= startDate %></span> to <span><%= endDate %></span></div>
                            <div class="btn-group">
                                <button class="btn btn-print" onclick="window.print()">🖨️ Print</button>
                                <a href="reports.jsp" class="btn btn-back">← Back</a>
                            </div>
                        </div>
                        
                        <div class="revenue-amount">
                            Total Revenue: $<%= revenue != null ? revenue : "0.00" %>
                        </div>
                        
                        <h3 style="margin: 25px 0 15px 0; color: #4a5568;">📋 Detailed Transactions</h3>
                        
                        <% if (reservations != null && !reservations.isEmpty()) { %>
                            <table>
                                <thead>
                                    <tr><th>ID</th><th>Customer Name</th><th>Room No</th><th>Check-In</th><th>Check-Out</th><th>Amount</th></tr>
                                </thead>
                                <tbody>
                                    <% for (Reservation r : reservations) { %>
                                        <tr>
                                            <td data-label="ID"><%= r.getReservationId() %></td>
                                            <td data-label="Customer"><%= r.getCustomerName() %></td>
                                            <td data-label="Room"><%= r.getRoomNumber() %></td>
                                            <td data-label="Check-In"><%= r.getCheckIn() %></td>
                                            <td data-label="Check-Out"><%= r.getCheckOut() %></td>
                                            <td data-label="Amount">$<%= r.getTotalAmount() %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        <% } else { %>
                            <div class="error-message">No transactions in this period.</div>
                        <% } %>
            <%
                    }
                }
            %>
            
            <div class="back-link">
                <a href="reports.jsp" style="color: #667eea;">← Back to Reports Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>