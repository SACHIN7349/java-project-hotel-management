<%-- File: WebContent/index.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            padding: 40px 20px;
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        .header h1 {
            font-size: 2.5em;
            color: #4a5568;
            margin-bottom: 10px;
        }
        
        .header p {
            color: #718096;
            font-size: 1.1em;
        }
        
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-card .number {
            font-size: 2.5em;
            font-weight: bold;
            color: #667eea;
        }
        
        .stat-card .label {
            color: #718096;
            margin-top: 10px;
        }
        
        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }
        
        .card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        
        .card-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
            font-size: 1.2em;
            font-weight: bold;
        }
        
        .card-body {
            padding: 25px;
        }
        
        .card-body p {
            color: #718096;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: opacity 0.3s;
            border: none;
            cursor: pointer;
            font-size: 1em;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
        
        .btn-secondary {
            background: #48bb78;
        }
        
        .footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            color: white;
        }
        
        @media (max-width: 768px) {
            .header h1 { font-size: 1.8em; }
            .dashboard { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏨 Hotel Management System</h1>
            <p>Efficiently manage reservations, rooms, and billing</p>
        </div>
        
        <div class="stats">
            <div class="stat-card">
                <div class="number">4+</div>
                <div class="label">Management Modules</div>
            </div>
            <div class="stat-card">
                <div class="number">3</div>
                <div class="label">Report Types</div>
            </div>
            <div class="stat-card">
                <div class="number">24/7</div>
                <div class="label">Availability</div>
            </div>
        </div>
        
        <div class="dashboard">
            <div class="card">
                <div class="card-header">📝 Add New Reservation</div>
                <div class="card-body">
                    <p>Create a new booking for a customer. Enter customer details, room number, check-in/out dates, and total amount.</p>
                    <a href="addReservation" class="btn">Add Reservation →</a>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">✏️ Update Booking</div>
                <div class="card-body">
                    <p>Modify existing reservation details including dates, room number, or customer information.</p>
                    <a href="updateReservation" class="btn">Update Reservation →</a>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">❌ Cancel Reservation</div>
                <div class="card-body">
                    <p>Cancel an existing booking by providing the reservation ID.</p>
                    <a href="deleteReservation" class="btn btn-secondary">Cancel Reservation →</a>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">📋 View All Reservations</div>
                <div class="card-body">
                    <p>Display complete list of all current and past reservations in the system.</p>
                    <a href="displayReservations" class="btn">View All →</a>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">📊 Reports & Analytics</div>
                <div class="card-body">
                    <p>Generate detailed reports: date range bookings, most booked rooms, and revenue analysis.</p>
                    <a href="reports.jsp" class="btn">Generate Reports →</a>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p>Hotel Management System © 2024 | Secure & Reliable</p>
        </div>
    </div>
</body>
</html>