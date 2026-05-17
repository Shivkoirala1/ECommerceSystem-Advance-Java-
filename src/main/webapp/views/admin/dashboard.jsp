<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard - ShopNepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background: #f1f5f9; margin: 0; }
        .admin-wrap { display: flex; min-height: 100vh; }

        /* Sidebar */
        .admin-sidebar {
            width: 240px; background: #1e293b;
            display: flex; flex-direction: column;
            position: fixed; top: 0; left: 0;
            height: 100vh; z-index: 50;
        }
        .sidebar-logo {
            padding: 24px 20px; border-bottom: 1px solid rgba(255,255,255,.08);
        }
        .sidebar-logo a {
            color: #fff; font-size: 1.4rem;
            font-weight: 900; text-decoration: none;
        }
        .sidebar-logo a span { color: #ff6b00; }
        .sidebar-logo p { color: #94a3b8; font-size: .78rem; margin-top: 2px; }
        .sidebar-nav { padding: 16px 0; flex: 1; }
        .sidebar-nav a {
            display: flex; align-items: center; gap: 12px;
            color: #94a3b8; text-decoration: none;
            padding: 12px 20px; font-size: .93rem; font-weight: 600;
            border-left: 3px solid transparent;
            transition: all .2s;
        }
        .sidebar-nav a:hover { color: #fff; background: rgba(255,255,255,.05); }
        .sidebar-nav a.active {
            color: #fff; background: rgba(255,107,0,.15);
            border-left-color: #ff6b00;
        }
        .sidebar-nav .nav-icon { font-size: 1.1rem; width: 20px; text-align: center; }
        .sidebar-bottom {
            padding: 16px 0; border-top: 1px solid rgba(255,255,255,.08);
        }
        .sidebar-bottom a {
            display: flex; align-items: center; gap: 12px;
            color: #94a3b8; text-decoration: none;
            padding: 12px 20px; font-size: .9rem;
            transition: color .2s;
        }
        .sidebar-bottom a:hover { color: #ef4444; }

        /* Main area */
        .admin-main { margin-left: 240px; flex: 1; }

        /* Top bar */
        .admin-topbar {
            background: #fff; padding: 0 32px;
            height: 64px; display: flex;
            align-items: center; justify-content: space-between;
            box-shadow: 0 1px 4px rgba(0,0,0,.08);
            position: sticky; top: 0; z-index: 40;
        }
        .admin-topbar h1 { font-size: 1.1rem; font-weight: 700; color: #1e293b; }
        .admin-topbar .admin-info {
            display: flex; align-items: center; gap: 12px;
        }
        .admin-avatar {
            width: 38px; height: 38px; border-radius: 50%;
            background: linear-gradient(135deg, #ff6b00, #1e293b);
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-weight: 800; font-size: 1rem;
        }
        .admin-name { font-size: .9rem; font-weight: 600; color: #1e293b; }
        .admin-role { font-size: .75rem; color: #64748b; }

        /* Content */
        .admin-content { padding: 28px 32px; }

        /* Stat cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px; margin-bottom: 28px;
        }
        .stat-box {
            background: #fff; border-radius: 14px;
            padding: 24px; box-shadow: 0 1px 6px rgba(0,0,0,.07);
            display: flex; align-items: center; gap: 16px;
            transition: transform .2s;
        }
        .stat-box:hover { transform: translateY(-2px); }
        .stat-icon {
            width: 52px; height: 52px; border-radius: 12px;
            display: flex; align-items: center;
            justify-content: center; font-size: 1.5rem;
            flex-shrink: 0;
        }
        .stat-icon.orange { background: #fff7ed; }
        .stat-icon.blue   { background: #eff6ff; }
        .stat-icon.green  { background: #f0fdf4; }
        .stat-icon.purple { background: #faf5ff; }
        .stat-num { font-size: 1.8rem; font-weight: 900; color: #1e293b; line-height: 1; }
        .stat-label { font-size: .82rem; color: #64748b; margin-top: 3px; }

        /* Quick actions */
        .quick-actions {
            display: flex; gap: 12px; flex-wrap: wrap;
            margin-bottom: 28px;
        }
        .quick-btn {
            padding: 10px 20px; border-radius: 8px;
            font-weight: 700; text-decoration: none;
            font-size: .9rem; transition: opacity .2s;
        }
        .quick-btn:hover { opacity: .88; }
        .quick-btn.orange { background: #ff6b00; color: #fff; }
        .quick-btn.dark   { background: #1e293b; color: #fff; }
        .quick-btn.green  { background: #22c55e; color: #fff; }

        /* Cards */
        .dash-card {
            background: #fff; border-radius: 14px;
            box-shadow: 0 1px 6px rgba(0,0,0,.07);
            margin-bottom: 24px; overflow: hidden;
        }
        .dash-card-header {
            padding: 18px 24px; border-bottom: 1px solid #f1f5f9;
            display: flex; justify-content: space-between; align-items: center;
        }
        .dash-card-header h3 { font-size: 1rem; font-weight: 800; color: #1e293b; }
        .dash-card-header a {
            font-size: .85rem; color: #ff6b00;
            text-decoration: none; font-weight: 600;
        }
        .dash-card-body { padding: 0; }

        /* Table */
        table { width: 100%; border-collapse: collapse; }
        thead tr { background: #f8fafc; }
        thead th { padding: 12px 24px; text-align: left; font-size: .82rem; font-weight: 700; color: #64748b; text-transform: uppercase; letter-spacing: .5px; }
        tbody tr { border-bottom: 1px solid #f1f5f9; transition: background .15s; }
        tbody tr:hover { background: #fafafa; }
        tbody td { padding: 14px 24px; font-size: .9rem; color: #1e293b; }
        tbody tr:last-child { border-bottom: none; }

        /* Badges */
        .badge { display: inline-block; padding: 3px 10px; border-radius: 20px; font-size: .75rem; font-weight: 700; text-transform: uppercase; }
        .badge-pending    { background: #fef9c3; color: #854d0e; }
        .badge-processing { background: #dbeafe; color: #1d4ed8; }
        .badge-delivered  { background: #dcfce7; color: #15803d; }

        /* Alert */
        .alert { padding: 12px 18px; border-radius: 8px; margin-bottom: 18px; font-size: .95rem; }
        .alert-error { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }

        @media (max-width: 768px) {
            .admin-sidebar { display: none; }
            .admin-main { margin-left: 0; }
            .admin-content { padding: 16px; }
            .stats-grid { grid-template-columns: 1fr 1fr; }
        }
    </style>
</head>
<body>
<div class="admin-wrap">

    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="sidebar-logo">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Shop<span>Nepal</span></a>
            <p>Admin Panel</p>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
                <span class="nav-icon">📊</span> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/products">
                <span class="nav-icon">📦</span> Products
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders">
                <span class="nav-icon">🧾</span> Orders
            </a>
            <a href="${pageContext.request.contextPath}/admin/users">
                <span class="nav-icon">👥</span> Users
            </a>
        </nav>
        <div class="sidebar-bottom">
            <a href="${pageContext.request.contextPath}/logout">
                <span class="nav-icon">🚪</span> Logout
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <div class="admin-main">

        <!-- Top Bar -->
        <div class="admin-topbar">
            <h1>Dashboard Overview</h1>
            <div class="admin-info">
                <div>
                    <div class="admin-name">${sessionScope.user.fullName}</div>
                    <div class="admin-role">Administrator</div>
                </div>
                <div class="admin-avatar">
                    ${sessionScope.user.fullName.substring(0,1).toUpperCase()}
                </div>
            </div>
        </div>

        <div class="admin-content">
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-box">
                    <div class="stat-icon orange">📦</div>
                    <div>
                        <div class="stat-num">${totalProducts}</div>
                        <div class="stat-label">Total Products</div>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-icon blue">🧾</div>
                    <div>
                        <div class="stat-num">${totalOrders}</div>
                        <div class="stat-label">Total Orders</div>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-icon green">👥</div>
                    <div>
                        <div class="stat-num">${totalUsers}</div>
                        <div class="stat-label">Registered Users</div>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-icon purple">✅</div>
                    <div>
                        <div class="stat-num">${totalOrders}</div>
                        <div class="stat-label">Orders Today</div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/admin/products" class="quick-btn orange">➕ Add Product</a>
                <a href="${pageContext.request.contextPath}/admin/orders"   class="quick-btn dark">📋 View All Orders</a>
                <a href="${pageContext.request.contextPath}/admin/users"    class="quick-btn green">👥 Manage Users</a>
            </div>

            <!-- Recent Orders Table -->
            <div class="dash-card">
                <div class="dash-card-header">
                    <h3>📋 Recent Orders</h3>
                    <a href="${pageContext.request.contextPath}/admin/orders">View All →</a>
                </div>
                <div class="dash-card-body">
                    <table>
                        <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer ID</th>
                            <th>Amount</th>
                            <th>Items</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="o" items="${recentOrders}">
                            <tr>
                                <td><strong>#${o.id}</strong></td>
                                <td>User #${o.userId}</td>
                                <td><strong style="color:#ff6b00;">Rs ${o.totalPrice}</strong></td>
                                <td>${o.items.size()} item(s)</td>
                                <td style="color:#64748b;font-size:.85rem;">${o.orderDate}</td>
                                <td><span class="badge badge-${o.status.toLowerCase()}">${o.status}</span></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentOrders}">
                            <tr>
                                <td colspan="6" style="text-align:center;padding:32px;color:#94a3b8;">
                                    No orders yet. Orders will appear here once customers start purchasing.
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>
