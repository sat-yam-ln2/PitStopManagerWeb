package com.PitStopManager.service;

import java.sql.*;
import com.PitStopManager.config.DbConfig;
import com.PitStopManager.model.UserModel;

public class RegisterService {
    private Connection dbConn;

    public RegisterService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
            System.out.println("✅ Database connection established.");
        } catch (Exception ex) {
            System.err.println("❌ Database connection error: " + ex.getMessage());
            ex.printStackTrace();
            this.dbConn = null;
        }
    }

    public Boolean addUser(UserModel user) {
        if (dbConn == null) {
            System.err.println("❌ Cannot add user: Database connection is not available");
            throw new IllegalStateException("DB connection is not available");
        }
        
        String sql = "INSERT INTO user (Username, Email, Password, Role, CreatedAt, LastLogin) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
                   
        try (PreparedStatement ps = dbConn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.setTimestamp(5, Timestamp.valueOf(user.getCreatedAt()));
            ps.setTimestamp(6, user.getLastLogin() != null
                    ? Timestamp.valueOf(user.getLastLogin())
                    : null);
                    
            int rowsAffected = ps.executeUpdate();
            System.out.println("✅ User registration rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("❌ SQL Error during user registration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean isUsernameTaken(String username) {
        if (dbConn == null) {
            System.err.println("❌ Cannot check username: Database connection is not available");
            throw new IllegalStateException("DB connection is not available");
        }
        
        String sql = "SELECT COUNT(*) FROM user WHERE Username = ?";
        try (PreparedStatement ps = dbConn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("❌ Error checking username: " + e.getMessage());
            e.printStackTrace();
            return true; // Assume username taken on error to prevent registration
        }
    }

    public boolean isEmailTaken(String email) {
        if (dbConn == null) {
            System.err.println("❌ Cannot check email: Database connection is not available");
            throw new IllegalStateException("DB connection is not available");
        }
        
        String sql = "SELECT COUNT(*) FROM user WHERE Email = ?";
        try (PreparedStatement ps = dbConn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("❌ Error checking email: " + e.getMessage());
            e.printStackTrace();
            return true; // Assume email taken on error to prevent registration
        }
    }
    
    // Make sure resources are closed when this service is no longer needed
    public void close() {
        if (dbConn != null) {
            try {
                dbConn.close();
                System.out.println("✅ Database connection closed.");
            } catch (SQLException e) {
                System.err.println("❌ Error closing database connection: " + e.getMessage());
            }
        }
    }
}