<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - PitStop Manager</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h2>Create Account</h2>
                <p>Join PitStop Manager to manage F1 drivers and teams</p>
            </div>
            <div class="auth-body">
                <form class="auth-form" action="signup" method="POST">
                    <!-- Full Name Field -->
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="username" placeholder="Enter your full name" value="${username}">
                        <c:if test="${not empty usernameError}">
                            <p class="error">${usernameError}</p>
                        </c:if>
                    </div>

                    <!-- Email Field -->
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" placeholder="Enter your email" value="${email}">
                        <c:if test="${not empty emailError}">
                            <p class="error">${emailError}</p>
                        </c:if>
                    </div>

                    <!-- Password Field -->
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" placeholder="Create a password">
                        <c:if test="${not empty passwordError}">
                            <p class="error">${passwordError}</p>
                        </c:if>
                    </div>

                    <!-- Confirm Password Field -->
                    <div class="form-group">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm your password">
                        <c:if test="${not empty confirmPasswordError}">
                            <p class="error">${confirmPasswordError}</p>
                        </c:if>
                    </div>

                    <!-- Terms Agreement Checkbox -->
                    <label class="checkmark-container">
                        I agree to the Terms and Privacy Policy
                        <input type="checkbox" name="terms">
                        <span class="checkmark"></span>
                        <c:if test="${not empty termsError}">
                            <p class="error">${termsError}</p>
                        </c:if>
                    </label>

                    <!-- Submit Button -->
                    <div class="center-text">
                        <button type="submit" class="btn">Create Account</button>
                    </div>
                </form>
            </div>

            <!-- Footer with Login Link -->
            <div class="auth-footer center-text">
                <p>Already have an account? <a href="login">Sign In</a></p>
            </div>
        </div>
    </div>
</body>
</html>
