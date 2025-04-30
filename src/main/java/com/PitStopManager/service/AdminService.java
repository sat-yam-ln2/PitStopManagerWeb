package com.PitStopManager.service;

import com.PitStopManager.config.DbConfig;
import com.PitStopManager.model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminService {
    public List<UserModel> getAllUsers() {
        List<UserModel> list = new ArrayList<>();
        String sql = "SELECT * FROM user";
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                UserModel u = new UserModel();
                u.setUserId(rs.getInt("UserID"));
                u.setUsername(rs.getString("Username"));
                u.setEmail(rs.getString("Email"));
                u.setRole(rs.getString("Role"));
                u.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                Timestamp ts = rs.getTimestamp("LastLogin");
                if (ts != null) u.setLastLogin(ts.toLocalDateTime());
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<DriverTeam> getAllDrivers() {
        List<DriverTeam> list = new ArrayList<>();
        String sql = "SELECT * FROM driver_team";
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                DriverTeam d = new DriverTeam();
                d.setDriverId(rs.getInt("DriverID"));
                d.setDriverName(rs.getString("DriverName"));
                d.setAge(rs.getInt("Age"));
                d.setMarketValue(rs.getDouble("MarketValue"));
                d.setRaceWins(rs.getInt("RaceWins"));
                d.setPodiumFinishes(rs.getInt("PodiumFinishes"));
                d.setFastestLaps(rs.getInt("FastestLaps"));
                d.setPointsScored(rs.getInt("PointsScored"));
                d.setConsistencyRating(rs.getDouble("ConsistencyRating"));
                d.setTeamId(rs.getInt("TeamID"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Team> getAllTeams() {
        List<Team> list = new ArrayList<>();
        String sql = "SELECT * FROM team";
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Team t = new Team();
                t.setTeamId(rs.getInt("TeamID"));
                t.setTeamName(rs.getString("TeamName"));
                t.setTeamPrincipal(rs.getString("TeamPrincipal"));
                t.setBaseLocation(rs.getString("BaseLocation"));
                t.setTeamBudget(rs.getDouble("TeamBudget"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Contract> getAllContracts() {
        List<Contract> list = new ArrayList<>();
        String sql = "SELECT * FROM contract";
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Contract c = new Contract();
                c.setContractId(rs.getInt("ContractID"));
                c.setDriverId(rs.getInt("DriverID"));
                c.setStartDate(rs.getDate("StartDate").toLocalDate());
                c.setEndDate(rs.getDate("EndDate").toLocalDate());
                c.setTransferFee(rs.getDouble("TransferFee"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}