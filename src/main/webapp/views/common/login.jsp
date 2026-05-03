<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - ECommerce System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box">
        <h2>Welcome Back</h2>
        <p class="sub">Login to your ECommerce account</p>

        <c:if test="${not empty param.error}">
            <div class="alert alert-error">${param.error}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>

        <c:set var="rememberUsername" value="" />
        <c:if test="${cookie.username != null}">
            <c:set var="rememberUsername" value="${cookie.username.value}" />
        </c:if>
        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter username" required
                       value="<c:out value='${rememberUsername}' />">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required>
            </div>
            <div class="form-group" style="display:flex;align-items:center;gap:8px;">
                <input type="checkbox" name="remember" id="remember" style="width:auto;">
                <label for="remember" style="margin:0;font-weight:400;">Remember me</label>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Login</button>
        </form>

        <div class="divider">Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></div>
    </div>
</div>
</body>
</html>
