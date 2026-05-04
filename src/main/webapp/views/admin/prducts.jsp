<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><title>Manage Products</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head><body>
<nav class="navbar">
    <a class="brand" href="#">E<span>Commerce</span></a>
    <ul class="nav-links">
        <li><span style="color:#94a3b8;">Admin: ${sessionScope.user.fullName}</span></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>
<div class="layout">
    <div class="sidebar">
        <a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/products" class="active">📦 Products</a>
        <a href="${pageContext.request.contextPath}/admin/orders">🧾 Orders</a>
        <a href="${pageContext.request.contextPath}/admin/users">👥 Users</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>
    <div class="main-content">
        <h2 style="margin-bottom:24px;">Manage Products</h2>
        <c:if test="${not empty param.success}"><div class="alert alert-success">${param.success}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

        <!-- Add Product Form -->
        <div class="card">
            <div class="card-title">Add New Product</div>
            <form method="post" action="${pageContext.request.contextPath}/admin/products">
                <input type="hidden" name="action" value="add">
                <div style="display:flex;flex-wrap:wrap;gap:16px;">
                    <div class="form-group" style="flex:1;min-width:180px;">
                        <label>Name</label><input type="text" name="name" required>
                    </div>
                    <div class="form-group" style="flex:1;min-width:180px;">
                        <label>Category</label><input type="text" name="category" required>
                    </div>
                    <div class="form-group" style="flex:1;min-width:120px;">
                        <label>Price (Rs)</label><input type="number" name="price" step="0.01" required>
                    </div>
                    <div class="form-group" style="flex:1;min-width:100px;">
                        <label>Stock</label><input type="number" name="stock" required>
                    </div>
                    <div class="form-group" style="flex:2;min-width:200px;">
                        <label>Description</label><input type="text" name="description">
                    </div>
                </div>
                <button type="submit" class="btn btn-success">➕ Add Product</button>
            </form>
        </div>

        <!-- Products Table -->
        <div class="card">
            <div class="card-title">All Products</div>
            <div class="table-wrap">
                <table>
                    <thead><tr><th>ID</th><th>Name</th><th>Category</th><th>Price</th><th>Stock</th><th>Actions</th></tr></thead>
                    <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td data-label="ID">${p.id}</td>
                            <td data-label="Name">${p.name}</td>
                            <td data-label="Category">${p.category}</td>
                            <td data-label="Price">Rs ${p.price}</td>
                            <td data-label="Stock">${p.stock}</td>
                            <td data-label="Actions">
                                <button class="btn btn-primary btn-sm"
                                        onclick="openEdit(${p.id},'${p.name}','${p.description}',${p.price},${p.stock},'${p.category}')">
                                    Edit
                                </button>
                                <form method="post" action="${pageContext.request.contextPath}/admin/products" style="display:inline;"
                                      onsubmit="return confirm('Delete ${p.name}?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${p.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty products}">
                        <tr><td colspan="6" style="text-align:center;color:#64748b;">No products found.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal-overlay" id="editModal">
    <div class="modal">
        <button class="modal-close" onclick="closeEdit()">✕</button>
        <h3>Edit Product</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/products">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="editId">
            <div class="form-group"><label>Name</label><input type="text" name="name" id="editName" required></div>
            <div class="form-group"><label>Description</label><input type="text" name="description" id="editDesc"></div>
            <div class="form-group"><label>Price (Rs)</label><input type="number" name="price" id="editPrice" step="0.01" required></div>
            <div class="form-group"><label>Stock</label><input type="number" name="stock" id="editStock" required></div>
            <div class="form-group"><label>Category</label><input type="text" name="category" id="editCat" required></div>
            <button type="submit" class="btn btn-primary btn-block">Update Product</button>
        </form>
    </div>
</div>
<script>
    function openEdit(id,name,desc,price,stock,cat){
        document.getElementById('editId').value=id;
        document.getElementById('editName').value=name;
        document.getElementById('editDesc').value=desc;
        document.getElementById('editPrice').value=price;
        document.getElementById('editStock').value=stock;
        document.getElementById('editCat').value=cat;
        document.getElementById('editModal').classList.add('active');
    }
    function closeEdit(){ document.getElementById('editModal').classList.remove('active'); }
</script>
</body></html>
