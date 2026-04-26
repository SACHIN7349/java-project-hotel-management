// File: src/com/servlet/DisplayReservationsServlet.java
package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/displayReservations")
public class DisplayReservationsServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Reservation> reservations = reservationDAO.getAllReservations();
            request.setAttribute("reservations", reservations);
            request.setAttribute("count", reservations.size());
        } catch (Exception e) {
            request.setAttribute("error", "Error loading reservations: " + e.getMessage());
        }
        
        request.getRequestDispatcher("reservationdisplay.jsp").forward(request, response);
    }
}