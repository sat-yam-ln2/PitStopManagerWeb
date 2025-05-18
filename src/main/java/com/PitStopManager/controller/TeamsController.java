package com.PitStopManager.controller;

import com.PitStopManager.service.TeamService;
import com.PitStopManager.model.Team;
import com.PitStopManager.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/teams")
public class TeamsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final TeamService teamService = new TeamService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        List<Team> teams = teamService.getAllTeams();
        Map<Integer, String> teamDrivers = teamService.getTeamDriverNames();
        request.setAttribute("teams", teams);
        request.setAttribute("teamDrivers", teamDrivers);
        request.getRequestDispatcher("/WEB-INF/pages/teams.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
