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

        .delete-account-section {
            margin-top: 2rem;
            padding: 2rem;
            border-top: 1px solid rgba(255, 0, 0, 0.1);
            text-align: center;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
        }

        .delete-account-section h3 {
            color: var(--racing-red);
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .warning-text {
            color: #666;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }

        .btn-delete-account {
            background-color: var(--racing-red);
            color: white;
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            opacity: 0.9;
        }

        .btn-delete-account:hover {
            opacity: 1;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 0, 0, 0.2);
        }

        .confirmation-dialog {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            display: none;
        }

        .dialog-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
            display: none;
        }

        .dialog-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 1.5rem;
        }

        .btn-confirm-delete {
            background: var(--racing-red);
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-cancel-delete {
            background: #666;
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-confirm-delete:hover,
        .btn-cancel-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .profile-container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 2rem;
        }

        .profile-card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .role-badge {
            padding: 0.5rem 1rem;
            border-radius: 16px;
            font-size: 0.875rem;
            font-weight: 500;
            text-transform: uppercase;
        }

        .profile-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-group label {
            color: var(--dark-charcoal);
            font-weight: 500;
        }

        .form-group input {
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
        }

        .btn-update {
            background: var(--racing-blue);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 144, 255, 0.2);
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        .alert.success {
            background: rgba(76, 175, 80, 0.1);
            color: #4CAF50;
            border: 1px solid #4CAF50;
        }

        .alert.error {
            background: rgba(244, 67, 54, 0.1);
            color: #f44336;
            border: 1px solid #f44336;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .modal-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 1.5rem;
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
                <li><a href="${pageContext.request.contextPath}/drivers">Drivers</a></li>
                <li><a href="${pageContext.request.contextPath}/contracts">Contracts</a></li>
                <li><a href="${pageContext.request.contextPath}/teams">Teams</a></li>
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
            
            <form action="${pageContext.request.contextPath}/profile" method="POST" class="profile-form">
                <input type="hidden" name="action" value="update">
                
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" value="${user.username}" required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${user.email}" required>
                </div>

                <div class="form-group">
                    <label>New Password (leave blank to keep current)</label>
                    <input type="password" name="newPassword">
                </div>

                <div class="form-group">
                    <label>Confirm Password (required for any changes)</label>
                    <input type="password" name="currentPassword" required>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn-update">Update Profile</button>
                </div>
            </form>

            <!-- Delete Account Section -->
            <div class="delete-account-section">
                <h3>Delete Account</h3>
                <p class="warning-text">Warning: This action cannot be undone.</p>
                <button type="button" class="btn-delete-account" onclick="showDeleteConfirmation()">Delete Account</button>
            </div>

            <!-- Delete Confirmation Dialog -->
            <div id="deleteDialog" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="hideDeleteConfirmation()">&times;</span>
                    <h3>Confirm Account Deletion</h3>
                    <p>Are you sure you want to delete your account? This cannot be undone.</p>
                    <div class="modal-buttons">
                        <form action="${pageContext.request.contextPath}/profile" method="POST">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="btn-confirm-delete">Yes, Delete Account</button>
                            <button type="button" class="btn-cancel" onclick="hideDeleteConfirmation()">Cancel</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

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

    <script>
        function showDeleteConfirmation() {
            document.getElementById('deleteDialog').style.display = 'block';
        }

        function hideDeleteConfirmation() {
            document.getElementById('deleteDialog').style.display = 'none';
        }
    </script>
</body>
</html>