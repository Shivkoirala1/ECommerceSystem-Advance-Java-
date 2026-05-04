<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><title>Manage Users</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head><body>
<nav class="navbar">
    <a class="brand" href="#">E<span>Commerce</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>
<div class="layout">
    <div class="sidebar">
        <a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/products">📦 Products</a>
        <a href="${pageContext.request.contextPath}/admin/orders">🧾 Orders</a>
        <a href="${pageContext.request.contextPath}/admin/users" class="active">👥 Users</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>
    <div class="main-content">
        <h2 style="margin-bottom:24px;">All Users</h2>
        <c:if test="${not empty param.success}"><div class="alert alert-success">${param.success}</div></c:if>
        <div class="card">
            <div class="table-wrap">
                <table>
                    <thead><tr><th>ID</th><th>Full Name</th><th>Username</th><th>Email</th><th>Phone</th><th>Role</th><th>Joined</th><th>Action</th></tr></thead>
                    <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td data-label="ID">${u.id}</td>
                            <td data-label="Name">${u.fullName}</td>
                            <td data-label="Username">${u.username}</td>
                            <td data-label="Email">${u.email}</td>
                            <td data-label="Phone">${u.phone}</td>
                            <td data-label="Role"><span class="badge badge-${u.role.toLowerCase()}">${u.role}</span></td>
                            <td data-label="Joined">${u.createdAt}</td>
                            <td data-label="Action">
                                <c:if test="${u.role != 'ADMIN'}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/users"
                                          onsubmit="return confirm('Delete user ${u.username}?')" style="display:inline;">
                                        <input type="hidden" name="id" value="${u.id}">
                                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body></html>
