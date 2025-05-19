package com.PitStopManager.controller;

import com.PitStopManager.model.Contract;
import com.PitStopManager.service.ContractService;
import com.PitStopManager.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/contracts")
public class ContractController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ContractService contractService = new ContractService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!SessionUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String search = request.getParameter("search");
        try {
            List<Contract> contracts;
            if (search != null && !search.trim().isEmpty()) {
                contracts = contractService.getContractsByDriverName(search.trim());
            } else {
                contracts = contractService.getAllContracts();
            }
            request.setAttribute("contracts", contracts);
            request.setAttribute("search", search != null ? search : "");
            request.getRequestDispatcher("/WEB-INF/pages/contracts.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error loading contracts");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
