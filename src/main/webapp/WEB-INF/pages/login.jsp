<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PitStop Manager</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
    <div class="auth-container">
        <div class="ambient-light"></div>
        <div class="auth-card">
            <div class="auth-header">
                <h2>Welcome Back</h2>
                <p>Sign in to your PitStop Manager account</p>
            </div>
            <div class="auth-body">
                <form action="login" method="POST" class="auth-form">
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" placeholder="Enter your email">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" placeholder="Enter your password">
                    </div>
                    <label class="checkmark-container">
                        Remember me
                        <input type="checkbox">
                        <span class="checkmark"></span>
                    </label>
                    <div class="button-container">
                        <button type="submit" class="btn">Sign In</button>
                    </div>
                </form>
            </div>
            <div class="auth-footer center-text">
                <p>Don't have an account? <a href="signup">Sign Up</a></p>
            </div>
        </div>
    </div>
</body>
</html>
