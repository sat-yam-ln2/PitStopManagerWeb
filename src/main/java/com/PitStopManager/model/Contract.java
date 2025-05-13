package com.PitStopManager.model;

import java.time.LocalDate;

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
}
