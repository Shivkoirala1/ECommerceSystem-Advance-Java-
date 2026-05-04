<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><title>My Orders - ECommerce</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head><body>
<nav class="navbar">
    <a class="brand" href="#">E<span>Commerce</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/customer/products">🏠 Shop</a></li>
        <li><a href="${pageContext.request.contextPath}/cart">🛒 Cart</a></li>
        <li><a href="${pageContext.request.contextPath}/order/history" class="active">📦 My Orders</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>
<div class="main-content" style="padding:28px 32px;">
    <h2 style="margin-bottom:20px;">📦 My Orders</h2>
    <c:if test="${not empty param.success}"><div class="alert alert-success">${param.success}</div></c:if>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="card" style="text-align:center;padding:40px;">
                <p style="color:#64748b;margin-bottom:16px;">You have no orders yet.</p>
                <a href="${pageContext.request.contextPath}/customer/products" class="btn btn-primary">Start Shopping</a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="o" items="${orders}">
                <div class="card">
                    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:12px;">
                        <div>
                            <strong>Order #${o.id}</strong>
                            <span style="color:#64748b;margin-left:12px;font-size:.9rem;">${o.orderDate}</span>
                        </div>
                        <span class="badge badge-${o.status.toLowerCase()}">${o.status}</span>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead><tr><th>Product</th><th>Qty</th><th>Unit Price</th><th>Total</th></tr></thead>
                            <tbody>
                            <c:forEach var="item" items="${o.items}">
                                <tr>
                                    <td>${item.product.name}</td>
                                    <td>${item.quantity}</td>
                                    <td>Rs ${item.product.price}</td>
                                    <td>Rs ${item.lineTotal}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div style="text-align:right;margin-top:10px;font-weight:700;color:#2563eb;">
                        Order Total: Rs ${o.totalPrice}
                    </div>
                    <div style="color:#64748b;font-size:.9rem;margin-top:4px;">
                        Delivery Address: ${o.deliveryAddress}
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    <a href="${pageContext.request.contextPath}/customer/products" class="btn btn-secondary">← Continue Shopping</a>
</div>
</body></html>
