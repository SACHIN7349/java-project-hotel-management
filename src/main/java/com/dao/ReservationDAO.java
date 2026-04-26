// File: src/com/dao/ReservationDAO.java
package com.dao;

import com.model.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ReservationDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/hotel_db?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "sachin@18";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Add new reservation
    public boolean addReservation(Reservation reservation) {
        String sql = "INSERT INTO Reservations (ReservationID, CustomerName, RoomNumber, CheckIn, CheckOut, TotalAmount) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reservation.getReservationId());
            pstmt.setString(2, reservation.getCustomerName());
            pstmt.setString(3, reservation.getRoomNumber());
            pstmt.setDate(4, reservation.getCheckIn());
            pstmt.setDate(5, reservation.getCheckOut());
            pstmt.setBigDecimal(6, reservation.getTotalAmount());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update reservation
    public boolean updateReservation(Reservation reservation) {
        String sql = "UPDATE Reservations SET CustomerName=?, RoomNumber=?, CheckIn=?, CheckOut=?, TotalAmount=? WHERE ReservationID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, reservation.getCustomerName());
            pstmt.setString(2, reservation.getRoomNumber());
            pstmt.setDate(3, reservation.getCheckIn());
            pstmt.setDate(4, reservation.getCheckOut());
            pstmt.setBigDecimal(5, reservation.getTotalAmount());
            pstmt.setInt(6, reservation.getReservationId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete reservation
    public boolean deleteReservation(int reservationId) {
        String sql = "DELETE FROM Reservations WHERE ReservationID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reservationId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all reservations
    public List<Reservation> getAllReservations() {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM Reservations ORDER BY CheckIn";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationId(rs.getInt("ReservationID"));
                r.setCustomerName(rs.getString("CustomerName"));
                r.setRoomNumber(rs.getString("RoomNumber"));
                r.setCheckIn(rs.getDate("CheckIn"));
                r.setCheckOut(rs.getDate("CheckOut"));
                r.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                reservations.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservations;
    }

    // Get reservations by date range
    public List<Reservation> getReservationsByDateRange(String startDate, String endDate) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM Reservations WHERE CheckIn >= ? AND CheckOut <= ? ORDER BY CheckIn";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationId(rs.getInt("ReservationID"));
                r.setCustomerName(rs.getString("CustomerName"));
                r.setRoomNumber(rs.getString("RoomNumber"));
                r.setCheckIn(rs.getDate("CheckIn"));
                r.setCheckOut(rs.getDate("CheckOut"));
                r.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                reservations.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservations;
    }

    // Get most frequently booked rooms
    public List<Object[]> getMostBookedRooms() {
        List<Object[]> roomStats = new ArrayList<>();
        String sql = "SELECT RoomNumber, COUNT(*) as BookingCount FROM Reservations GROUP BY RoomNumber ORDER BY BookingCount DESC";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Object[] row = new Object[2];
                row[0] = rs.getString("RoomNumber");
                row[1] = rs.getInt("BookingCount");
                roomStats.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roomStats;
    }

    // Get total revenue over a period
    public BigDecimal getTotalRevenue(String startDate, String endDate) {
        String sql = "SELECT SUM(TotalAmount) as TotalRevenue FROM Reservations WHERE CheckIn >= ? AND CheckOut <= ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("TotalRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    // Get reservation by ID (for update)
    public Reservation getReservationById(int id) {
        String sql = "SELECT * FROM Reservations WHERE ReservationID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationId(rs.getInt("ReservationID"));
                r.setCustomerName(rs.getString("CustomerName"));
                r.setRoomNumber(rs.getString("RoomNumber"));
                r.setCheckIn(rs.getDate("CheckIn"));
                r.setCheckOut(rs.getDate("CheckOut"));
                r.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                return r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}