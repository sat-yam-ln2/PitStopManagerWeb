package com.PitStopManager.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.PitStopManager.model.UserModel;
import com.PitStopManager.service.UserService;
import com.PitStopManager.util.PasswordUtil;
import com.PitStopManager.util.SessionUtil;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userEmail = (String) SessionUtil.getAttribute(request, "user");
        if (userEmail == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = userService.getUserByEmail(userEmail);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String userEmail = (String) SessionUtil.getAttribute(request, "user");

        if (userEmail == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel currentUser = userService.getUserByEmail(userEmail);
        
        if ("update".equals(action)) {
            handleProfileUpdate(request, response, currentUser);
        } else if ("delete".equals(action)) {
            handleAccountDeletion(request, response, userEmail);
        }
    }

    private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response, UserModel currentUser) 
            throws ServletException, IOException {
        String newUsername = request.getParameter("username");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String currentPassword = request.getParameter("currentPassword");

        // Verify current password
        if (!PasswordUtil.decrypt(currentUser.getPassword(), currentUser.getEmail())
                .equals(currentPassword)) {
            setMessage(request, "Current password is incorrect", "error");
            doGet(request, response);
            return;
        }

        // Update user details
        currentUser.setUsername(newUsername);
        currentUser.setEmail(newEmail);
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            currentUser.setPassword(PasswordUtil.encrypt(newEmail, newPassword));
        }

        if (userService.updateUser(currentUser)) {
            // Update session if email changed
            request.getSession().setAttribute("user", newEmail);
            setMessage(request, "Profile updated successfully", "success");
        } else {
            setMessage(request, "Failed to update profile", "error");
        }

        doGet(request, response);
    }

    private void handleAccountDeletion(HttpServletRequest request, HttpServletResponse response, String userEmail) 
            throws IOException {
        if (userService.deleteUserByEmail(userEmail)) {
            SessionUtil.invalidateSession(request);
            SessionUtil.clearSessionCookies(request, response);
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            setMessage(request, "Failed to delete account", "error");
            try {
                doGet(request, response);
            } catch (ServletException e) {
                throw new IOException(e);
            }
        }
    }

    private void setMessage(HttpServletRequest request, String message, String type) {
        request.setAttribute("message", message);
        request.setAttribute("messageType", type);
    }
}
