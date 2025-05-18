package com.PitStopManager.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import com.PitStopManager.model.*;
import com.PitStopManager.service.AdminService;
import com.PitStopManager.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AdminService service = new AdminService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!SessionUtil.isAuthenticated(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (!SessionUtil.hasRole(req, "admin")) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        try {
            // Fetch all data
            List<UserModel> users = service.getAllUsers();
            List<DriverTeam> drivers = service.getAllDrivers();
            List<Team> teams = service.getAllTeams();
            List<Contract> contracts = service.getAllContracts();

            // Add statistics
            req.setAttribute("totalUsers", users.size());
            req.setAttribute("totalDrivers", drivers.size());
            req.setAttribute("totalTeams", teams.size());
            req.setAttribute("totalContracts", contracts.size());

            // Set attributes for display
            req.setAttribute("users", users);
            req.setAttribute("drivers", drivers);
            req.setAttribute("teams", teams);
            req.setAttribute("contracts", contracts);

            req.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to load dashboard data");
            req.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!SessionUtil.hasRole(req, "admin")) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        String action = req.getParameter("action");
        String entity = req.getParameter("entity");
        
        try {
            switch (action) {
                case "create":
                    handleCreate(req, resp, entity);
                    break;
                case "update":
                    handleUpdate(req, resp, entity);
                    break;
                case "delete":
                    handleDelete(req, resp, entity);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp, String entity) throws IOException {
        switch (entity) {
            case "user":
                UserModel user = new UserModel();
                user.setUsername(req.getParameter("username"));
                user.setEmail(req.getParameter("email"));
                user.setPassword(req.getParameter("password"));
                user.setRole(req.getParameter("role"));
                service.createUser(user);
                break;
            case "driver":
                DriverTeam driver = new DriverTeam();
                driver.setDriverName(req.getParameter("driverName"));
                driver.setAge(Integer.parseInt(req.getParameter("age")));
                driver.setMarketValue(Double.parseDouble(req.getParameter("marketValue")));
                driver.setTeamId(Integer.parseInt(req.getParameter("teamId")));
                service.createDriver(driver);
                break;
            case "team":
                Team team = new Team();
                team.setTeamName(req.getParameter("teamName"));
                team.setTeamPrincipal(req.getParameter("teamPrincipal"));
                team.setBaseLocation(req.getParameter("baseLocation"));
                team.setTeamBudget(Double.parseDouble(req.getParameter("teamBudget")));
                service.createTeam(team);
                break;
            case "contract":
                Contract contract = new Contract();
                contract.setDriverId(Integer.parseInt(req.getParameter("driverId")));
                contract.setStartDate(java.time.LocalDate.parse(req.getParameter("startDate")));
                contract.setEndDate(java.time.LocalDate.parse(req.getParameter("endDate")));
                contract.setTransferFee(Double.parseDouble(req.getParameter("transferFee")));
                service.createContract(contract);
                break;
        }
        resp.sendRedirect(req.getContextPath() + "/admin");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp, String entity) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        switch (entity) {
            case "user":
                UserModel user = new UserModel();
                user.setUserId(id);
                user.setUsername(req.getParameter("username"));
                user.setEmail(req.getParameter("email"));
                user.setRole(req.getParameter("role"));
                service.updateUser(user);
                break;
            case "driver":
                DriverTeam driver = new DriverTeam();
                driver.setDriverId(id);
                driver.setDriverName(req.getParameter("driverName"));
                driver.setAge(Integer.parseInt(req.getParameter("age")));
                driver.setMarketValue(Double.parseDouble(req.getParameter("marketValue")));
                driver.setTeamId(Integer.parseInt(req.getParameter("teamId")));
                service.updateDriver(driver);
                break;
            case "team":
                Team team = new Team();
                team.setTeamId(id);
                team.setTeamName(req.getParameter("teamName"));
                team.setTeamPrincipal(req.getParameter("teamPrincipal"));
                team.setBaseLocation(req.getParameter("baseLocation"));
                team.setTeamBudget(Double.parseDouble(req.getParameter("teamBudget")));
                service.updateTeam(team);
                break;
            case "contract":
                Contract contract = new Contract();
                contract.setContractId(id);
                contract.setDriverId(Integer.parseInt(req.getParameter("driverId")));
                contract.setStartDate(java.time.LocalDate.parse(req.getParameter("startDate")));
                contract.setEndDate(java.time.LocalDate.parse(req.getParameter("endDate")));
                contract.setTransferFee(Double.parseDouble(req.getParameter("transferFee")));
                service.updateContract(contract);
                break;
        }
        resp.sendRedirect(req.getContextPath() + "/admin");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp, String entity) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        switch (entity) {
            case "user":
                service.deleteUser(id);
                break;
            case "driver":
                service.deleteDriver(id);
                break;
            case "team":
                service.deleteTeam(id);
                break;
            case "contract":
                service.deleteContract(id);
                break;
        }
        resp.sendRedirect(req.getContextPath() + "/admin");
    }
}