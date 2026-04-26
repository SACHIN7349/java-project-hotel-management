// File: src/com/model/Reservation.java
package com.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Reservation {
    private int reservationId;
    private String customerName;
    private String roomNumber;
    private Date checkIn;
    private Date checkOut;
    private BigDecimal totalAmount;

    public Reservation() {}

    public Reservation(int reservationId, String customerName, String roomNumber, 
                       Date checkIn, Date checkOut, BigDecimal totalAmount) {
        this.reservationId = reservationId;
        this.customerName = customerName;
        this.roomNumber = roomNumber;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalAmount = totalAmount;
    }

    // Getters and Setters
    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
    public Date getCheckIn() { return checkIn; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }
    public Date getCheckOut() { return checkOut; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
}