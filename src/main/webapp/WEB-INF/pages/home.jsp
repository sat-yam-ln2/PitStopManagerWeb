<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - PitStop Manager</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
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
                <li><a href="${pageContext.request.contextPath}/home" class="active">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/drivers">Drivers</a></li>
                <li><a href="${pageContext.request.contextPath}/contracts">Contracts</a></li>
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

    <main class="main-content">
        <div class="container">
            <div class="metrics-grid">
                <div class="metric-card">
                    <div class="metric-icon drivers">
                        <span class="material-icons">sports_motorsports</span>
                    </div>
                    <div class="metric-info">
                        <h3>Total Drivers</h3>
                        <p class="metric-value">${totalDrivers}</p>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-icon contracts">
                        <span class="material-icons">description</span>
                    </div>
                    <div class="metric-info">
                        <h3>Active Contracts</h3>
                        <p class="metric-value">${activeContracts}</p>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-icon value">
                        <span class="material-icons">payments</span>
                    </div>
                    <div class="metric-info">
                        <h3>Avg. Market Value</h3>
                        <p class="metric-value">
                            $<fmt:formatNumber value="${avgMarketValue/1000000}" maxFractionDigits="2"/>M
                        </p>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-icon teams">
                        <span class="material-icons">groups</span>
                    </div>
                    <div class="metric-info">
                        <h3>Total Teams</h3>
                        <p class="metric-value">${totalTeams}</p>
                    </div>
                </div>
            </div>

            <!-- Additional Stats Section -->
            <div class="metrics-grid">
                <div class="metric-card">
                    <div class="metric-info">
                        <h3>Highest Paid Contract</h3>
                        <p class="metric-value">${highestPaidDriver} <span style="font-size:1rem;">($<fmt:formatNumber value="${highestPaidFee/1000000}" maxFractionDigits="2"/>M)</span></p>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-info">
                        <h3>Youngest Driver</h3>
                        <p class="metric-value">${youngestDriver} <span style="font-size:1rem;">(${youngestAge} yrs)</span></p>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-info">
                        <h3>Oldest Driver</h3>
                        <p class="metric-value">${oldestDriver} <span style="font-size:1rem;">(${oldestAge} yrs)</span></p>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-info">
                        <h3>Top Team (by Points)</h3>
                        <p class="metric-value">${topTeam} <span style="font-size:1rem;">(${topTeamPoints} pts)</span></p>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-info">
                        <h3>Avg. Driver Age</h3>
                        <p class="metric-value"><fmt:formatNumber value="${avgDriverAge}" maxFractionDigits="1"/> yrs</p>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-info">
                        <h3>Total Market Value</h3>
                        <p class="metric-value">$<fmt:formatNumber value="${totalMarketValue/1000000}" maxFractionDigits="2"/>M</p>
                    </div>
                </div>
            </div>

            <div class="chart-section">
                <div class="chart-header">
                    <h2>Top 5 Drivers by Market Value</h2>
                </div>
                <!-- Debug output -->
                <div style="display:none">
                    Debug: ${topDrivers}
                </div>
                <div class="chart-container">
                    <div class="market-value-data">
                        <c:choose>
                            <c:when test="${not empty topDrivers}">
                                <c:forEach var="driver" items="${topDrivers}" varStatus="status">
                                    <div class="data-point" style="background:rgba(0,144,255,0.08);border:1px solid #0090ff;">
                                        <div class="date" style="font-weight:600;color:#222;">
                                            <span style="color:#E10600;font-size:1.2em;">&#x1F3C1;</span>
                                            ${driver.name}
                                        </div>
                                        <div class="value" style="color:#0090FF;font-size:1.3em;">
                                            $<fmt:formatNumber value="${driver.value/1000000}" maxFractionDigits="2"/>M
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:forEach begin="${fn:length(topDrivers)+1}" end="5" var="i">
                                    <div class="data-point" style="opacity:0.5;">
                                        <div class="date" style="color:#aaa;">No driver</div>
                                        <div class="value" style="color:#bbb;">--</div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="data-point" style="text-align:center; color:#aaa; font-size:1.1em; width:100%;">
                                    <span style="font-size:2em; color:#E10600;">&#9888;</span><br>
                                    No driver market value data available.
                                </div>
                            </c:otherwise>
                        </c:choose>
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
