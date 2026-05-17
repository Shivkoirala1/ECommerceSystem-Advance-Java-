<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - ShopNepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .auth-wrapper { background: linear-gradient(135deg, #1e293b 0%, #ff6b00 100%); }
        .auth-box a { color: #ff6b00; }
        .btn-primary { background: #ff6b00 !important; }
    </style>
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box">
        <div style="text-align:center;margin-bottom:8px;">
            <a href="${pageContext.request.contextPath}/"
               style="color:#ff6b00;font-size:1.5rem;font-weight:900;text-decoration:none;">
                ShopNepal
            </a>
        </div>
        <h2>Welcome Back</h2>
        <p class="sub">Login to your ShopNepal account</p>

        <c:if test="${not empty param.error}">
            <div class="alert alert-error">${param.error}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter your username" required
                       value="${cookie['username'].value}">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="form-group" style="display:flex;align-items:center;gap:8px;">
                <input type="checkbox" name="remember" id="remember" style="width:auto;">
                <label for="remember" style="margin:0;font-weight:400;cursor:pointer;">Remember me</label>
            </div>
            <button type="submit" class="btn btn-primary btn-block" style="background:#ff6b00;">Login</button>
        </form>

        <div class="divider">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">Sign up free</a>
        </div>
        <div style="text-align:center;margin-top:8px;">
            <a href="${pageContext.request.contextPath}/"
               style="color:#64748b;font-size:.85rem;text-decoration:none;">
                ← Back to Home
            </a>
        </div>
    </div>
</div>
</body>
</html>
