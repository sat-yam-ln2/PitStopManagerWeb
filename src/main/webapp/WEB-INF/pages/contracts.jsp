<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contracts - PitStop Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contracts.css">
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
                <li><a href="${pageContext.request.contextPath}/contracts" class="active">Contracts</a></li>
                <li><a href="${pageContext.request.contextPath}/teams">Teams</a></li>
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

    <div class="contracts-container">
        <div class="contracts-header">
            <h2>Driver Contracts</h2>
            <form class="search-bar" method="get" action="${pageContext.request.contextPath}/contracts">
                <input type="text" name="search" placeholder="Search by driver name..." value="${search}">
                <button type="submit">Search</button>
            </form>
        </div>
        <table class="contracts-table">
            <thead>
                <tr>
                    <th>Contract ID</th>
                    <th>Driver Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Transfer Fee</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="contract" items="${contracts}">
                    <tr>
                        <td>${contract.contractId}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty contract.driverName}">
                                    ${contract.driverName}
                                </c:when>
                                <c:otherwise>
                                    ${contract.driverId}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${contract.startDateStr}</td>
                        <td>${contract.endDateStr}</td>
                        <td class="fee">$<fmt:formatNumber value="${contract.transferFee/1000000}" maxFractionDigits="2"/>M</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${empty contracts}">
            <div style="text-align:center; color:var(--racing-red); margin-top:2rem;">No contracts found.</div>
        </c:if>
    </div>

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
