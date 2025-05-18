<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us - PitStop Manager</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/about.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
    <!-- Navbar (matching home.jsp) -->
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
                <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/about" class="active">About</a></li>
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="POST">
                        <button type="submit" class="logout-button">Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="about-hero">
        <div class="hero-content">
            <h1 class="hero-title">Formula 1 Management Reimagined</h1>
            <p class="hero-subtitle">Revolutionizing the way teams manage their Formula 1 operations with cutting-edge technology and real-time insights.</p>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="features-grid">
            <div class="feature-card">
                <span class="material-icons feature-icon">speed</span>
                <h3 class="feature-title">Real-time Analytics</h3>
                <p class="feature-description">Track driver performance, team statistics, and race data in real-time with our advanced analytics dashboard.</p>
            </div>
            <div class="feature-card">
                <span class="material-icons feature-icon">people</span>
                <h3 class="feature-title">Team Management</h3>
                <p class="feature-description">Efficiently manage your racing team, from driver contracts to support staff coordination.</p>
            </div>
            <div class="feature-card">
                <span class="material-icons feature-icon">trending_up</span>
                <h3 class="feature-title">Performance Tracking</h3>
                <p class="feature-description">Monitor and analyze driver performance metrics to make data-driven decisions.</p>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">500+</div>
                <div class="stat-label">Active Users</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">20+</div>
                <div class="stat-label">Racing Teams</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">100+</div>
                <div class="stat-label">Managed Contracts</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">99.9%</div>
                <div class="stat-label">Uptime</div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="team-section">
        <h2 class="section-title">Meet Our Team</h2>
        <div class="team-grid">
            <div class="team-member">
                <div class="member-avatar" style="background: linear-gradient(135deg, #00D2BE, #00B0A1)">JD</div>
                <h3 class="member-name">John Doe</h3>
                <p class="member-role">Lead Developer</p>
                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-linkedin"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-github"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
            <div class="team-member">
                <div class="member-avatar" style="background: linear-gradient(135deg, #FF8700, #FF6B00)">JS</div>
                <h3 class="member-name">Jane Smith</h3>
                <p class="member-role">UI/UX Designer</p>
                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-linkedin"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-github"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
            <div class="team-member">
                <div class="member-avatar" style="background: linear-gradient(135deg, #0090FF, #0076D6)">MJ</div>
                <h3 class="member-name">Mike Johnson</h3>
                <p class="member-role">Data Analyst</p>
                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-linkedin"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-github"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer (reusing from other pages) -->
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
