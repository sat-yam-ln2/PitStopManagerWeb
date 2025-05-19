<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teams - PitStop Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/team.css">
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
                <li><a href="${pageContext.request.contextPath}/drivers">Drivers</a></li>
                <li><a href="${pageContext.request.contextPath}/contracts">Contracts</a></li>
                <li><a href="${pageContext.request.contextPath}/teams" class="active">Teams</a></li>
                <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="POST">
                        <button type="submit" class="logout-button">Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>

    <main class="teams-container">
        <h2 class="teams-title">Formula 1 Teams</h2>
        <div class="teams-grid">
            <c:forEach var="team" items="${teams}" varStatus="status">
                <div class="team-card">
                    <div class="team-header">
                        <span class="material-icons team-icon">groups</span>
                        <h3 class="team-name">${team.teamName}</h3>
                    </div>
                    <div class="team-details">
                        <p><strong>Principal:</strong> ${team.teamPrincipal}</p>
                        <p><strong>Base:</strong> ${team.baseLocation}</p>
                        <p><strong>Budget:</strong> $<fmt:formatNumber value="${team.teamBudget/1000000}" maxFractionDigits="2"/>M</p>
                        <p><strong>Team ID:</strong> ${team.teamId}</p>
                        <c:if test="${not empty teamDrivers[team.teamId]}">
                            <p><strong>Drivers:</strong> ${teamDrivers[team.teamId]}</p>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty teams}">
                <div class="empty-state">No teams found.</div>
            </c:if>
        </div>
    </main>

    <footer class="footer">
        <div class="container footer-content">
            <div class="footer-section about">
                <p>Your Ultimate F1 Team Management Solution v1.0.0</p>
            </div>
            <div class="footer-section links">
                <a href="${pageContext.request.contextPath}/home">Dashboard</a>
                <a href="${pageContext.request.contextPath}/drivers">Drivers</a>
                <a href="${pageContext.request.contextPath}/contracts">Contracts</a>
                <a href="${pageContext.request.contextPath}/teams">Teams</a>
                <a href="${pageContext.request.contextPath}/profile">Profile</a>
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
