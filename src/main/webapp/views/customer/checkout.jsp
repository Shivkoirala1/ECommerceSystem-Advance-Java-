<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Checkout - ShopNepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body{background:#f5f5f5;margin:0;}
        .shop-nav{background:#ff6b00;padding:0 32px;display:flex;align-items:center;justify-content:space-between;height:64px;box-shadow:0 2px 8px rgba(0,0,0,.15);}
        .shop-nav .logo{color:#fff;font-size:1.5rem;font-weight:900;text-decoration:none;}
        .shop-nav .logo span{color:#ffe066;}
        .shop-nav .nav-right a{color:#fff;text-decoration:none;padding:7px 14px;border-radius:4px;font-size:.9rem;font-weight:600;}
        .checkout-wrap{max-width:900px;margin:28px auto;padding:0 24px;}
        .checkout-grid{display:grid;grid-template-columns:1fr 340px;gap:24px;}
        .form-card{background:#fff;border-radius:12px;box-shadow:0 1px 6px rgba(0,0,0,.08);padding:24px;}
        .form-card h3{font-size:1.1rem;font-weight:800;color:#1e293b;margin-bottom:18px;padding-bottom:12px;border-bottom:2px solid #f1f5f9;}
        .form-group{margin-bottom:16px;}
        .form-group label{display:block;margin-bottom:6px;font-weight:600;font-size:.88rem;color:#374151;}
        .form-group input,.form-group textarea{width:100%;padding:10px 14px;border:1.5px solid #e2e8f0;border-radius:8px;font-size:.95rem;font-family:inherit;box-sizing:border-box;transition:border .2s;}
        .form-group input:focus,.form-group textarea:focus{border-color:#ff6b00;outline:none;}
        .form-group input:disabled{background:#f8fafc;color:#64748b;}
        .btn-place{display:block;width:100%;background:#ff6b00;color:#fff;border:none;border-radius:8px;padding:14px;font-size:1rem;font-weight:800;cursor:pointer;transition:background .2s;}
        .btn-place:hover{background:#e05a00;}
        .btn-back{display:block;text-align:center;color:#64748b;font-size:.88rem;text-decoration:none;margin-top:10px;}
        .summary-card{background:#fff;border-radius:12px;box-shadow:0 1px 6px rgba(0,0,0,.08);padding:24px;height:fit-content;position:sticky;top:80px;}
        .summary-card h3{font-size:1.1rem;font-weight:800;color:#1e293b;margin-bottom:16px;padding-bottom:12px;border-bottom:2px solid #f1f5f9;}
        .s-item{display:flex;justify-content:space-between;padding:8px 0;border-bottom:1px solid #f8fafc;font-size:.9rem;}
        .s-item:last-child{border-bottom:none;}
        .s-total{display:flex;justify-content:space-between;padding-top:12px;border-top:2px solid #f1f5f9;margin-top:8px;font-weight:800;font-size:1rem;}
        .s-total span:last-child{color:#ff6b00;}
        .alert{padding:12px 18px;border-radius:8px;margin-bottom:16px;font-size:.92rem;}
        .alert-error{background:#fef2f2;color:#b91c1c;border:1px solid #fecaca;}
        @media(max-width:768px){.checkout-grid{grid-template-columns:1fr;}.summary-card{position:static;}}
    </style>
</head>
<body>
<nav class="shop-nav">
    <a class="logo" href="${pageContext.request.contextPath}/customer/products">Shop<span>Nepal</span></a>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/cart">← Back to Cart</a>
    </div>
</nav>
<div class="checkout-wrap">
    <h2 style="font-size:1.4rem;font-weight:800;color:#1e293b;margin-bottom:20px;">Checkout</h2>
    <c:if test="${not empty error}"><div class="alert alert-error">❌ ${error}</div></c:if>
    <div class="checkout-grid">
        <!-- Delivery Form -->
        <div class="form-card">
            <h3>📍 Delivery Details</h3>
            <form method="post" action="${pageContext.request.contextPath}/order/checkout">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" value="${sessionScope.user.fullName}" disabled>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" value="${sessionScope.user.phone}" disabled>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="text" value="${sessionScope.user.email}" disabled>
                </div>
                <div class="form-group">
                    <label>Delivery Address *</label>
                    <textarea name="address" rows="3"
                              placeholder="Enter your full delivery address (Street, City, District)" required></textarea>
                </div>
                <button type="submit" class="btn-place">✅ Place Order — Rs ${cartTotal}</button>
            </form>
            <a href="${pageContext.request.contextPath}/cart" class="btn-back">← Back to Cart</a>
        </div>
        <!-- Order Summary -->
        <div class="summary-card">
            <h3>🧾 Order Summary</h3>
            <c:forEach var="item" items="${cartItems}">
                <div class="s-item">
                    <span>${item.product.name} × ${item.quantity}</span>
                    <span>Rs ${item.lineTotal}</span>
                </div>
            </c:forEach>
            <div class="s-item"><span>Delivery</span><span style="color:#22c55e;">Free</span></div>
            <div class="s-total"><span>Total</span><span>Rs ${cartTotal}</span></div>
        </div>
    </div>
</div>
</body>
</html>
