<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Orders - ShopNepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body{background:#f5f5f5;margin:0;}
        .shop-nav{background:#ff6b00;padding:0 32px;display:flex;align-items:center;justify-content:space-between;height:64px;box-shadow:0 2px 8px rgba(0,0,0,.15);position:sticky;top:0;z-index:100;}
        .shop-nav .logo{color:#fff;font-size:1.5rem;font-weight:900;text-decoration:none;}
        .shop-nav .logo span{color:#ffe066;}
        .shop-nav .nav-right{display:flex;align-items:center;gap:8px;}
        .shop-nav .nav-right a{color:#fff;text-decoration:none;padding:7px 14px;border-radius:4px;font-size:.9rem;font-weight:600;}
        .shop-nav .nav-right a:hover{background:rgba(255,255,255,.2);}
        .shop-nav .nav-right .btn-shop{background:#fff;color:#ff6b00;font-weight:700;}
        .orders-wrap{max-width:900px;margin:28px auto;padding:0 24px;}
        .page-title{font-size:1.4rem;font-weight:800;color:#1e293b;margin-bottom:20px;}
        .order-card{background:#fff;border-radius:12px;box-shadow:0 1px 6px rgba(0,0,0,.08);margin-bottom:18px;overflow:hidden;}
        .order-card-header{padding:16px 20px;background:#f8fafc;display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #f1f5f9;}
        .order-id{font-weight:800;color:#1e293b;font-size:1rem;}
        .order-date{font-size:.82rem;color:#64748b;}
        .badge{display:inline-block;padding:4px 12px;border-radius:20px;font-size:.75rem;font-weight:700;text-transform:uppercase;}
        .badge-pending{background:#fef9c3;color:#854d0e;}
        .badge-processing{background:#dbeafe;color:#1d4ed8;}
        .badge-delivered{background:#dcfce7;color:#15803d;}
        .order-card-body{padding:16px 20px;}
        .order-item{display:flex;align-items:center;gap:14px;padding:10px 0;border-bottom:1px solid #f8fafc;}
        .order-item:last-child{border-bottom:none;}
        .order-item-img{width:56px;height:50px;background:#f8fafc;border-radius:8px;display:flex;align-items:center;justify-content:center;overflow:hidden;flex-shrink:0;}
        .order-item-img img{width:100%;height:100%;object-fit:contain;padding:4px;}
        .order-item-emoji{font-size:1.8rem;}
        .order-item-name{font-weight:700;color:#1e293b;font-size:.92rem;}
        .order-item-detail{font-size:.82rem;color:#64748b;}
        .order-card-footer{padding:14px 20px;background:#f8fafc;border-top:1px solid #f1f5f9;display:flex;justify-content:space-between;align-items:center;}
        .order-total{font-size:1rem;font-weight:800;color:#ff6b00;}
        .order-addr{font-size:.82rem;color:#64748b;}
        .empty-state{background:#fff;border-radius:12px;box-shadow:0 1px 6px rgba(0,0,0,.08);padding:60px 20px;text-align:center;}
        .empty-state .e-icon{font-size:4rem;margin-bottom:16px;}
        .alert{padding:12px 18px;border-radius:8px;margin-bottom:16px;font-size:.92rem;}
        .alert-success{background:#f0fdf4;color:#15803d;border:1px solid #bbf7d0;}
    </style>
</head>
<body>
<nav class="shop-nav">
    <a class="logo" href="${pageContext.request.contextPath}/customer/products">Shop<span>Nepal</span></a>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/customer/products" class="btn-shop">🏠 Shop</a>
        <a href="${pageContext.request.contextPath}/cart">🛒 Cart</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>
<div class="orders-wrap">
    <div class="page-title">📦 My Orders</div>
    <c:if test="${not empty param.success}"><div class="alert alert-success">✅ ${param.success}</div></c:if>
    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-state">
                <div class="e-icon">📦</div>
                <h3 style="color:#1e293b;margin-bottom:8px;">No orders yet</h3>
                <p style="color:#64748b;margin-bottom:20px;">You haven't placed any orders. Start shopping!</p>
                <a href="${pageContext.request.contextPath}/customer/products"
                   style="background:#ff6b00;color:#fff;padding:12px 28px;border-radius:8px;text-decoration:none;font-weight:800;">
                    Start Shopping
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="o" items="${orders}">
                <div class="order-card">
                    <div class="order-card-header">
                        <div>
                            <div class="order-id">Order #${o.id}</div>
                            <div class="order-date">${o.orderDate}</div>
                        </div>
                        <span class="badge badge-${o.status.toLowerCase()}">${o.status}</span>
                    </div>
                    <div class="order-card-body">
