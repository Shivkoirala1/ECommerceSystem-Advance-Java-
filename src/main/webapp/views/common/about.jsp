<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>About Us - ShopNepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { margin: 0; font-family: 'Segoe UI', Arial, sans-serif; background: #f5f5f5; }
        .top-bar {
            background: #1e293b; color: #cbd5e1;
            display: flex; justify-content: flex-end;
            align-items: center; gap: 24px;
            padding: 6px 40px; font-size: .82rem;
        }
        .top-bar a { color: #cbd5e1; text-decoration: none; }
        .top-bar a:hover { color: #fff; }
        .land-nav {
            background: #ff6b00; padding: 0 40px;
            display: flex; align-items: center;
            justify-content: space-between; height: 68px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            position: sticky; top: 0; z-index: 100;
        }
        .land-nav .logo {
            color: #fff; font-size: 1.7rem;
            font-weight: 900; text-decoration: none;
        }
        .land-nav .logo span { color: #ffe066; }
        .land-nav .nav-right { display: flex; gap: 16px; }
        .land-nav .nav-right a {
            color: #fff; text-decoration: none;
            font-weight: 600; padding: 8px 16px;
            border-radius: 4px; transition: background .2s;
        }
        .land-nav .nav-right a:hover { background: rgba(255,255,255,.15); }
        .land-nav .nav-right .btn-signup { background: #fff; color: #ff6b00; }

        /* Hero */
        .about-hero {
            background: linear-gradient(135deg, #1e293b 0%, #ff6b00 100%);
            padding: 70px 40px; text-align: center; color: #fff;
        }
        .about-hero h1 { font-size: 2.8rem; font-weight: 900; margin-bottom: 14px; }
        .about-hero p { font-size: 1.1rem; opacity: .9; max-width: 600px; margin: 0 auto; }

        /* Content */
        .about-content { max-width: 1000px; margin: 0 auto; padding: 50px 40px; }

        /* Mission cards */
        .mission-grid { display: flex; gap: 20px; flex-wrap: wrap; margin-bottom: 48px; }
        .mission-card {
            flex: 1; min-width: 200px; background: #fff;
            border-radius: 14px; padding: 28px 24px;
            box-shadow: 0 1px 8px rgba(0,0,0,.08);
            text-align: center;
        }
        .mission-card .m-icon { font-size: 2.5rem; margin-bottom: 12px; }
        .mission-card h3 { font-size: 1.1rem; font-weight: 800; margin-bottom: 8px; color: #1e293b; }
        .mission-card p { font-size: .9rem; color: #64748b; line-height: 1.6; }

        /* Story section */
        .story { background: #fff; border-radius: 14px; padding: 36px; margin-bottom: 36px; box-shadow: 0 1px 8px rgba(0,0,0,.08); }
        .story h2 { font-size: 1.5rem; font-weight: 800; color: #1e293b; margin-bottom: 14px; }
        .story p { color: #475569; line-height: 1.75; margin-bottom: 12px; }

        /* Team */
        .team-grid { display: flex; gap: 16px; flex-wrap: wrap; margin-bottom: 48px; }
        .team-card {
            flex: 1; min-width: 150px; max-width: 180px;
            background: #fff; border-radius: 14px;
            padding: 24px 16px; text-align: center;
            box-shadow: 0 1px 8px rgba(0,0,0,.08);
        }
        .team-card .avatar {
            width: 72px; height: 72px; border-radius: 50%;
            background: linear-gradient(135deg, #ff6b00, #1e293b);
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-size: 1.6rem; font-weight: 900;
            margin: 0 auto 12px;
        }
        .team-card h4 { font-size: .95rem; font-weight: 700; color: #1e293b; margin-bottom: 4px; }
        .team-card p { font-size: .8rem; color: #64748b; }

        /* Stats */
        .stats { display: flex; gap: 16px; flex-wrap: wrap; margin-bottom: 48px; }
        .stat-box {
            flex: 1; min-width: 140px; background: #ff6b00;
            border-radius: 12px; padding: 24px;
            text-align: center; color: #fff;
        }
        .stat-box .num { font-size: 2rem; font-weight: 900; }
        .stat-box .lbl { font-size: .85rem; opacity: .9; }

        /* CTA */
        .about-cta {
            background: #1e293b; border-radius: 14px;
            padding: 40px; text-align: center; color: #fff;
        }
        .about-cta h2 { font-size: 1.8rem; font-weight: 900; margin-bottom: 10px; }
        .about-cta p { opacity: .85; margin-bottom: 24px; }
        .about-cta .cta-btns { display: flex; gap: 14px; justify-content: center; flex-wrap: wrap; }
        .about-cta a {
            padding: 12px 28px; border-radius: 6px;
            font-weight: 700; text-decoration: none; font-size: .95rem;
        }
        .cta-primary { background: #ff6b00; color: #fff; }
        .cta-secondary { background: transparent; color: #fff; border: 2px solid #fff; }

        /* Footer */
        .land-footer { background: #1e293b; color: #94a3b8; padding: 32px 40px; text-align: center; }
        .land-footer .footer-links { display: flex; justify-content: center; gap: 24px; flex-wrap: wrap; margin-top: 12px; }
        .land-footer .footer-links a { color: #94a3b8; text-decoration: none; font-size: .9rem; }
        .land-footer .footer-links a:hover { color: #fff; }

        @media (max-width: 768px) {
            .top-bar, .search-wrap { display: none; }
            .land-nav { padding: 0 16px; }
            .about-hero { padding: 40px 20px; }
            .about-hero h1 { font-size: 1.8rem; }
            .about-content { padding: 28px 16px; }
            .team-card { max-width: 100%; }
        }
    </style>
</head>
<body>

<!-- Top Bar -->
<div class="top-bar">
    <a href="${pageContext.request.contextPath}/">Home</a>
    <span>|</span>
    <a href="${pageContext.request.contextPath}/login">Login</a>
    <span>|</span>
    <a href="${pageContext.request.contextPath}/register">Sign Up</a>
</div>

<!-- Navbar -->
<nav class="land-nav">
    <a class="logo" href="${pageContext.request.contextPath}/">Shop<span>Nepal</span></a>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/about">About Us</a>
        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="${pageContext.request.contextPath}/register" class="btn-signup">Sign Up</a>
    </div>
</nav>

<!-- Hero -->
<div class="about-hero">
    <h1>About ShopNepal</h1>
    <p>Nepal's trusted online shopping platform, bringing quality products to your doorstep since 2024.</p>
</div>

<div class="about-content">

    <!-- Mission Cards -->
    <div class="mission-grid">
        <div class="mission-card">
            <div class="m-icon">🎯</div>
            <h3>Our Mission</h3>
            <p>To make quality products accessible and affordable to every Nepali household through technology.</p>
        </div>
        <div class="mission-card">
            <div class="m-icon">👁</div>
            <h3>Our Vision</h3>
