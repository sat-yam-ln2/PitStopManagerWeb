package com.PitStopManager.controller;

import com.PitStopManager.model.UserModel;
import com.PitStopManager.service.RegisterService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.regex.Pattern;

@WebServlet("/signup")
public class SignUpController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final RegisterService registerService = new RegisterService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String terms = request.getParameter("terms");
        // --- 2) Log them to the server console ---
        System.out.println("New signup POST received:");
        System.out.println("    username        = " + username);
        System.out.println("    email           = " + email);
        System.out.println("    password        = " + password);
        System.out.println("    confirmPassword = " + confirmPassword);
        System.out.println("    terms           = " + (terms != null ? "checked" : "not checked"));
        boolean hasError = false;

        // Input validation
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("usernameError", "Username is required.");
            hasError = true;
        } else if (registerService.isUsernameTaken(username)) {
            request.setAttribute("usernameError", "Username is already taken.");
            hasError = true;
        }

        if (email == null || !Pattern.matches("^\\S+@\\S+\\.\\S+$", email)) {
            request.setAttribute("emailError", "Enter a valid email address.");
            hasError = true;
        } else if (registerService.isEmailTaken(email)) {
            request.setAttribute("emailError", "This email is already registered.");
            hasError = true;
        }

        if (password == null || password.length() < 6) {
            request.setAttribute("passwordError", "Password must be at least 6 characters.");
            hasError = true;
        }

        if (confirmPassword == null || !confirmPassword.equals(password)) {
            request.setAttribute("confirmPasswordError", "Passwords do not match.");
            hasError = true;
        }

        if (terms == null) {
            request.setAttribute("termsError", "You must agree to the Terms and Privacy Policy.");
            hasError = true;
        }

        if (hasError) {
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/pages/signup.jsp").forward(request, response);
            return;
        }

        // User creation
        UserModel user = new UserModel();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);  // TODO: Hash the password before storing!
        user.setRole("viewer");  // Instead of "user"
        user.setCreatedAt(LocalDateTime.now());
        user.setLastLogin(null);

        Boolean success = registerService.addUser(user);

        if (Boolean.TRUE.equals(success)) {
            response.sendRedirect("home");  // Redirect to login page on successful registration
        } else {
            request.setAttribute("registrationError", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/signup.jsp").forward(request, response);
        }
    }
}
