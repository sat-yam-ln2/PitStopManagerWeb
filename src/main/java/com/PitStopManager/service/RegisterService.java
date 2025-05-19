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
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DbConfig.getDbConnection();
            String sql = "INSERT INTO user (Username, Email, Password, Role, CreatedAt) "
                      + "VALUES (?, ?, ?, ?, current_timestamp())";
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, "viewer"); // Default role as per your schema
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("❌ Error adding user: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
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