package com.PitStopManager.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.PitStopManager.service.DriverService;
import com.PitStopManager.util.SessionUtil;

@WebServlet("/drivers")
public class DriverController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DriverService driverService = new DriverService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!SessionUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            request.setAttribute("drivers", driverService.getAllDrivers());
            request.setAttribute("teams", driverService.getAllTeams());
            
            // Forward to the drivers page
            request.getRequestDispatcher("/WEB-INF/pages/drivers.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading drivers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Parse filter parameters
            String teamIdStr = request.getParameter("teamId");
            String minAgeStr = request.getParameter("ageMin");
            String maxAgeStr = request.getParameter("ageMax");
            String minPointsStr = request.getParameter("pointsMin");
            String minMarketValueStr = request.getParameter("marketValueMin");

            Integer teamId = teamIdStr != null && !teamIdStr.isEmpty() ? Integer.parseInt(teamIdStr) : null;
            Integer minAge = minAgeStr != null && !minAgeStr.isEmpty() ? Integer.parseInt(minAgeStr) : null;
            Integer maxAge = maxAgeStr != null && !maxAgeStr.isEmpty() ? Integer.parseInt(maxAgeStr) : null;
            Integer minPoints = minPointsStr != null && !minPointsStr.isEmpty() ? Integer.parseInt(minPointsStr) : null;
            Double minMarketValue = minMarketValueStr != null && !minMarketValueStr.isEmpty() ? 
                Double.parseDouble(minMarketValueStr) * 1000000 : null;

            // Get filtered drivers and set as attribute
            request.setAttribute("drivers", driverService.filterDrivers(teamId, minAge, maxAge, minPoints, minMarketValue));
            request.setAttribute("teams", driverService.getAllTeams());
            
            // Forward back to the page with filtered results
            request.getRequestDispatcher("/WEB-INF/pages/drivers.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error filtering drivers");
        }
    }
}
