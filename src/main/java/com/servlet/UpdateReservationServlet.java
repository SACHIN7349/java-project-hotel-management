// File: src/com/servlet/UpdateReservationServlet.java
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

@WebServlet("/updateReservation")
public class UpdateReservationServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String message = "";
        String messageType = "error";
        
        try {
            String idStr = request.getParameter("reservationId");
            String customerName = request.getParameter("customerName");
            String roomNumber = request.getParameter("roomNumber");
            String checkIn = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");
            String amountStr = request.getParameter("totalAmount");
            
            // Validate all fields
            if (idStr == null || idStr.trim().isEmpty() ||
                customerName == null || customerName.trim().isEmpty() ||
                roomNumber == null || roomNumber.trim().isEmpty() ||
                checkIn == null || checkIn.trim().isEmpty() ||
                checkOut == null || checkOut.trim().isEmpty() ||
                amountStr == null || amountStr.trim().isEmpty()) {
                message = "All fields are required!";
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);
                request.getRequestDispatcher("reservationupdate.jsp").forward(request, response);
                return;
            }
            
            int reservationId = Integer.parseInt(idStr);
            BigDecimal totalAmount = new BigDecimal(amountStr);
            
            if (!customerName.matches("^[A-Za-z\\s]{2,100}$")) {
                message = "Customer name must contain only letters and spaces!";
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);
                request.getRequestDispatcher("reservationupdate.jsp").forward(request, response);
                return;
            }
            
            Reservation reservation = new Reservation();
            reservation.setReservationId(reservationId);
            reservation.setCustomerName(customerName);
            reservation.setRoomNumber(roomNumber);
            reservation.setCheckIn(Date.valueOf(checkIn));
            reservation.setCheckOut(Date.valueOf(checkOut));
            reservation.setTotalAmount(totalAmount);
            
            boolean success = reservationDAO.updateReservation(reservation);
            
            if (success) {
                message = "Reservation updated successfully!";
                messageType = "success";
            } else {
                message = "Reservation ID not found!";
            }
            
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
        
        request.setAttribute("message", message);
        request.setAttribute("messageType", messageType);
        request.getRequestDispatcher("reservationupdate.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null && !id.trim().isEmpty()) {
            try {
                Reservation reservation = reservationDAO.getReservationById(Integer.parseInt(id));
                if (reservation != null) {
                    request.setAttribute("reservation", reservation);
                }
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        request.getRequestDispatcher("reservationupdate.jsp").forward(request, response);
    }
}