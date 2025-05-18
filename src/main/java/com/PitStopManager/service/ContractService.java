package com.PitStopManager.service;

import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.PitStopManager.config.DbConfig;
import com.PitStopManager.model.Contract;

public class ContractService {

    public List<Contract> getAllContracts() throws SQLException, ClassNotFoundException {
        List<Contract> contracts = new ArrayList<>();
        String sql = "SELECT c.*, d.DriverName FROM contract c JOIN driver_team d ON c.DriverID = d.DriverID";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Contract contract = new Contract();
                contract.setContractId(rs.getInt("ContractID"));
                contract.setDriverId(rs.getInt("DriverID"));
                LocalDate startDate = rs.getDate("StartDate").toLocalDate();
                LocalDate endDate = rs.getDate("EndDate").toLocalDate();
                contract.setStartDate(startDate);
                contract.setEndDate(endDate);
                contract.setTransferFee(rs.getDouble("TransferFee"));
                contract.setDriverName(rs.getString("DriverName"));
                contract.setStartDateStr(startDate.format(formatter));
                contract.setEndDateStr(endDate.format(formatter));
                contracts.add(contract);
            }
        }
        return contracts;
    }

    public List<Contract> getContractsByDriverName(String driverName) throws SQLException, ClassNotFoundException {
        List<Contract> contracts = new ArrayList<>();
        String sql = "SELECT c.*, d.DriverName FROM contract c JOIN driver_team d ON c.DriverID = d.DriverID WHERE d.DriverName LIKE ?";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + driverName + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Contract contract = new Contract();
                    contract.setContractId(rs.getInt("ContractID"));
                    contract.setDriverId(rs.getInt("DriverID"));
                    contract.setStartDate(rs.getDate("StartDate").toLocalDate());
                    contract.setEndDate(rs.getDate("EndDate").toLocalDate());
                    contract.setTransferFee(rs.getDouble("TransferFee"));
                    contract.setDriverName(rs.getString("DriverName"));
                    contract.setStartDateStr(contract.getStartDate().format(formatter));
                    contract.setEndDateStr(contract.getEndDate().format(formatter));
                    contracts.add(contract);
                }
            }
        }
        return contracts;
    }
}
