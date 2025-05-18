package com.PitStopManager.service;

import com.PitStopManager.config.DbConfig;
import java.sql.*;
import java.util.*;

public class HomeService {
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        try (Connection conn = DbConfig.getDbConnection()) {
            // Total Drivers
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM driver_team")) {
                stats.put("totalDrivers", rs.next() ? rs.getInt(1) : 0);
            }
            // Active Contracts
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM contract WHERE EndDate >= CURDATE()")) {
                stats.put("activeContracts", rs.next() ? rs.getInt(1) : 0);
            }
            // Avg. Market Value (handle null)
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT AVG(MarketValue) FROM driver_team")) {
                double avg = 0.0;
                if (rs.next()) {
                    avg = rs.getDouble(1);
                    if (rs.wasNull()) avg = 0.0;
                }
                stats.put("avgMarketValue", avg);
            }
            // Total Teams
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM team")) {
                stats.put("totalTeams", rs.next() ? rs.getInt(1) : 0);
            }
            // Top 5 Drivers by Market Value (with at least one contract)
            List<Map<String, Object>> topDrivers = new ArrayList<>();
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery(
                    "SELECT d.DriverName, d.MarketValue " +
                    "FROM driver_team d " +
                    "WHERE EXISTS (SELECT 1 FROM contract c WHERE c.DriverID = d.DriverID) " +
                    "ORDER BY d.MarketValue DESC LIMIT 5")) {
                while (rs.next()) {
                    Map<String, Object> d = new HashMap<>();
                    d.put("name", rs.getString("DriverName"));
                    d.put("value", rs.getDouble("MarketValue"));
                    topDrivers.add(d);
                }
            }
            stats.put("topDrivers", topDrivers);

            // Highest Paid Contract (with driver name)
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery(
                    "SELECT d.DriverName, c.TransferFee FROM contract c " +
                    "JOIN driver_team d ON c.DriverID = d.DriverID " +
                    "ORDER BY c.TransferFee DESC LIMIT 1")) {
                if (rs.next()) {
                    stats.put("highestPaidDriver", rs.getString("DriverName"));
                    stats.put("highestPaidFee", rs.getDouble("TransferFee"));
                } else {
                    stats.put("highestPaidDriver", "-");
                    stats.put("highestPaidFee", 0.0);
                }
            }

            // Youngest Driver
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT DriverName, Age FROM driver_team WHERE Age IS NOT NULL ORDER BY Age ASC LIMIT 1")) {
                if (rs.next()) {
                    stats.put("youngestDriver", rs.getString("DriverName"));
                    stats.put("youngestAge", rs.getInt("Age"));
                } else {
                    stats.put("youngestDriver", "-");
                    stats.put("youngestAge", 0);
                }
            }

            // Oldest Driver
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT DriverName, Age FROM driver_team WHERE Age IS NOT NULL ORDER BY Age DESC LIMIT 1")) {
                if (rs.next()) {
                    stats.put("oldestDriver", rs.getString("DriverName"));
                    stats.put("oldestAge", rs.getInt("Age"));
                } else {
                    stats.put("oldestDriver", "-");
                    stats.put("oldestAge", 0);
                }
            }

            // Team with Most Points (team name, total points)
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery(
                    "SELECT t.TeamName, SUM(d.PointsScored) AS TotalPoints " +
                    "FROM team t JOIN driver_team d ON t.TeamID = d.TeamID " +
                    "GROUP BY t.TeamID, t.TeamName ORDER BY TotalPoints DESC LIMIT 1")) {
                if (rs.next()) {
                    stats.put("topTeam", rs.getString("TeamName"));
                    stats.put("topTeamPoints", rs.getInt("TotalPoints"));
                } else {
                    stats.put("topTeam", "-");
                    stats.put("topTeamPoints", 0);
                }
            }

            // Average Driver Age
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT AVG(Age) FROM driver_team WHERE Age IS NOT NULL")) {
                double avgAge = 0.0;
                if (rs.next()) {
                    avgAge = rs.getDouble(1);
                    if (rs.wasNull()) avgAge = 0.0;
                }
                stats.put("avgDriverAge", avgAge);
            }

            // Total Market Value of All Drivers
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT SUM(MarketValue) FROM driver_team")) {
                double sum = 0.0;
                if (rs.next()) {
                    sum = rs.getDouble(1);
                    if (rs.wasNull()) sum = 0.0;
                }
                stats.put("totalMarketValue", sum);
            }

        } catch (Exception e) {
            e.printStackTrace();
            // fallback values to avoid nulls in JSP
            stats.putIfAbsent("avgMarketValue", 0.0);
            stats.putIfAbsent("topDrivers", new ArrayList<>());
            stats.putIfAbsent("highestPaidDriver", "-");
            stats.putIfAbsent("highestPaidFee", 0.0);
            stats.putIfAbsent("youngestDriver", "-");
            stats.putIfAbsent("youngestAge", 0);
            stats.putIfAbsent("oldestDriver", "-");
            stats.putIfAbsent("oldestAge", 0);
            stats.putIfAbsent("topTeam", "-");
            stats.putIfAbsent("topTeamPoints", 0);
            stats.putIfAbsent("avgDriverAge", 0.0);
            stats.putIfAbsent("totalMarketValue", 0.0);
        }
        return stats;
    }
}
