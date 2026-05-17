<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>ShopNepal - Online Shopping</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* ===== LANDING PAGE STYLES ===== */
        body { margin: 0; font-family: 'Segoe UI', Arial, sans-serif; background: #f5f5f5; }

        /* Top bar */
        .top-bar {
            background: #1e293b; color: #cbd5e1;
            display: flex; justify-content: flex-end;
            align-items: center; gap: 24px;
            padding: 6px 40px; font-size: .82rem;
        }
        .top-bar a { color: #cbd5e1; text-decoration: none; }
        .top-bar a:hover { color: #fff; }

        /* Main navbar */
        .land-nav {
            background: #ff6b00;
            padding: 0 40px;
            display: flex; align-items: center;
            justify-content: space-between;
            height: 68px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            position: sticky; top: 0; z-index: 100;
        }
        .land-nav .logo {
            color: #fff; font-size: 1.7rem;
            font-weight: 900; text-decoration: none;
            letter-spacing: -1px;
        }
        .land-nav .logo span { color: #ffe066; }

        /* Search bar */
        .search-wrap {
            flex: 1; max-width: 560px; margin: 0 32px;
            display: flex;
        }
        .search-wrap input {
            flex: 1; padding: 11px 18px;
            border: none; border-radius: 4px 0 0 4px;
            font-size: 1rem; outline: none;
        }
        .search-wrap button {
            background: #ff8c00; color: #fff;
            border: none; padding: 0 20px;
            border-radius: 0 4px 4px 0;
            font-size: 1.1rem; cursor: pointer;
        }
        .search-wrap button:hover { background: #e07000; }

        .land-nav .nav-right {
            display: flex; align-items: center; gap: 20px;
        }
        .land-nav .nav-right a {
            color: #fff; text-decoration: none;
            font-size: .95rem; font-weight: 600;
            padding: 8px 16px; border-radius: 4px;
            transition: background .2s;
        }
        .land-nav .nav-right a:hover { background: rgba(255,255,255,.15); }
        .land-nav .nav-right .btn-signup {
            background: #fff; color: #ff6b00;
        }
        .land-nav .nav-right .btn-signup:hover { background: #ffe8d6; }
        .cart-icon { font-size: 1.4rem; color: #fff; text-decoration: none; }

        /* Hero banner */
        .hero {
            background: linear-gradient(135deg, #1e293b 0%, #ff6b00 100%);
            padding: 60px 40px;
            display: flex; align-items: center;
            justify-content: space-between;
            min-height: 380px;
            position: relative; overflow: hidden;
        }
        .hero-text { color: #fff; max-width: 500px; z-index: 2; }
        .hero-text h1 {
            font-size: 3rem; font-weight: 900;
            margin-bottom: 12px; line-height: 1.1;
        }
        .hero-text h1 span { color: #ffe066; }
        .hero-text p { font-size: 1.15rem; margin-bottom: 28px; opacity: .9; }
        .hero-btns { display: flex; gap: 14px; }
        .hero-btns a {
            padding: 13px 28px; border-radius: 6px;
            font-size: 1rem; font-weight: 700;
            text-decoration: none; transition: transform .2s;
        }
        .hero-btns a:hover { transform: translateY(-2px); }
        .btn-hero-primary { background: #fff; color: #ff6b00; }
        .btn-hero-secondary {
            background: transparent; color: #fff;
            border: 2px solid #fff;
        }
        .hero-badge {
            position: absolute; right: 80px; top: 50%;
            transform: translateY(-50%);
            background: #ffe066; color: #1e293b;
            border-radius: 50%; width: 160px; height: 160px;
            display: flex; flex-direction: column;
            align-items: center; justify-content: center;
            font-weight: 900; font-size: 1rem; text-align: center;
            box-shadow: 0 4px 24px rgba(0,0,0,0.2);
        }
        .hero-badge .big { font-size: 2.4rem; line-height: 1; }

        /* Categories */
        .section { padding: 36px 40px; }
        .section-title {
            font-size: 1.3rem; font-weight: 800;
            color: #1e293b; margin-bottom: 20px;
            display: flex; align-items: center; gap: 10px;
        }
        .section-title::after {
            content: ''; flex: 1;
            height: 2px; background: #e2e8f0;
        }
        .cat-grid {
            display: flex; gap: 16px; flex-wrap: wrap;
        }
        .cat-card {
            background: #fff; border-radius: 12px;
            padding: 20px 24px; text-align: center;
            flex: 1; min-width: 120px; max-width: 160px;
            box-shadow: 0 1px 6px rgba(0,0,0,.07);
            text-decoration: none; color: #1e293b;
            transition: transform .2s, box-shadow .2s;
        }
        .cat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0,0,0,.12);
        }
        .cat-card .cat-icon { font-size: 2.2rem; margin-bottom: 8px; }
        .cat-card .cat-name { font-weight: 700; font-size: .95rem; }

        /* Flash sale */
        .flash-header {
            display: flex; align-items: center;
            justify-content: space-between; margin-bottom: 20px;
        }
        .flash-title {
            font-size: 1.3rem; font-weight: 800;
            color: #1e293b; display: flex;
            align-items: center; gap: 10px;
        }
        .flash-badge {
            background: #ef4444; color: #fff;
            padding: 3px 12px; border-radius: 20px;
            font-size: .8rem; font-weight: 700;
        }
        .view-all {
            color: #ff6b00; font-weight: 600;
            text-decoration: none; font-size: .9rem;
        }
        .view-all:hover { text-decoration: underline; }

        /* Product cards */
        .prod-grid {
            display: flex; gap: 16px; flex-wrap: wrap;
        }
        .prod-card {
            background: #fff; border-radius: 10px;
            box-shadow: 0 1px 6px rgba(0,0,0,.07);
            flex: 1; min-width: 160px; max-width: 200px;
            padding: 16px; transition: transform .2s;
            text-decoration: none; color: #1e293b;
        }
        .prod-card:hover { transform: translateY(-3px); }
        .prod-card .prod-icon {
            font-size: 3rem; text-align: center;
            margin-bottom: 10px; display: block;
        }
        .prod-card .prod-name {
            font-weight: 700; font-size: .9rem;
            margin-bottom: 4px;
        }
        .prod-card .prod-price {
            color: #ff6b00; font-weight: 800;
            font-size: 1rem;
        }
        .prod-card .prod-old {
            color: #94a3b8; text-decoration: line-through;
            font-size: .82rem;
        }
        .prod-card .prod-discount {
            background: #fef2f2; color: #ef4444;
            font-size: .75rem; font-weight: 700;
            padding: 2px 7px; border-radius: 4px;
            display: inline-block; margin-top: 4px;
        }

        /* Features strip */
        .features {
            background: #fff; padding: 28px 40px;
            display: flex; gap: 0; border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0;
        }
        .feature-item {
            flex: 1; display: flex; align-items: center;
            gap: 14px; padding: 0 20px;
            border-right: 1px solid #e2e8f0;
        }
        .feature-item:last-child { border-right: none; }
        .feature-icon { font-size: 2rem; }
        .feature-text h4 { font-size: .95rem; font-weight: 700; }
        .feature-text p { font-size: .82rem; color: #64748b; }

        /* Footer */
        .land-footer {
            background: #1e293b; color: #94a3b8;
            padding: 40px; text-align: center;
        }
        .land-footer h3 {
            color: #fff; font-size: 1.3rem; margin-bottom: 8px;
        }
        .land-footer p { font-size: .9rem; margin-bottom: 16px; }
        .footer-links {
            display: flex; justify-content: center;
            gap: 24px; flex-wrap: wrap;
        }
        .footer-links a {
            color: #94a3b8; text-decoration: none; font-size: .9rem;
        }
        .footer-links a:hover { color: #fff; }

        @media (max-width: 768px) {
            .top-bar { display: none; }
            .land-nav { padding: 0 16px; }
            .search-wrap { display: none; }
            .hero { padding: 36px 20px; flex-direction: column; }
            .hero-text h1 { font-size: 2rem; }
            .hero-badge { display: none; }
            .section { padding: 24px 16px; }
            .features { flex-direction: column; gap: 16px; }
            .feature-item { border-right: none; padding: 0; }
        }
    </style>
</head>
<body>

<!-- Top Bar -->
<div class="top-bar">
    <a href="${pageContext.request.contextPath}/about">About Us</a>
    <span>|</span>
    <a href="${pageContext.request.contextPath}/login">Seller Center</a>
    <span>|</span>
    <a href="${pageContext.request.contextPath}/about">Help & Support</a>
</div>

<!-- Main Navbar -->
<nav class="land-nav">
    <a class="logo" href="${pageContext.request.contextPath}/">Shop<span>Nepal</span></a>

    <div class="search-wrap">
        <input type="text" placeholder="Search products, brands and more...">
        <button>🔍</button>
    </div>

    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/about">About Us</a>
        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="${pageContext.request.contextPath}/register" class="btn-signup">Sign Up</a>
        <a href="${pageContext.request.contextPath}/login" class="cart-icon">🛒</a>
    </div>
</nav>

<!-- Hero Banner -->
<div class="hero">
    <div class="hero-text">
        <h1>Shop Smarter,<br><span>Save Bigger</span></h1>
        <p>Discover thousands of products at unbeatable prices. Fast delivery across Nepal.</p>
        <div class="hero-btns">
            <a href="${pageContext.request.contextPath}/register" class="btn-hero-primary">Start Shopping</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-hero-secondary">Login to Account</a>
        </div>
    </div>
    <div class="hero-badge">
        <div class="big">80%</div>
        <div>OFF</div>
        <div style="font-size:.75rem;margin-top:4px;">Limited Time</div>
    </div>
</div>

<!-- Features Strip -->
<div class="features">
    <div class="feature-item">
        <div class="feature-icon">🚚</div>
        <div class="feature-text">
            <h4>Free Delivery</h4>
            <p>On orders above Rs 500</p>
        </div>
    </div>
    <div class="feature-item">
        <div class="feature-icon">🔒</div>
        <div class="feature-text">
            <h4>Secure Payment</h4>
            <p>100% secure transactions</p>
        </div>
    </div>
    <div class="feature-item">
        <div class="feature-icon">↩️</div>
        <div class="feature-text">
            <h4>Easy Returns</h4>
            <p>7 day return policy</p>
        </div>
    </div>
    <div class="feature-item">
        <div class="feature-icon">🎧</div>
        <div class="feature-text">
            <h4>24/7 Support</h4>
            <p>Always here to help</p>
        </div>
    </div>
</div>

<!-- Categories -->
<div class="section">
    <div class="section-title">Shop by Category</div>

    <div class="cat-grid">
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/electronics.jpeg"
                 alt="Electronics"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Electronics</div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/clothes.jpg"
                 alt="Clothes"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Clothes</div>
        </a>

        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/footwear.JPEG"
                 alt="Footwear"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Footwear</div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/acessories.jpg"
                 alt="Acessories"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Acccessoris</div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/furniture.jpeg"
                 alt="Home and Living"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Home Home and Living</div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/phone.jpg"
                 alt="Phone"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Phone</div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/childwear.jpg"
                 alt="Child Wear"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Child wear</div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/ladieswear.jpeg"
                 alt="Ladies Wear"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Ladies Wear</div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/menwear.JPEG"
                 alt="Men Wear"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Men Wear</div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/facial.jpg"
                 alt="Facial Products"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Facial Products</div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="cat-card">
            <img src="${pageContext.request.contextPath}/images/food.jpg"
                 alt="Foods"
                 style="width:100%;height:100px;object-fit:contain;padding:8px;display:block;">
            <div class="cat-name">Foods</div>
        </a>

    </div>
</div>

<!-- Flash Sale -->
<div class="section" style="background:#fff;margin:0;">
    <div class="flash-header">
        <div class="flash-title">
            ⚡ Flash Sale
            <span class="flash-badge">NOW ON</span>
        </div>
        <a href="${pageContext.request.contextPath}/login" class="view-all">View All Products →</a>
    </div>
    <div class="prod-grid">
        <a href="${pageContext.request.contextPath}/login" class="prod-card">
            <img src="${pageContext.request.contextPath}/images/laptop.jpg"
                 alt="Laptop"
                 style="width:100%;height:120px;object-fit:contain;border-radius:8px;margin-bottom:10px;padding:6px;">
            <div class="prod-name">HP Victus</div>
            <div class="prod-price">Rs 95,000</div>
            <div class="prod-old">Rs 105,000</div>
            <span class="prod-discount">-12% OFF</span>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="prod-card">
            <img src="${pageContext.request.contextPath}/images/redmi14.jpg"
                 alt="Redmi 14 pro"
                 style="width:100%;height:120px;object-fit:contain;border-radius:8px;margin-bottom:10px;padding:6px;">
            <div class="prod-name">Redmi 14 Pro</div>
            <div class="prod-price">Rs 38,000</div>
            <div class="prod-old">Rs 45,000</div>
            <span class="prod-discount">-16% OFF</span>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="prod-card">
            <img src="${pageContext.request.contextPath}/images/earpods.jpg"
                 alt="Headphones"
                 style="width:100%;height:120px;object-fit:contain;border-radius:8px;margin-bottom:10px;padding:6px;">
            <div class="prod-name">earpods pro</div>
            <div class="prod-price">Rs 28,800</div>
            <div class="prod-old">Rs 35,500</div>
