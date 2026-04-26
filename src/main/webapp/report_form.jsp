<%-- File: WebContent/report_form.jsp (COMPLETE VERSION) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String reportFormType = (String) request.getAttribute("reportFormType");
    String formTitle = (String) request.getAttribute("formTitle");
    if (reportFormType == null) {
        reportFormType = request.getParameter("report");
        if ("dateRange".equals(reportFormType)) {
            formTitle = "Date Range Bookings Report";
        } else if ("revenue".equals(reportFormType)) {
            formTitle = "Revenue Analysis Report";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= formTitle != null ? formTitle : "Report Form" %></title>
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
        input {
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
    </style>
    <script>
        function validateForm() {
            var startDate = document.getElementById("startDate").value;
            var endDate = document.getElementById("endDate").value;
            
            if (!startDate || !endDate) {
                alert("Please enter both start and end dates.");
                return false;
            }
            
            if (startDate > endDate) {
                alert("Start date cannot be after end date.");
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>
                <% if ("dateRange".equals(reportFormType)) { %>
                    📅 Date Range Bookings
                <% } else if ("revenue".equals(reportFormType)) { %>
                    💰 Revenue Analysis
                <% } else { %>
                    📊 Report
                <% } %>
            </h1>
            <p>Enter start and end dates</p>
        </div>
        <div class="form-container">
            <% 
                String message = (String) request.getAttribute("message");
                if (message != null) {
            %>
                <div class="message error"><%= message %></div>
            <% } %>
            
            <form action="reportCriteria" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="reportType" value="<%= reportFormType %>">
                
                <div class="form-group">
                    <label>Start Date *</label>
                    <input type="date" id="startDate" name="startDate" required>
                </div>
                
                <div class="form-group">
                    <label>End Date *</label>
                    <input type="date" id="endDate" name="endDate" required>
                </div>
                
                <button type="submit" class="btn">
                    <% if ("dateRange".equals(reportFormType)) { %>
                        📋 Generate Bookings Report
                    <% } else { %>
                        💵 Generate Revenue Report
                    <% } %>
                </button>
            </form>
            
            <div class="back-link">
                <a href="reports.jsp">← Back to Reports Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>