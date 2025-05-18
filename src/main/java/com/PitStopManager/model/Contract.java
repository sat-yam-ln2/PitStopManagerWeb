package com.PitStopManager.model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Contract {
    private int contractId;
    private int driverId;
    private LocalDate startDate;
    private LocalDate endDate;
    private double transferFee;

    // Getters and Setters
    public int getContractId() { return contractId; }
    public void setContractId(int contractId) { this.contractId = contractId; }

    public int getDriverId() { return driverId; }
    public void setDriverId(int driverId) { this.driverId = driverId; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public double getTransferFee() { return transferFee; }
    public void setTransferFee(double transferFee) { this.transferFee = transferFee; }

    // Add these new methods for formatted date strings
    public String getStartDateAsString() {
        return startDate != null ? startDate.toString() : "";
    }

    public String getEndDateAsString() {
        return endDate != null ? endDate.toString() : "";
    }

    // Optional: Add methods for formatted display if needed
    public String getFormattedStartDate() {
        return startDate != null ? startDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy")) : "";
    }

    public String getFormattedEndDate() {
        return endDate != null ? endDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy")) : "";
    }
}
