package com.PitStopManager.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.PitStopManager.util.SessionUtil;
import com.PitStopManager.service.HomeService;
import java.util.Map;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final HomeService homeService = new HomeService();

    public HomeController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!SessionUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (!SessionUtil.canAccess(request, "/home")) {
            SessionUtil.redirectBasedOnRole(request, response);
            return;
        }

        // Fetch dashboard stats
        Map<String, Object> stats = homeService.getDashboardStats();
        // Set ALL stats as request attributes
        for (Map.Entry<String, Object> entry : stats.entrySet()) {
            request.setAttribute(entry.getKey(), entry.getValue());
        }

        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
