<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><title>Shop - ECommerce</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head><body>
<nav class="navbar">
    <a class="brand" href="#">E<span>Commerce</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/customer/products">🏠 Shop</a></li>
        <li><a href="${pageContext.request.contextPath}/cart">🛒 Cart</a></li>
        <li><a href="${pageContext.request.contextPath}/order/history">📦 My Orders</a></li>
        <li><span style="color:#94a3b8;">Hi, ${sessionScope.user.fullName}</span></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>
<div class="main-content" style="padding:28px 32px;">
    <h2 style="margin-bottom:20px;">Browse Products</h2>
    <c:if test="${not empty param.success}"><div class="alert alert-success">${param.success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

    <!-- Search Bar -->
    <form method="get" action="${pageContext.request.contextPath}/customer/products" class="search-bar">
        <input type="text" name="search" placeholder="Search products by name or category..." value="${search}">
        <button type="submit" class="btn btn-primary">Search</button>
        <a href="${pageContext.request.contextPath}/customer/products" class="btn btn-secondary">Clear</a>
    </form>

    <!-- Product Grid -->
    <div class="product-grid">
        <c:forEach var="p" items="${products}">
            <div class="product-card">
                <div class="p-cat">${p.category}</div>
                <div class="p-name">${p.name}</div>
                <div style="color:#64748b;font-size:.88rem;">${p.description}</div>
                <div class="p-price">Rs ${p.price}</div>
                <div class="p-stock">Stock: ${p.stock}</div>
                <div class="p-actions">
                    <c:choose>
                        <c:when test="${p.stock > 0}">
                            <form method="post" action="${pageContext.request.contextPath}/cart" style="display:flex;gap:6px;align-items:center;flex:1;">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${p.id}">
                                <input type="number" name="quantity" value="1" min="1" max="${p.stock}"
                                       style="width:60px;padding:6px;border:1px solid #e2e8f0;border-radius:6px;">
                                <button type="submit" class="btn btn-primary btn-sm">Add to Cart</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <span style="color:#ef4444;font-weight:600;">Out of Stock</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty products}">
            <div class="card" style="width:100%;text-align:center;color:#64748b;">
                No products found. <a href="${pageContext.request.contextPath}/customer/products">View all products</a>
            </div>
        </c:if>
    </div>
</div>
</body></html>
