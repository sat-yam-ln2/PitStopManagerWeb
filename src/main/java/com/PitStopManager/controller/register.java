package com.PitStopManager.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.regex.Pattern;
import com.PitStopManager.util.PasswordUtil;
import com.PitStopManager.model.UserModel;
import com.PitStopManager.service.RegisterService;

/**
 * Servlet implementation class register
 */
@WebServlet("/register")
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public register() {
        super();
        // TODO Auto-generated constructor stub
    }

    private final RegisterService registerService = new RegisterService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.getRequestDispatcher("WEB-INF/pages/signup.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String terms = request.getParameter("terms");
        
        boolean hasError = false;

        // Clear previous errors
        request.setAttribute("usernameError", null);
        request.setAttribute("emailError", null);
        request.setAttribute("passwordError", null);
        request.setAttribute("confirmPasswordError", null);
        request.setAttribute("termsError", null);

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
            request.getRequestDispatcher("WEB-INF/pages/signup.jsp").forward(request, response);
            return;
        }

        // Create and setup user model
        UserModel user = new UserModel();
        user.setUsername(username);
        user.setEmail(email);
        String encryptedPassword = PasswordUtil.encrypt(email, password);
        user.setPassword(encryptedPassword);
        user.setRole("user");
        user.setCreatedAt(LocalDateTime.now());

        try {
            if (registerService.addUser(user)) {
                // Set user in session
                request.getSession().setAttribute("user", email);
                request.getSession().setAttribute("role", "user");
                request.getSession().setAttribute("username", username);
                
                // Redirect to home page
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("registrationError", "Registration failed. Please try again.");
        }

        // If we get here, there was an error
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.getRequestDispatcher("WEB-INF/pages/signup.jsp").forward(request, response);
    }
    
}


