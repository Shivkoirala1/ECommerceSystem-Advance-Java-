<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Shop - ShopNepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background: #f5f5f5; margin: 0; }

        /* Top navbar */
        .shop-nav {
            background: #ff6b00; padding: 0 32px;
            display: flex; align-items: center;
            justify-content: space-between; height: 64px;
            box-shadow: 0 2px 8px rgba(0,0,0,.15);
            position: sticky; top: 0; z-index: 100;
        }
        .shop-nav .logo {
            color: #fff; font-size: 1.5rem;
            font-weight: 900; text-decoration: none;
        }
        .shop-nav .logo span { color: #ffe066; }
        .shop-nav .nav-search {
            flex: 1; max-width: 500px; margin: 0 24px;
            display: flex;
        }
        .shop-nav .nav-search input {
            flex: 1; padding: 9px 16px;
            border: none; border-radius: 4px 0 0 4px;
            font-size: .95rem; outline: none;
        }
        .shop-nav .nav-search button {
            background: #1e293b; color: #fff;
            border: none; padding: 0 18px;
            border-radius: 0 4px 4px 0;
            font-size: 1rem; cursor: pointer;
        }
        .shop-nav .nav-right {
            display: flex; align-items: center; gap: 8px;
        }
        .shop-nav .nav-right a {
            color: #fff; text-decoration: none;
            padding: 7px 14px; border-radius: 4px;
            font-size: .9rem; font-weight: 600;
            transition: background .2s;
        }
        .shop-nav .nav-right a:hover { background: rgba(255,255,255,.2); }
        .shop-nav .nav-right .cart-btn {
            background: #fff; color: #ff6b00;
            border-radius: 4px; padding: 7px 14px;
            font-weight: 700;
        }
        .shop-nav .nav-right .user-greet {
            color: #ffe8cc; font-size: .88rem;
        }

        /* Category filter bar */
        .cat-bar {
            background: #fff; padding: 12px 32px;
            display: flex; gap: 10px; flex-wrap: wrap;
            align-items: center; border-bottom: 1px solid #e2e8f0;
            box-shadow: 0 1px 4px rgba(0,0,0,.04);
        }
        .cat-bar span { font-weight: 700; color: #1e293b; margin-right: 4px; }
        .cat-btn {
            padding: 6px 16px; border-radius: 20px;
            border: 1.5px solid #e2e8f0; background: #f8fafc;
            color: #475569; font-size: .88rem; font-weight: 600;
            text-decoration: none; transition: all .2s;
        }
        .cat-btn:hover, .cat-btn.active {
            background: #ff6b00; color: #fff;
            border-color: #ff6b00;
        }

        /* Main layout */
        .shop-layout {
            display: flex; max-width: 1400px;
            margin: 0 auto; padding: 24px 32px; gap: 24px;
        }

        /* Products area */
        .products-area { flex: 1; }
        .products-header {
            display: flex; justify-content: space-between;
            align-items: center; margin-bottom: 20px;
        }
        .products-header h2 { font-size: 1.2rem; font-weight: 800; color: #1e293b; }
        .result-count { color: #64748b; font-size: .9rem; }

        /* Product grid */
        .prod-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }
        .prod-card {
            background: #fff; border-radius: 12px;
            box-shadow: 0 1px 6px rgba(0,0,0,.08);
            overflow: hidden; transition: transform .2s, box-shadow .2s;
            display: flex; flex-direction: column;
        }
        .prod-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0,0,0,.12);
        }
        .prod-img-wrap {
            height: 180px; background: #f8fafc;
            display: flex; align-items: center;
            justify-content: center; overflow: hidden;
            border-bottom: 1px solid #f1f5f9;
        }
        .prod-img-wrap img {
            width: 100%; height: 100%;
            object-fit: contain; padding: 12px;
        }
        .prod-img-wrap .prod-emoji {
            font-size: 5rem; line-height: 1;
        }
        .prod-info { padding: 14px; flex: 1; display: flex; flex-direction: column; gap: 6px; }
        .prod-cat {
            font-size: .75rem; font-weight: 700;
            color: #ff6b00; text-transform: uppercase;
            letter-spacing: .5px;
        }
        .prod-name { font-size: .98rem; font-weight: 700; color: #1e293b; }
        .prod-desc { font-size: .82rem; color: #64748b; line-height: 1.4; flex: 1; }
        .prod-price { font-size: 1.15rem; font-weight: 800; color: #ff6b00; }
        .prod-stock-ok  { font-size: .78rem; color: #22c55e; font-weight: 600; }
        .prod-stock-low { font-size: .78rem; color: #f59e0b; font-weight: 600; }
        .prod-stock-out { font-size: .78rem; color: #ef4444; font-weight: 600; }
        .prod-footer {
            padding: 12px 14px; border-top: 1px solid #f1f5f9;
            display: flex; gap: 8px; align-items: center;
        }
        .qty-input {
            width: 56px; padding: 7px 8px;
            border: 1.5px solid #e2e8f0; border-radius: 6px;
            font-size: .9rem; text-align: center;
        }
        .btn-add {
            flex: 1; background: #ff6b00; color: #fff;
            border: none; border-radius: 6px; padding: 8px;
            font-size: .9rem; font-weight: 700; cursor: pointer;
            transition: background .2s;
        }
        .btn-add:hover { background: #e05a00; }
        .btn-out {
            flex: 1; background: #f1f5f9; color: #94a3b8;
            border: none; border-radius: 6px; padding: 8px;
            font-size: .9rem; font-weight: 700; cursor: not-allowed;
        }

        /* Empty state */
        .empty-state {
            grid-column: 1/-1; text-align: center;
            padding: 60px 20px; background: #fff;
            border-radius: 12px; box-shadow: 0 1px 6px rgba(0,0,0,.08);
        }
        .empty-state .e-icon { font-size: 4rem; margin-bottom: 16px; }
        .empty-state h3 { font-size: 1.2rem; color: #1e293b; margin-bottom: 8px; }
        .empty-state p { color: #64748b; margin-bottom: 20px; }

        /* Alerts */
        .alert { padding: 12px 18px; border-radius: 8px; margin-bottom: 16px; font-size: .95rem; }
        .alert-success { background: #f0fdf4; color: #15803d; border: 1px solid #bbf7d0; }
        .alert-error   { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }

        @media (max-width: 768px) {
            .shop-nav { padding: 0 16px; }
            .shop-nav .nav-search { display: none; }
            .shop-layout { padding: 16px; }
            .prod-grid { grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 12px; }
            .prod-img-wrap { height: 140px; }
        }
    </style>
</head>
<body>

<!-- Top Navbar -->
<nav class="shop-nav">
    <a class="logo" href="${pageContext.request.contextPath}/customer/products">Shop<span>Nepal</span></a>

    <form class="nav-search" method="get" action="${pageContext.request.contextPath}/customer/products">
        <input type="text" name="search" placeholder="Search products..." value="${search}">
        <button type="submit">🔍</button>
    </form>

    <div class="nav-right">
        <span class="user-greet">Hi, ${sessionScope.user.fullName}</span>
        <a href="${pageContext.request.contextPath}/customer/products">🏠 Shop</a>
        <a href="${pageContext.request.contextPath}/order/history">📦 Orders</a>
        <a href="${pageContext.request.contextPath}/cart" class="cart-btn">🛒 Cart</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<!-- Category Filter Bar -->
<div class="cat-bar">
    <span>Categories:</span>
    <a href="${pageContext.request.contextPath}/customer/products"
       class="cat-btn ${empty param.category && empty param.search ? 'active' : ''}">All</a>
    <a href="${pageContext.request.contextPath}/customer/products?category=Electronics"
       class="cat-btn ${param.category == 'Electronics' ? 'active' : ''}">💻 Electronics</a>
    <a href="${pageContext.request.contextPath}/customer/products?category=Phone"
       class="cat-btn ${param.category == 'Phone' ? 'active' : ''}">📱 Phones</a>
    <a href="${pageContext.request.contextPath}/customer/products?category=Clothing"
       class="cat-btn ${param.category == 'Clothing' ? 'active' : ''}">👕 Clothing</a>
    <a href="${pageContext.request.contextPath}/customer/products?category=Footwear"
       class="cat-btn ${param.category == 'Footwear' ? 'active' : ''}">👟 Footwear</a>
    <a href="${pageContext.request.contextPath}/customer/products?category=Accessories"
       class="cat-btn ${param.category == 'Accessories' ? 'active' : ''}">🎒 Accessories</a>
    <a href="${pageContext.request.contextPath}/customer/products?category=Home and Living"
       class="cat-btn ${param.category == 'Home and Living' ? 'active' : ''}">🏠 Home & Living</a>
    <a href="${pageContext.request.contextPath}/customer/products?category=Facial Products"
       class="cat-btn ${param.category == 'Facial Products' ? 'active' : ''}">✨ Facial</a>
    <a href="${pageContext.request.contextPath}/customer/products?category=Foods"
       class="cat-btn ${param.category == 'Foods' ? 'active' : ''}">🍫 Foods</a>
</div>

<!-- Main Content -->
<div class="shop-layout">
    <div class="products-area">

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">✅ ${param.success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">❌ ${error}</div>
        </c:if>

        <!-- Header -->
        <div class="products-header">
            <h2>
                <c:choose>
                    <c:when test="${not empty search}">Results for "${search}"</c:when>
                    <c:when test="${param.category == 'Clothing'}">👕 Clothing (Men, Women & Kids)</c:when>
                    <c:when test="${not empty param.category}">${param.category}</c:when>
                    <c:otherwise>All Products</c:otherwise>
                </c:choose>
            </h2>
            <span class="result-count">${products.size()} products found</span>
        </div>

        <!-- Product Grid -->
