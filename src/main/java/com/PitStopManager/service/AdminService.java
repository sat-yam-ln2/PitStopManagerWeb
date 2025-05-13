package com.PitStopManager.service;

import com.PitStopManager.config.DbConfig;
import com.PitStopManager.model.*;
import com.PitStopManager.util.PasswordUtil;

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

    public void createUser(UserModel user) {
        String sql = "INSERT INTO user (Username, Email, Password, Role, CreatedAt) VALUES (?, ?, ?, ?, NOW())";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, PasswordUtil.encrypt(user.getEmail(), user.getPassword()));
            stmt.setString(4, user.getRole());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to create user");
        }
    }

    public void updateUser(UserModel user) {
        String sql = "UPDATE user SET Username = ?, Email = ?, Role = ? WHERE UserID = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getRole());
            stmt.setInt(4, user.getUserId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to update user");
        }
    }

    public void deleteUser(int userId) {
        String sql = "DELETE FROM user WHERE UserID = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to delete user");
        }
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

    public void createDriver(DriverTeam driver) {
        String sql = "INSERT INTO driver_team (DriverName, Age, MarketValue, TeamID) VALUES (?, ?, ?, ?)";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, driver.getDriverName());
            stmt.setInt(2, driver.getAge());
            stmt.setDouble(3, driver.getMarketValue());
            stmt.setInt(4, driver.getTeamId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to create driver");
        }
    }

    public void deleteDriver(int driverId) {
        String sql = "DELETE FROM driver_team WHERE DriverID = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, driverId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to delete driver");
        }
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

    public void deleteTeam(int teamId) {
        String sql = "DELETE FROM team WHERE TeamID = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, teamId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to delete team");
        }
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

    public void deleteContract(int contractId) {
        String sql = "DELETE FROM contract WHERE ContractID = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, contractId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to delete contract");
        }
    }
}