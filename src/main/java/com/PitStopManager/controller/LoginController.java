package com.PitStopManager.controller;

import java.io.IOException;
import java.util.regex.Pattern;

import com.PitStopManager.model.UserModel;
import com.PitStopManager.service.LoginService;
import com.PitStopManager.util.CookieUtil;
import com.PitStopManager.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * LoginController handles login requests and delegates authentication to LoginService.
 * It also manages session and optional cookie storage for login persistence.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/" , "/login"})
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final LoginService loginService;

	private static final String EMAIL_REGEX = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
	private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

	/**
	 * Constructor initializes LoginService.
	 */
	public LoginController() {
		this.loginService = new LoginService();
	}

	/**
	 * Handles GET requests by forwarding to login page.
	 *
	 * @param request  HttpServletRequest object
	 * @param response HttpServletResponse object
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (SessionUtil.getAttribute(request, "user") != null) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}
		request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
	}

	/**
	 * Handles POST requests for login authentication.
	 *
	 * @param request  HttpServletRequest object
	 * @param response HttpServletResponse object
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");
	    String remember = request.getParameter("remember");

	    // Hard-coded admin credentials
	    if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
	        request.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(request, response);
	        return;
	    }

	    boolean isValid = validateLoginCredentials(request, email, password);

	    if (!isValid) {
	        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
	        return;
	    }

	    UserModel userModel = new UserModel(email, password);
	    Boolean loginStatus = loginService.loginUser(userModel);

	    if (loginStatus != null && loginStatus) {
	        handleSuccessfulLogin(request, response, email, remember);
	    } else {
	        handleLoginFailure(request, response, loginStatus);
	    }
	}

	/**
	 * Validates email and password format before authentication.
	 *
	 * @param request  HttpServletRequest object
	 * @param email    user email input
	 * @param password user password input
	 * @return true if credentials are valid; false otherwise
	 */
	private boolean validateLoginCredentials(HttpServletRequest request, String email, String password) {
		boolean isValid = true;

		if (email == null || email.trim().isEmpty()) {
			request.setAttribute("emailError", "Email is required");
			isValid = false;
		} else if (!EMAIL_PATTERN.matcher(email).matches()) {
			request.setAttribute("emailError", "Please enter a valid email address");
			isValid = false;
		}

		if (password == null || password.trim().isEmpty()) {
			request.setAttribute("passwordError", "Password is required");
			isValid = false;
		} else if (password.length() < 6) {
			request.setAttribute("passwordError", "Password must be at least 6 characters long");
			isValid = false;
		}

		return isValid;
	}

	/**
	 * Handles successful login by setting session attributes and optional cookie.
	 *
	 * @param request  HttpServletRequest object
	 * @param response HttpServletResponse object
	 * @param email    authenticated user email
	 * @param remember whether to store cookie
	 * @throws IOException if an I/O error occurs
	 */
	private void handleSuccessfulLogin(HttpServletRequest request, HttpServletResponse response,
	                                   String email, String remember) throws IOException {
		SessionUtil.setAttribute(request, "user", email);

		// Optional: store user role
		String role = loginService.getUserRole(email);
		SessionUtil.setAttribute(request, "role", role);

		if ("true".equals(remember)) {
			CookieUtil.addCookie(response, "user", email, (60 * 60 * 24 * 30)); // 30 days
		}

		response.sendRedirect(request.getContextPath() + "/home");
	}

	/**
	 * Handles failed login attempts with appropriate error messages.
	 *
	 * @param request      HttpServletRequest object
	 * @param response     HttpServletResponse object
	 * @param loginStatus  Boolean indicating login success or failure
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	private void handleLoginFailure(HttpServletRequest request, HttpServletResponse response, Boolean loginStatus)
			throws ServletException, IOException {
		String errorMessage;
		if (loginStatus == null) {
			errorMessage = "Our server is under maintenance. Please try again later!";
		} else {
			errorMessage = "Invalid email or password";
		}
		request.setAttribute("error", errorMessage);
		request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
	}
}
