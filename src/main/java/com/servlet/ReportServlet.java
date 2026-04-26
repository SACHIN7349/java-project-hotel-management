// File: src/com/servlet/ReportServlet.java
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

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        String message = "";
        
        try {
            if ("dateRange".equals(reportType)) {
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                
                if (startDate == null || startDate.trim().isEmpty() ||
                    endDate == null || endDate.trim().isEmpty()) {
                    message = "Please enter both start and end dates.";
                    request.setAttribute("message", message);
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
                
            } else if ("mostBooked".equals(reportType)) {
                List<Object[]> roomStats = reservationDAO.getMostBookedRooms();
                request.setAttribute("roomStats", roomStats);
                request.setAttribute("reportType", "mostBooked");
                
            } else if ("revenue".equals(reportType)) {
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                
                if (startDate == null || startDate.trim().isEmpty() ||
                    endDate == null || endDate.trim().isEmpty()) {
                    message = "Please enter both start and end dates.";
                    request.setAttribute("message", message);
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
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating report: " + e.getMessage());
        }
        
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("report_form.jsp").forward(request, response);
    }
}