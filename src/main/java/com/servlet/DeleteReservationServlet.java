// File: src/com/servlet/DeleteReservationServlet.java
package com.servlet;

import com.dao.ReservationDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String message = "";
        String messageType = "error";
        
        try {
            String idStr = request.getParameter("reservationId");
            
            if (idStr == null || idStr.trim().isEmpty()) {
                message = "Reservation ID is required!";
            } else {
                int reservationId = Integer.parseInt(idStr);
                boolean success = reservationDAO.deleteReservation(reservationId);
                
                if (success) {
                    message = "Reservation cancelled successfully!";
                    messageType = "success";
                } else {
                    message = "Reservation ID not found!";
                }
            }
        } catch (NumberFormatException e) {
            message = "Invalid Reservation ID!";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
        
        request.setAttribute("message", message);
        request.setAttribute("messageType", messageType);
        request.getRequestDispatcher("reservationdelete.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("reservationdelete.jsp").forward(request, response);
    }
}