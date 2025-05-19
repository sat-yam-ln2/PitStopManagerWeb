package com.PitStopManager.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.PitStopManager.util.SessionUtil;

@WebServlet(urlPatterns = {"/about", "/about.jsp"})
public class AboutUsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is authenticated
        if (!SessionUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get user's email from session
        String userEmail = (String) request.getSession().getAttribute("user");
        if (userEmail == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // The about page should be accessible to all authenticated users
        // Remove the access check that was causing redirection
        request.setAttribute("userEmail", userEmail);
        request.setAttribute("role", request.getSession().getAttribute("role"));
        
        // Forward to the about page
        request.getRequestDispatcher("/WEB-INF/pages/about.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
