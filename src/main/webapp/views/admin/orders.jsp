<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><title>Manage Orders</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head><body>
<nav class="navbar">
    <a class="brand" href="#">E<span>Commerce</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>
<div class="layout">
    <div class="sidebar">
        <a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/products">📦 Products</a>
        <a href="${pageContext.request.contextPath}/admin/orders" class="active">🧾 Orders</a>
        <a href="${pageContext.request.contextPath}/admin/users">👥 Users</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>
    <div class="main-content">
        <h2 style="margin-bottom:24px;">All Orders</h2>
        <c:if test="${not empty param.success}"><div class="alert alert-success">${param.success}</div></c:if>
        <div class="card">
            <div class="table-wrap">
                <table>
                    <thead><tr><th>Order ID</th><th>Customer ID</th><th>Total</th><th>Items</th><th>Address</th><th>Date</th><th>Status</th><th>Update</th></tr></thead>
                    <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td data-label="ID">#${o.id}</td>
                            <td data-label="Customer">${o.userId}</td>
                            <td data-label="Total">Rs ${o.totalPrice}</td>
                            <td data-label="Items">${o.items.size()} item(s)</td>
                            <td data-label="Address">${o.deliveryAddress}</td>
                            <td data-label="Date">${o.orderDate}</td>
                            <td data-label="Status"><span class="badge badge-${o.status.toLowerCase()}">${o.status}</span></td>
                            <td data-label="Update">
                                <form method="post" action="${pageContext.request.contextPath}/admin/orders" style="display:flex;gap:6px;">
                                    <input type="hidden" name="orderId" value="${o.id}">
                                    <select name="status" style="padding:4px 8px;border-radius:6px;border:1px solid #e2e8f0;">
                                        <option value="PENDING" ${o.status=='PENDING'?'selected':''}>Pending</option>
                                        <option value="PROCESSING" ${o.status=='PROCESSING'?'selected':''}>Processing</option>
                                        <option value="DELIVERED" ${o.status=='DELIVERED'?'selected':''}>Delivered</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty orders}">
                        <tr><td colspan="8" style="text-align:center;color:#64748b;">No orders yet.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body></html>
