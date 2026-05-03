<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - ECommerce System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box">
        <h2>Create Account</h2>
        <p class="sub">Join ECommerce System today</p>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/register">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" placeholder="e.g. John Doe" required>
            </div>
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="4-20 characters" required>
            </div>
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="you@example.com" required>
            </div>
            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="10 digit number" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Min 6 chars, 1 uppercase, 1 number" required>
            </div>
            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" placeholder="Repeat password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Create Account</button>
        </form>

        <div class="divider">Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></div>
    </div>
</div>
</body>
</html>
