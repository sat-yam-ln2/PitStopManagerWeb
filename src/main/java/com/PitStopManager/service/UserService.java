package com.PitStopManager.service;

import java.sql.*;
import com.PitStopManager.config.DbConfig;
import com.PitStopManager.model.UserModel;

public class UserService {
    private Connection dbConn;

    public UserService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
            System.out.println("✅ Database connection established in UserService.");
        } catch (Exception ex) {
            System.err.println("❌ Database connection error in UserService: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public UserModel getUserByEmail(String email) {
        String sql = "SELECT * FROM user WHERE Email = ?";
        try (PreparedStatement ps = dbConn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                UserModel user = new UserModel();
                user.setUserId(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setRole(rs.getString("Role"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                
                Timestamp lastLogin = rs.getTimestamp("LastLogin");
                if (lastLogin != null) {
                    user.setLastLogin(lastLogin.toLocalDateTime());
                }
                
                return user;
            }
        } catch (SQLException e) {
            System.err.println("❌ Error fetching user: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUser(UserModel user) {
        String sql = "UPDATE user SET Username = ?, Email = ?, Password = ? WHERE UserID = ?";
        try (PreparedStatement ps = dbConn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getUserId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error updating user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM user WHERE UserID = ?";
        try (PreparedStatement ps = dbConn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Clean up resources
    public void close() {
        if (dbConn != null) {
            try {
                dbConn.close();
                System.out.println("✅ UserService database connection closed.");
            } catch (SQLException e) {
                System.err.println("❌ Error closing database connection: " + e.getMessage());
            }
        }
    }
}
