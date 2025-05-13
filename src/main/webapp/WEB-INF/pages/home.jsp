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
				    <li><a href="#" class="active">Dashboard</a></li>
				    <li><a href="${pageContext.request.contextPath}/drivers.jsp">Drivers</a></li>
				    <li><a href="${pageContext.request.contextPath}/contracts.jsp">Contracts</a></li>
				    <li><a href="#">Teams</a></li>
				    <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
				    <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
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
                        <p class="metric-value">24</p>
                        <span class="metric-trend positive">+2 this season</span>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-icon contracts">
                        <span class="material-icons">description</span>
                    </div>
                    <div class="metric-info">
                        <h3>Active Contracts</h3>
                        <p class="metric-value">18</p>
                        <span class="metric-trend negative">-1 this season</span>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-icon value">
                        <span class="material-icons">payments</span>
                    </div>
                    <div class="metric-info">
                        <h3>Avg. Market Value</h3>
                        <p class="metric-value">$12.5M</p>
                        <span class="metric-trend positive">+5% this season</span>
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-icon teams">
                        <span class="material-icons">groups</span>
                    </div>
                    <div class="metric-info">
                        <h3>Total Teams</h3>
                        <p class="metric-value">10</p>
                    </div>
                </div>
            </div>

            <div class="chart-section">
                <div class="chart-header">
                    <h2>Market Value Trends</h2>
                    <div class="chart-controls">
                        <button class="btn-outline active">Week</button>
                        <button class="btn-outline">Month</button>
                    </div>
                </div>
                <div class="chart-container">
                    <div class="market-value-data">
                        <div class="data-point">
                            <div class="date">Mon, 15 Jan</div>
                            <div class="value">$12.5M</div>
                        </div>
                        <div class="data-point">
                            <div class="date">Tue, 16 Jan</div>
                            <div class="value">$12.8M</div>
                        </div>
                        <div class="data-point">
                            <div class="date">Wed, 17 Jan</div>
                            <div class="value">$13.2M</div>
                        </div>
                        <div class="data-point">
                            <div class="date">Thu, 18 Jan</div>
                            <div class="value">$13.5M</div>
                        </div>
                        <div class="data-point">
                            <div class="date">Fri, 19 Jan</div>
                            <div class="value">$13.8M</div>
                        </div>
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
                <p class="copyright">� 2025 PitStop Manager</p>
            </div>
        </div>
    </footer>
</body>
</html>
