<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><title>Admin Dashboard</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head><body>
<nav class="navbar">
    <a class="brand" href="#">E<span>Commerce</span></a>
    <ul class="nav-links">
        <li><span style="color:#94a3b8;">Welcome, ${sessionScope.user.fullName}</span></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>
<div class="layout">
    <div class="sidebar">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">📊 Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/products">📦 Products</a>
        <a href="${pageContext.request.contextPath}/admin/orders">🧾 Orders</a>
        <a href="${pageContext.request.contextPath}/admin/users">👥 Users</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>
    <div class="main-content">
        <h2 style="margin-bottom:24px;">Admin Dashboard</h2>
        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>
        <div class="stats-row">
            <div class="stat-card"><div class="stat-num">${totalProducts}</div><div class="stat-label">Total Products</div></div>
            <div class="stat-card"><div class="stat-num">${totalOrders}</div><div class="stat-label">Total Orders</div></div>
            <div class="stat-card"><div class="stat-num">${totalUsers}</div><div class="stat-label">Total Users</div></div>
        </div>
        <div class="card">
            <div class="card-title">Recent Orders</div>
            <div class="table-wrap">
                <table>
                    <thead><tr><th>Order ID</th><th>Customer ID</th><th>Total</th><th>Status</th><th>Date</th></tr></thead>
                    <tbody>
                    <c:forEach var="o" items="${recentOrders}">
                        <tr>
                            <td data-label="Order ID">#${o.id}</td>
                            <td data-label="Customer ID">${o.userId}</td>
                            <td data-label="Total">Rs ${o.totalPrice}</td>
                            <td data-label="Status"><span class="badge badge-${o.status.toLowerCase()}">${o.status}</span></td>
                            <td data-label="Date">${o.orderDate}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty recentOrders}">
                        <tr><td colspan="5" style="text-align:center;color:#64748b;">No orders yet.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body></html>
