package com.PitStopManager.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.PitStopManager.util.SessionUtil;

/**
 * AuthenticationFilter ensures users are logged in before accessing protected pages.
 */
@WebFilter(urlPatterns = { "/home/*", "/contract/*", "/admin/*", "/profile/*" })  // Remove /login and /signup from filter
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String requestPath = request.getRequestURI().substring(request.getContextPath().length());
        
        // Allow access to login and register pages
        if (requestPath.equals("/login") || requestPath.equals("/register")) {
            chain.doFilter(req, res);
            return;
        }
        
        // Check if user is authenticated
        if (!SessionUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user has permission to access the page
        if (!SessionUtil.canAccess(request, requestPath)) {
            SessionUtil.redirectBasedOnRole(request, response);
            return;
        }
        
        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {
        // Nothing to clean up
    }
}
