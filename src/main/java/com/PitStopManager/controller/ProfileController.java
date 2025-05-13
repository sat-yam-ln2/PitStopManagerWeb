package com.PitStopManager.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.PitStopManager.model.UserModel;
import com.PitStopManager.service.UserService;
import com.PitStopManager.util.PasswordUtil;
import com.PitStopManager.util.SessionUtil;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!SessionUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (!SessionUtil.canAccess(request, "/profile")) {
            SessionUtil.redirectBasedOnRole(request, response);
            return;
        }

        String userEmail = (String) request.getSession().getAttribute("user");
        if (userEmail == null) {
            response.sendRedirect("login");
            return;
        }

        UserModel user = userService.getUserByEmail(userEmail);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check authentication and permissions for profile updates
        if (!SessionUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if ("delete_account".equals(action) && !SessionUtil.canAccess(request, "/profile/delete")) {
            SessionUtil.redirectBasedOnRole(request, response);
            return;
        }
        
        if ("delete_account".equals(action)) {
            handleDeleteAccount(request, response);
            return;
        }
        
        String userEmail = (String) request.getSession().getAttribute("user");
        if (userEmail == null) {
            response.sendRedirect("login");
            return;
        }

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        UserModel currentUser = userService.getUserByEmail(userEmail);
        
        // Update basic info
        if (!username.equals(currentUser.getUsername())) {
            currentUser.setUsername(username);
        }
        
        if (!email.equals(currentUser.getEmail())) {
            currentUser.setEmail(email);
        }

        // Update password if provided
        if (currentPassword != null && !currentPassword.isEmpty()) {
            if (!PasswordUtil.decrypt(currentUser.getPassword(), userEmail).equals(currentPassword)) {
                request.setAttribute("message", "Current password is incorrect");
                request.setAttribute("messageType", "error");
                doGet(request, response);
                return;
            }
            
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("message", "New passwords do not match");
                request.setAttribute("messageType", "error");
                doGet(request, response);
                return;
            }
            
            currentUser.setPassword(PasswordUtil.encrypt(email, newPassword));
        }

        if (userService.updateUser(currentUser)) {
            request.setAttribute("message", "Profile updated successfully");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Failed to update profile");
            request.setAttribute("messageType", "error");
        }

        doGet(request, response);
    }

    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("user");
        if (userEmail == null) {
            response.sendRedirect("login");
            return;
        }

        UserModel user = userService.getUserByEmail(userEmail);
        if (user != null) {
            boolean deleted = userService.deleteUser(user.getUserId());
            if (deleted) {
                // Clear session
                request.getSession().invalidate();
                
                // Clear all cookies
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        cookie.setValue("");
                        cookie.setPath("/");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                    }
                }
                
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
        }
        
        // If deletion failed
        request.setAttribute("message", "Failed to delete account");
        request.setAttribute("messageType", "error");
        doGet(request, response);
    }
}
