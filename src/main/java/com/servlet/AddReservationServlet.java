// File: src/com/servlet/AddReservationServlet.java
package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String message = "";
        String messageType = "error";
        
        try {
            // Input validation
            String idStr = request.getParameter("reservationId");
            String customerName = request.getParameter("customerName");
            String roomNumber = request.getParameter("roomNumber");
            String checkIn = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");
            String amountStr = request.getParameter("totalAmount");
            
            // Validate all fields are present
            if (idStr == null || idStr.trim().isEmpty() ||
                customerName == null || customerName.trim().isEmpty() ||
                roomNumber == null || roomNumber.trim().isEmpty() ||
                checkIn == null || checkIn.trim().isEmpty() ||
                checkOut == null || checkOut.trim().isEmpty() ||
                amountStr == null || amountStr.trim().isEmpty()) {
                message = "All fields are required!";
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);
                request.getRequestDispatcher("reservationadd.jsp").forward(request, response);
                return;
            }
            
            // Validate numeric fields
            int reservationId;
            BigDecimal totalAmount;
            try {
                reservationId = Integer.parseInt(idStr);
                totalAmount = new BigDecimal(amountStr);
                if (reservationId <= 0) {
                    throw new NumberFormatException();
                }
                if (totalAmount.compareTo(BigDecimal.ZERO) < 0) {
                    throw new NumberFormatException();
                }
            } catch (NumberFormatException e) {
                message = "Invalid numeric values! Reservation ID and Total Amount must be positive numbers.";
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);
                request.getRequestDispatcher("reservationadd.jsp").forward(request, response);
                return;
            }
            
            // Validate room number format
            if (!roomNumber.matches("^[1-9][0-9]{0,2}[A-Z]?$")) {
                message = "Invalid room number format! (e.g., 101, 202A)";
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);
                request.getRequestDispatcher("reservationadd.jsp").forward(request, response);
                return;
            }
            
            // Validate customer name (letters and spaces only)
            if (!customerName.matches("^[A-Za-z\\s]{2,100}$")) {
                message = "Customer name must contain only letters and spaces (2-100 characters)!";
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);
                request.getRequestDispatcher("reservationadd.jsp").forward(request, response);
                return;
            }
            
            // Check if reservation ID already exists
            if (reservationDAO.getReservationById(reservationId) != null) {
                message = "Reservation ID already exists! Please use a different ID.";
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);
                request.getRequestDispatcher("reservationadd.jsp").forward(request, response);
                return;
            }
            
            Reservation reservation = new Reservation();
            reservation.setReservationId(reservationId);
            reservation.setCustomerName(customerName);
            reservation.setRoomNumber(roomNumber);
            reservation.setCheckIn(Date.valueOf(checkIn));
            reservation.setCheckOut(Date.valueOf(checkOut));
            reservation.setTotalAmount(totalAmount);
            
            boolean success = reservationDAO.addReservation(reservation);
            
            if (success) {
                message = "Reservation added successfully!";
                messageType = "success";
            } else {
                message = "Failed to add reservation. Please try again.";
            }
            
        } catch (IllegalArgumentException e) {
            message = "Invalid date format! Please use YYYY-MM-DD format.";
        } catch (Exception e) {
            message = "An error occurred: " + e.getMessage();
        }
        
        request.setAttribute("message", message);
        request.setAttribute("messageType", messageType);
        request.getRequestDispatcher("reservationadd.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("reservationadd.jsp").forward(request, response);
    }
}