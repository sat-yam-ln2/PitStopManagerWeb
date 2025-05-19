package com.PitStopManager.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Utility class for managing HTTP sessions in the PitStop Manager web application.
 * Provides methods to set, get, remove session attributes and invalidate sessions.
 */
public class SessionUtil {

    /**
     * Sets an attribute in the session.
     *
     * @param request the HttpServletRequest from which the session is obtained
     * @param key the key under which the attribute is stored
     * @param value the value of the attribute to store in the session
     */
    public static void setAttribute(HttpServletRequest request, String key, Object value) {
        HttpSession session = request.getSession();
        session.setAttribute(key, value);
    }

    /**
     * Retrieves an attribute from the session.
     *
     * @param request the HttpServletRequest from which the session is obtained
     * @param key the key of the attribute to retrieve
     * @return the attribute value, or null if the attribute does not exist or the session is invalid
     */
    public static Object getAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return session.getAttribute(key);
        }
        return null;
    }

    /**
     * Removes an attribute from the session.
     *
     * @param request the HttpServletRequest from which the session is obtained
     * @param key the key of the attribute to remove
     */
    public static void removeAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
    }

    /**
     * Invalidates the current session.
     *
     * @param request the HttpServletRequest from which the session is obtained
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    /**
     * Clears all session-related cookies.
     *
     * @param request HttpServletRequest object
     * @param response HttpServletResponse object
     */
    public static void clearSessionCookies(HttpServletRequest request, HttpServletResponse response) {
        CookieUtil.deleteCookie(response, "user");
        CookieUtil.deleteCookie(response, "role");
        CookieUtil.deleteCookie(response, "JSESSIONID");
    }

    public static boolean hasRole(HttpServletRequest request, String requiredRole) {
        String userRole = (String) getAttribute(request, "role");
        if (userRole == null) return false;
        
        // Admin has access to everything
        if ("admin".equals(userRole)) return true;
        
        // Manager has access to manager and viewer pages
        if ("manager".equals(userRole)) {
            return "manager".equals(requiredRole) || "viewer".equals(requiredRole);
        }
        
        // Viewer has access only to viewer pages
        if ("viewer".equals(userRole)) {
            return "viewer".equals(requiredRole);
        }
        
        return false;
    }

    public static boolean isAuthenticated(HttpServletRequest request) {
        return getAttribute(request, "user") != null;
    }

    public static boolean hasPermission(String userRole, String requiredRole) {
        if (userRole == null) return false;
        
        switch (userRole) {
            case "admin":
                return true; // Admin can access everything
            case "manager":
                return !requiredRole.equals("admin"); // Manager can't access admin pages
            case "viewer":
                return requiredRole.equals("viewer"); // Viewer can only access viewer pages
            default:
                return false;
        }
    }

    public static boolean canAccess(HttpServletRequest request, String path) {
        String userRole = (String) getAttribute(request, "role");
        
        // Admin can access everything
        if ("admin".equals(userRole)) {
            return true;
        }
        
        // Block admin paths for non-admins
        if (path.startsWith("/admin") && !"admin".equals(userRole)) {
            return false;
        }
        
        // Block manager paths for non-managers
        if (path.startsWith("/manager") && !("manager".equals(userRole) || "admin".equals(userRole))) {
            return false;
        }
        
        // Block edit/delete/add operations for viewers
        if ("viewer".equals(userRole)) {
            return !path.matches(".*(edit|delete|add|update|create).*");
        }
        
        return true;
    }

    public static void redirectBasedOnRole(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String userRole = (String) getAttribute(request, "role");
        String contextPath = request.getContextPath();
        
        switch (userRole) {
            case "admin":
                response.sendRedirect(contextPath + "/admin");
                break;
            case "manager":
                response.sendRedirect(contextPath + "/manager");
                break;
            case "viewer":
            default:
                response.sendRedirect(contextPath + "/home");
                break;
        }
    }
}