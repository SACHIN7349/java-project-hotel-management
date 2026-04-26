// File: src/com/servlet/ReportCriteriaServlet.java (COMPLETE VERSION)
package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/reportCriteria")
public class ReportCriteriaServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String type = request.getParameter("type");
        String report = request.getParameter("report");
        
        System.out.println("ReportCriteriaServlet doGet - type: " + type + ", report: " + report);
        
        if ("form".equals(type)) {
            // Forward to the form page
            if ("dateRange".equals(report)) {
                request.setAttribute("reportFormType", "dateRange");
                request.setAttribute("formTitle", "Date Range Bookings Report");
                request.setAttribute("formAction", "reportCriteria");
                request.getRequestDispatcher("report_form.jsp").forward(request, response);
            } else if ("revenue".equals(report)) {
                request.setAttribute("reportFormType", "revenue");
                request.setAttribute("formTitle", "Revenue Analysis Report");
                request.setAttribute("formAction", "reportCriteria");
                request.getRequestDispatcher("report_form.jsp").forward(request, response);
            } else {
                response.sendRedirect("reports.jsp");
            }
        } else if ("mostBooked".equals(type)) {
            // Direct report generation for most booked rooms
            try {
                List<Object[]> roomStats = reservationDAO.getMostBookedRooms();
                request.setAttribute("roomStats", roomStats);
                request.setAttribute("reportType", "mostBooked");
                request.getRequestDispatcher("report_result.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error generating report: " + e.getMessage());
                request.getRequestDispatcher("report_result.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("reports.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        
        System.out.println("ReportCriteriaServlet doPost - reportType: " + reportType);
        
        try {
            if ("dateRange".equals(reportType)) {
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                
                System.out.println("Date range report - startDate: " + startDate + ", endDate: " + endDate);
                
                // Validation
                if (startDate == null || startDate.trim().isEmpty() ||
                    endDate == null || endDate.trim().isEmpty()) {
                    request.setAttribute("message", "Both start and end dates are required!");
                    request.setAttribute("reportFormType", "dateRange");
                    request.setAttribute("formTitle", "Date Range Bookings Report");
                    request.getRequestDispatcher("report_form.jsp").forward(request, response);
                    return;
                }
                
                List<Reservation> reservations = reservationDAO.getReservationsByDateRange(startDate, endDate);
                BigDecimal totalRevenue = reservationDAO.getTotalRevenue(startDate, endDate);
                
                request.setAttribute("reservations", reservations);
                request.setAttribute("totalRevenue", totalRevenue);
                request.setAttribute("startDate", startDate);
                request.setAttribute("endDate", endDate);
                request.setAttribute("reportType", "dateRange");
                request.getRequestDispatcher("report_result.jsp").forward(request, response);
                
            } else if ("revenue".equals(reportType)) {
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                
                System.out.println("Revenue report - startDate: " + startDate + ", endDate: " + endDate);
                
                if (startDate == null || startDate.trim().isEmpty() ||
                    endDate == null || endDate.trim().isEmpty()) {
                    request.setAttribute("message", "Both start and end dates are required!");
                    request.setAttribute("reportFormType", "revenue");
                    request.setAttribute("formTitle", "Revenue Analysis Report");
                    request.getRequestDispatcher("report_form.jsp").forward(request, response);
                    return;
                }
                
                BigDecimal revenue = reservationDAO.getTotalRevenue(startDate, endDate);
                List<Reservation> reservations = reservationDAO.getReservationsByDateRange(startDate, endDate);
                
                request.setAttribute("revenue", revenue);
                request.setAttribute("reservations", reservations);
                request.setAttribute("startDate", startDate);
                request.setAttribute("endDate", endDate);
                request.setAttribute("reportType", "revenue");
                request.getRequestDispatcher("report_result.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("report_result.jsp").forward(request, response);
        }
    }
}