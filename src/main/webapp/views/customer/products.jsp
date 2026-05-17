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
