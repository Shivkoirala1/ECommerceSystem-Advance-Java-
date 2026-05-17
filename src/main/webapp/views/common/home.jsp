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
