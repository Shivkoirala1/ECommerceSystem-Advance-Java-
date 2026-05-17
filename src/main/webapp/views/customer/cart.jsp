<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Cart - ShopNepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background:#f5f5f5; margin:0; }
        .shop-nav { background:#ff6b00; padding:0 32px; display:flex; align-items:center; justify-content:space-between; height:64px; box-shadow:0 2px 8px rgba(0,0,0,.15); position:sticky; top:0; z-index:100; }
        .shop-nav .logo { color:#fff; font-size:1.5rem; font-weight:900; text-decoration:none; }
        .shop-nav .logo span { color:#ffe066; }
        .shop-nav .nav-right { display:flex; align-items:center; gap:8px; }
        .shop-nav .nav-right a { color:#fff; text-decoration:none; padding:7px 14px; border-radius:4px; font-size:.9rem; font-weight:600; }
        .shop-nav .nav-right a:hover { background:rgba(255,255,255,.2); }
        .shop-nav .nav-right .btn-shop { background:#fff; color:#ff6b00; font-weight:700; }

        .cart-wrap { max-width:960px; margin:28px auto; padding:0 24px; }
        .cart-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:20px; }
        .cart-header h2 { font-size:1.4rem; font-weight:800; color:#1e293b; }

        .cart-grid { display:grid; grid-template-columns:1fr 320px; gap:24px; }

        /* Cart items */
        .cart-items { display:flex; flex-direction:column; gap:14px; }
        .cart-item {
            background:#fff; border-radius:12px;
            box-shadow:0 1px 6px rgba(0,0,0,.08);
            padding:16px; display:flex; gap:16px; align-items:center;
        }
        .cart-item-img {
            width:80px; height:70px; background:#f8fafc;
            border-radius:8px; display:flex; align-items:center;
            justify-content:center; flex-shrink:0; overflow:hidden;
        }
        .cart-item-img img { width:100%; height:100%; object-fit:contain; padding:4px; }
        .cart-item-emoji { font-size:2.2rem; }
        .cart-item-info { flex:1; }
        .cart-item-name { font-weight:700; color:#1e293b; margin-bottom:4px; }
        .cart-item-cat { font-size:.8rem; color:#ff6b00; font-weight:600; margin-bottom:6px; }
        .cart-item-price { font-size:1rem; font-weight:800; color:#ff6b00; }
        .cart-item-total { font-size:.85rem; color:#64748b; }
        .cart-item-qty { font-size:.85rem; color:#475569; }
        .cart-item-remove form { margin:0; }
        .btn-remove { background:#fef2f2; color:#ef4444; border:1px solid #fecaca; border-radius:6px; padding:7px 12px; font-size:.85rem; font-weight:700; cursor:pointer; transition:all .2s; }
        .btn-remove:hover { background:#ef4444; color:#fff; }

        /* Order summary */
        .order-summary { background:#fff; border-radius:12px; box-shadow:0 1px 6px rgba(0,0,0,.08); padding:24px; height:fit-content; position:sticky; top:80px; }
        .order-summary h3 { font-size:1.1rem; font-weight:800; color:#1e293b; margin-bottom:18px; padding-bottom:12px; border-bottom:2px solid #f1f5f9; }
        .summary-row { display:flex; justify-content:space-between; margin-bottom:10px; font-size:.92rem; color:#475569; }
        .summary-row.total { font-size:1.1rem; font-weight:800; color:#1e293b; padding-top:12px; border-top:2px solid #f1f5f9; margin-top:12px; }
        .summary-row.total span:last-child { color:#ff6b00; }
        .btn-checkout { display:block; width:100%; background:#ff6b00; color:#fff; border:none; border-radius:8px; padding:13px; font-size:1rem; font-weight:800; cursor:pointer; text-align:center; text-decoration:none; margin-top:16px; transition:background .2s; }
        .btn-checkout:hover { background:#e05a00; }
        .btn-clear { display:block; width:100%; background:#f1f5f9; color:#64748b; border:none; border-radius:8px; padding:10px; font-size:.88rem; font-weight:600; cursor:pointer; text-align:center; margin-top:8px; transition:background .2s; }
        .btn-clear:hover { background:#e2e8f0; }
        .btn-continue { display:block; text-align:center; color:#ff6b00; font-weight:600; font-size:.9rem; text-decoration:none; margin-top:12px; }

        /* Empty cart */
        .empty-cart { background:#fff; border-radius:12px; box-shadow:0 1px 6px rgba(0,0,0,.08); padding:60px 20px; text-align:center; grid-column:1/-1; }
        .empty-cart .e-icon { font-size:5rem; margin-bottom:16px; }
        .empty-cart h3 { font-size:1.3rem; color:#1e293b; margin-bottom:8px; }
        .empty-cart p { color:#64748b; margin-bottom:24px; }

        .alert { padding:12px 18px; border-radius:8px; margin-bottom:16px; font-size:.92rem; }
        .alert-error { background:#fef2f2; color:#b91c1c; border:1px solid #fecaca; }

        @media (max-width:768px) {
            .cart-grid { grid-template-columns:1fr; }
            .order-summary { position:static; }
        }
    </style>
</head>
<body>
<nav class="shop-nav">
    <a class="logo" href="${pageContext.request.contextPath}/customer/products">Shop<span>Nepal</span></a>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/customer/products" class="btn-shop">🏠 Continue Shopping</a>
        <a href="${pageContext.request.contextPath}/order/history">📦 Orders</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<div class="cart-wrap">
    <div class="cart-header">
        <h2>🛒 My Cart</h2>

