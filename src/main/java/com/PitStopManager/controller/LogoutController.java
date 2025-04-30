package com.PitStopManager.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.PitStopManager.util.CookieUtil;
import com.PitStopManager.util.SessionUtil;

import java.io.IOException;

@WebServlet(urlPatterns = { "/logout" })
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles POST request for logout operation.
     * Clears session and cookies, then redirects to login page.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Optional: delete specific cookies like "user" or "role" if set
        CookieUtil.deleteCookie(response, "user");
        CookieUtil.deleteCookie(response, "role");

        // Invalidate the session
        SessionUtil.invalidateSession(request);

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
