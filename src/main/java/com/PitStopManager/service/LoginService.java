package com.PitStopManager.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.PitStopManager.config.DbConfig;
import com.PitStopManager.model.UserModel;
import com.PitStopManager.util.PasswordUtil;

/**
 * Service class for handling login functionality for PitStopManager.
 */
public class LoginService {

    private Connection dbConn;
    private boolean isConnectionError = false;

    /**
     * Constructor to initialize the database connection.
     */
    public LoginService() {
        try {
            dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            isConnectionError = true;
        }
    }

    /**
     * Validates the user credentials.
     *
     * @param user the UserModel object containing email and password
     * @return true if valid, false otherwise; null if DB error
     */
    public Boolean loginUser(UserModel user) {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }

        String query = "SELECT email, password FROM user WHERE email = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, user.getEmail());
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                return validatePassword(result, user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return false;
    }

    /**
     * Gets the role of a user based on their email.
     *
     * @param email the user's email address
     * @return the user's role or "user" if not found
     */
    public String getUserRole(String email) {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return "user"; // Default role if there's a connection error
        }

        String query = "SELECT role FROM user WHERE email = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                return result.getString("role");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "user"; // Default role if user not found or error occurs
    }

    /**
     * Validates password from the DB with input.
     *
     * @param result the DB result with encrypted password
     * @param user the input user object
     * @return true if password matches, false otherwise
     * @throws SQLException if DB error occurs
     */
    private boolean validatePassword(ResultSet result, UserModel user) throws SQLException {
        String dbEmail = result.getString("email");
        String dbPassword = result.getString("password");

        return dbEmail.equals(user.getEmail())
                && PasswordUtil.decrypt(dbPassword, dbEmail).equals(user.getPassword());
    }
}