<%-- File: WebContent/reports.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        .header {
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }
        .header h1 { font-size: 2.5em; margin-bottom: 10px; }
        .report-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }
        .report-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transition: transform 0.3s;
        }
        .report-card:hover { transform: translateY(-5px); }
        .report-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
            font-size: 1.3em;
            font-weight: bold;
            text-align: center;
        }
        .report-body { padding: 25px; }
        .report-body p { color: #718096; margin-bottom: 20px; line-height: 1.6; }
        .btn {
            display: inline-block;
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }
        .back-link { text-align: center; margin-top: 40px; }
        .back-link a { color: white; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Reports & Analytics</h1>
            <p>Generate insightful reports for hotel management</p>
        </div>
        
        <div class="report-grid">
            <div class="report-card">
                <div class="report-header">📅 Date Range Bookings</div>
                <div class="report-body">
                    <p>View all reservations within a specific period. Get detailed list of customers, rooms, and amounts.</p>
                    <a href="reportCriteria?type=form&report=dateRange" class="btn">Generate Report →</a>
                </div>
            </div>
            
            <div class="report-card">
                <div class="report-header">🏆 Most Booked Rooms</div>
                <div class="report-body">
                    <p>Identify the most popular rooms based on booking frequency. Helps in pricing and maintenance decisions.</p>
                    <a href="reportCriteria?type=mostBooked" class="btn">Generate Report →</a>
                </div>
            </div>
            
            <div class="report-card">
                <div class="report-header">💰 Revenue Analysis</div>
                <div class="report-body">
                    <p>Calculate total revenue generated over a selected date range. Track financial performance.</p>
                    <a href="reportCriteria?type=form&report=revenue" class="btn">Generate Report →</a>
                </div>
            </div>
        </div>
        
        <div class="back-link">
            <a href="index.jsp">← Back to Dashboard</a>
        </div>
    </div>
</body>
</html>