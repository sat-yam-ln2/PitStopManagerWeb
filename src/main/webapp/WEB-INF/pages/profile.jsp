<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile - PitStop Manager</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/profile.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        .nav-menu form {
            margin: 0;
            padding: 0;
        }

        .nav-menu .logout-button {
            background: transparent;
            border: 0px solid var(--racing-blue);
            color: var(--silver-gray);
            padding: 0.3rem 1rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 1rem;
            font-family: inherit;
        }

        .nav-menu .logout-button:hover {
            background: var(--racing-red);
            border-color: var(--racing-red);
            color: var(--white);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="container nav-container">
            <div class="nav-brand">
                <img src="${pageContext.request.contextPath}/resources/images/icons/f1-icon.png" alt="F1 Icon" class="nav-logo" width="32" height="32">
                <h1>PitStop<span>Manager</span></h1>
            </div>
            <ul class="nav-menu">
                <li><a href="${pageContext.request.contextPath}/home">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/drivers.jsp">Drivers</a></li>
                <li><a href="${pageContext.request.contextPath}/contracts.jsp">Contracts</a></li>
                <li><a href="#">Teams</a></li>
                <li><a href="${pageContext.request.contextPath}/profile" class="active">Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="POST" style="margin: 0;">
                        <button type="submit" class="logout-button">Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>

    <main class="profile-container">
        <div class="profile-card">
            <div class="header-section">
                <h2>Profile Information</h2>
                <span class="role-badge ${user.role}">${user.role}</span>
            </div>
            
            <c:if test="${not empty message}">
                <div class="alert ${messageType}">${message}</div>
            </c:if>
            
            <form action="profile" method="POST" class="profile-form">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" value="${user.username}" required>
                </div>
                
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${user.email}" required>
                </div>
                
                <div class="form-group">
                    <label>Role</label>
                    <input type="text" value="${user.role}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Member Since</label>
                    <input type="text" value="${user.createdAt}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Last Login</label>
                    <input type="text" value="${user.lastLogin}" readonly>
                </div>
                
                <div class="password-section">
                    <h3>Change Password</h3>
                    <div class="form-group">
                        <label>Current Password</label>
                        <input type="password" name="currentPassword">
                    </div>
                    
                    <div class="form-group">
                        <label>New Password</label>
                        <input type="password" name="newPassword">
                    </div>
                    
                    <div class="form-group">
                        <label>Confirm New Password</label>
                        <input type="password" name="confirmPassword">
                    </div>
                </div>
                
                <button type="submit" class="update-btn">Update Profile</button>
            </form>

            <!-- Add Delete Account Section -->
            <div class="danger-zone">
                <h3>Danger Zone</h3>
                <p class="warning-text">Once you delete your account, there is no going back. Please be certain.</p>
                <form id="deleteAccountForm" action="${pageContext.request.contextPath}/profile" method="POST" onsubmit="return confirmDelete();">
                    <input type="hidden" name="action" value="delete_account">
                    <button type="submit" class="delete-account-btn">Delete Account</button>
                </form>
            </div>
        </div>
    </main>

    <!-- Add confirmation script -->
    <script>
        function confirmDelete() {
            return confirm("Are you absolutely sure you want to delete your account? This action cannot be undone!");
        }
    </script>

    <footer class="footer">
        <div class="container footer-content">
            <div class="footer-section about">
                <p>Your Ultimate F1 Team Management Solution v1.0.0</p>
            </div>
            <div class="footer-section links">
                <a href="#">Dashboard</a>
                <a href="#">Drivers</a>
                <a href="#">Contracts</a>
                <a href="#">Teams</a>
                <a href="#">Profile</a>
                <a href="#">Contact</a>
            </div>
            <div class="footer-section contact">
                <p>support@pitstopmanager.com</p>
                <div class="social-icons">
                    <a href="#" class="social-icon twitter"></a>
                    <a href="#" class="social-icon facebook"></a>
                    <a href="#" class="social-icon instagram"></a>
                </div>
                <p class="copyright">© 2025 PitStop Manager</p>
            </div>
        </div>
    </footer>
</body>
</html>