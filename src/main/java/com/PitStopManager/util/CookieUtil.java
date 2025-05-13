package com.PitStopManager.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Utility class for handling HTTP cookies in the PitStop Manager web application.
 */
public class CookieUtil {
    
    /**
     * Adds a cookie to the HTTP response.
     *
     * @param response the HttpServletResponse to which the cookie will be added
     * @param name the name of the cookie
     * @param value the value of the cookie
     * @param maxAge the maximum age of the cookie in seconds (if negative, the cookie will be deleted when the browser is closed)
     */
    public static void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setPath("/");
        cookie.setMaxAge(maxAge);
        cookie.setHttpOnly(true); // Prevent JavaScript access (recommended)
        response.addCookie(cookie);
    }
    
    /**
     * Retrieves a cookie value by name.
     *
     * @param request the HttpServletRequest from which to get cookies
     * @param name the name of the cookie to retrieve
     * @return the value of the cookie, or null if not found
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
    
    /**
     * Deletes a cookie by setting its max age to 0.
     *
     * @param response the HttpServletResponse
     * @param name the name of the cookie to delete
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }
}
