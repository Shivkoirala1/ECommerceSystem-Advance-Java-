<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><title>Checkout - ECommerce</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head><body>
<nav class="navbar">
    <a class="brand" href="#">E<span>Commerce</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/cart">← Back to Cart</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>
<div class="main-content" style="padding:28px 32px;max-width:800px;">
    <h2 style="margin-bottom:20px;">Checkout</h2>
    <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

    <div class="card">
        <div class="card-title">Order Summary</div>
        <div class="table-wrap">
            <table>
                <thead><tr><th>Product</th><th>Qty</th><th>Price</th><th>Total</th></tr></thead>
                <tbody>
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td>${item.product.name}</td>
                        <td>${item.quantity}</td>
                        <td>Rs ${item.product.price}</td>
                        <td>Rs ${item.lineTotal}</td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="3" style="text-align:right;font-weight:700;">Grand Total:</td>
                    <td style="font-weight:800;color:#2563eb;">Rs ${cartTotal}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="card">
        <div class="card-title">Delivery Details</div>
        <form method="post" action="${pageContext.request.contextPath}/order/checkout">
            <div class="form-group">
                <label>Customer Name</label>
                <input type="text" value="${sessionScope.user.fullName}" disabled>
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="text" value="${sessionScope.user.phone}" disabled>
            </div>
            <div class="form-group">
                <label>Delivery Address *</label>
                <textarea name="address" rows="3" placeholder="Enter your full delivery address" required></textarea>
            </div>
            <div style="display:flex;gap:12px;">
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary">← Back to Cart</a>
                <button type="submit" class="btn btn-success">✅ Place Order</button>
            </div>
        </form>
    </div>
</div>
</body></html>
