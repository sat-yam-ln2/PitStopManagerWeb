<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Drivers - PitStop Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/drivers.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    <!-- Navbar -->
    <nav class="navbar">
        <div class="container nav-container">
            <div class="nav-brand">
                <img src="${pageContext.request.contextPath}/resources/images/icons/f1-icon.png" alt="F1 Icon" class="nav-logo" width="32" height="32">
                <h1>PitStop<span>Manager</span></h1>
            </div>
            <ul class="nav-menu">
                <li><a href="${pageContext.request.contextPath}/home">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/drivers" class="active">Drivers</a></li>
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

    <main class="drivers-container">
        <!-- Filters Panel -->
        <div class="filters-panel">
            <h2>Filter Drivers</h2>
            <form id="filterForm" class="filter-controls" method="post" action="${pageContext.request.contextPath}/drivers">
                <div class="filter-group">
                    <label>Team</label>
                    <select id="teamFilter" name="teamId">
                        <option value="">All Teams</option>
                        <c:forEach var="team" items="${teams}">
                            <option value="${team.teamId}" <c:if test="${param.teamId == team.teamId}">selected</c:if>>${team.teamName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="filter-group">
                    <label>Age Range</label>
                    <div style="display: flex; gap: 0.5rem;">
                        <input type="number" id="ageMin" name="ageMin" placeholder="Min Age" min="18" max="50" value="${param.ageMin}">
                        <input type="number" id="ageMax" name="ageMax" placeholder="Max Age" min="18" max="50" value="${param.ageMax}">
                    </div>
                </div>
                <div class="filter-group">
                    <label>Minimum Points</label>
                    <input type="number" id="pointsMin" name="pointsMin" placeholder="Min Points" min="0" value="${param.pointsMin}">
                </div>
                <div class="filter-group">
                    <label>Minimum Market Value (M)</label>
                    <input type="number" id="marketValueMin" name="marketValueMin" placeholder="Min Value in Millions" min="0" value="${param.marketValueMin}">
                </div>
                <div class="filter-buttons">
                    <button type="submit" class="btn-filter">Apply Filters</button>
                    <button type="reset" class="btn-reset" onclick="window.location='${pageContext.request.contextPath}/drivers';return false;">Reset</button>
                </div>
            </form>
        </div>

        <!-- Drivers Grid -->
        <div class="drivers-grid">
            <c:forEach var="driver" items="${drivers}">
                <div class="driver-card" id="driver-card-${driver.driverId}">
                    <div class="driver-header">
                        <div class="driver-avatar">
                            ${driver.driverName.charAt(0)}
                        </div>
                        <div class="driver-info">
                            <h3>${driver.driverName}</h3>
                            <p>Age: ${driver.age}</p>
                        </div>
                    </div>
                    <div class="driver-stats">
                        <div class="stat-item">
                            <div class="stat-label">Race Wins</div>
                            <div class="stat-value">${driver.raceWins}</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">Points</div>
                            <div class="stat-value">${driver.pointsScored}</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">Market Value</div>
                            <div class="stat-value">
                                $<fmt:formatNumber value="${driver.marketValue/1000000}" maxFractionDigits="1"/>M
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">Consistency</div>
                            <div class="stat-value">${driver.consistencyRating}</div>
                        </div>
                    </div>
                    <canvas id="radar-${driver.driverId}" class="performance-chart"
                        data-racewins="${driver.raceWins}"
                        data-podiums="${driver.podiumFinishes}"
                        data-fastestlaps="${driver.fastestLaps}"
                        data-points="${driver.pointsScored}"
                        data-consistency="${driver.consistencyRating}">
                    </canvas>
                </div>
            </c:forEach>
        </div>

        <!-- Charts Section -->
        <div class="chart-container">
            <h2>Age Distribution</h2>
            <canvas id="ageChart"></canvas>
        </div>

        <div class="chart-container">
            <h2>Market Value Comparison</h2>
            <canvas id="marketValueChart"></canvas>
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

    <script>
    // Radar charts for each driver
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.performance-chart').forEach(function(canvas) {
            const raceWins = parseInt(canvas.dataset.racewins);
            const podiums = parseInt(canvas.dataset.podiums);
            const fastestLaps = parseInt(canvas.dataset.fastestlaps);
            const points = parseInt(canvas.dataset.points);
            const consistency = parseFloat(canvas.dataset.consistency);

            new Chart(canvas, {
                type: 'radar',
                data: {
                    labels: ['Race Wins', 'Podiums', 'Fastest Laps', 'Points', 'Consistency'],
                    datasets: [{
                        label: 'Performance',
                        data: [
                            raceWins,
                            podiums,
                            fastestLaps,
                            Math.round(points/100), // scale for visualization
                            consistency
                        ],
                        backgroundColor: 'rgba(255, 0, 0, 0.2)',
                        borderColor: 'rgba(255, 0, 0, 0.8)',
                        pointBackgroundColor: 'rgba(255, 0, 0, 1)'
                    }]
                },
                options: {
                    responsive: true, // <-- ensure this is true
                    plugins: { legend: { display: false } },
                    scales: {
                        r: {
                            beginAtZero: true,
                            min: 0,
                            max: 10
                        }
                    }
                }
            });
        });

        // Age Distribution Chart
        const ageGroups = [0,0,0,0];
        document.querySelectorAll('.driver-card').forEach(card => {
            const age = parseInt(card.querySelector('.driver-info p').textContent.replace(/\D/g,''));
            if (age <= 25) ageGroups[0]++;
            else if (age <= 30) ageGroups[1]++;
            else if (age <= 35) ageGroups[2]++;
            else ageGroups[3]++;
        });
        new Chart(document.getElementById('ageChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: ['18-25', '26-30', '31-35', '36+'],
                datasets: [{
                    label: 'Drivers by Age Group',
                    data: ageGroups,
                    backgroundColor: 'rgba(255, 0, 0, 0.7)',
                    borderColor: 'rgba(255, 0, 0, 1)',
                    borderWidth: 1,
                    borderRadius: 8,
                    barPercentage: 0.5,
                    categoryPercentage: 0.5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                layout: { padding: { top: 20, bottom: 20, left: 10, right: 10 } },
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { font: { size: 14 } }
                    },
                    y: {
                        beginAtZero: true,
                        ticks: { stepSize: 1, font: { size: 14 } },
                        grid: { color: 'rgba(0,0,0,0.05)' }
                    }
                }
            }
        });

        // Market Value Comparison Chart
        const driverNames = [];
        const marketValues = [];
        document.querySelectorAll('.driver-card').forEach(card => {
            driverNames.push(card.querySelector('.driver-info h3').textContent);
            marketValues.push(parseFloat(card.querySelectorAll('.stat-value')[2].textContent.replace(/[^0-9.]/g, '')));
        });
        new Chart(document.getElementById('marketValueChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: driverNames,
                datasets: [{
                    label: 'Market Value (in $M)',
                    data: marketValues,
                    backgroundColor: 'rgba(0, 144, 255, 0.7)',
                    borderColor: 'rgba(0, 144, 255, 1)',
                    borderWidth: 1,
                    borderRadius: 8,
                    barPercentage: 0.5,
                    categoryPercentage: 0.5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                layout: { padding: { top: 20, bottom: 20, left: 10, right: 10 } },
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { font: { size: 12 }, autoSkip: false, maxRotation: 45, minRotation: 20 }
                    },
                    y: {
                        beginAtZero: true,
                        ticks: { font: { size: 14 } },
                        grid: { color: 'rgba(0,0,0,0.05)' }
                    }
                }
            }
        });
    });
    </script>
</body>
</html>
