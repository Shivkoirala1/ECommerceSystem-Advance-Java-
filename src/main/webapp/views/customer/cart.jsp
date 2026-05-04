<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><title>My Cart - ECommerce</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head><body>
<nav class="navbar">
    <a class="brand" href="#">E<span>Commerce</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/customer/products">🏠 Shop</a></li>
        <li><a href="${pageContext.request.contextPath}/cart" class="active">🛒 Cart</a></li>
        <li><a href="${pageContext.request.contextPath}/order/history">📦 My Orders</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>
<div class="main-content" style="padding:28px 32px;">
    <h2 style="margin-bottom:20px;">🛒 Your Cart</h2>
    <c:if test="${not empty param.error}"><div class="alert alert-error">${param.error}</div></c:if>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="card" style="text-align:center;padding:40px;">
                <p style="color:#64748b;margin-bottom:16px;">Your cart is empty.</p>
                <a href="${pageContext.request.contextPath}/customer/products" class="btn btn-primary">Continue Shopping</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card">
                <div class="table-wrap">
                    <table>
                        <thead><tr><th>Product</th><th>Unit Price</th><th>Quantity</th><th>Total</th><th>Action</th></tr></thead>
                        <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr>
                                <td data-label="Product">${item.product.name}</td>
                                <td data-label="Unit Price">Rs ${item.product.price}</td>
                                <td data-label="Quantity">${item.quantity}</td>
                                <td data-label="Total">Rs ${item.lineTotal}</td>
                                <td data-label="Action">
                                    <form method="post" action="${pageContext.request.contextPath}/cart" style="display:inline;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="itemId" value="${item.id}">
                                        <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr style="background:#f8fafc;">
                            <td colspan="3" style="text-align:right;font-weight:700;padding:14px;">Grand Total:</td>
                            <td style="font-weight:800;color:#2563eb;font-size:1.1rem;">Rs ${cartTotal}</td>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div style="display:flex;gap:12px;justify-content:flex-end;margin-top:8px;">
                <form method="post" action="${pageContext.request.contextPath}/cart">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="btn btn-secondary" onclick="return confirm('Clear cart?')">Clear Cart</button>
                </form>
                <a href="${pageContext.request.contextPath}/customer/products" class="btn btn-secondary">← Continue Shopping</a>
                <a href="${pageContext.request.contextPath}/order/checkout" class="btn btn-success">Proceed to Checkout →</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body></html>
