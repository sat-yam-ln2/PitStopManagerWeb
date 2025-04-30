package com.PitStopManager.controller;

import com.PitStopManager.model.*;
import com.PitStopManager.service.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AdminService service = new AdminService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<UserModel> users = service.getAllUsers();
        List<DriverTeam> drivers = service.getAllDrivers();
        List<Team> teams = service.getAllTeams();
        List<Contract> contracts = service.getAllContracts();

        req.setAttribute("users", users);
        req.setAttribute("drivers", drivers);
        req.setAttribute("teams", teams);
        req.setAttribute("contracts", contracts);

        req.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(req, resp);
    }
}