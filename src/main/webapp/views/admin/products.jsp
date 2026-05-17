<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Products - ShopNepal Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background: #f1f5f9; margin: 0; }
        .admin-wrap { display: flex; min-height: 100vh; }
        .admin-sidebar { width:240px; background:#1e293b; display:flex; flex-direction:column; position:fixed; top:0; left:0; height:100vh; z-index:50; }
        .sidebar-logo { padding:24px 20px; border-bottom:1px solid rgba(255,255,255,.08); }
        .sidebar-logo a { color:#fff; font-size:1.4rem; font-weight:900; text-decoration:none; }
        .sidebar-logo a span { color:#ff6b00; }
        .sidebar-logo p { color:#94a3b8; font-size:.78rem; margin-top:2px; }
        .sidebar-nav { padding:16px 0; flex:1; }
        .sidebar-nav a { display:flex; align-items:center; gap:12px; color:#94a3b8; text-decoration:none; padding:12px 20px; font-size:.93rem; font-weight:600; border-left:3px solid transparent; transition:all .2s; }
        .sidebar-nav a:hover { color:#fff; background:rgba(255,255,255,.05); }
        .sidebar-nav a.active { color:#fff; background:rgba(255,107,0,.15); border-left-color:#ff6b00; }
        .sidebar-bottom { padding:16px 0; border-top:1px solid rgba(255,255,255,.08); }
        .sidebar-bottom a { display:flex; align-items:center; gap:12px; color:#94a3b8; text-decoration:none; padding:12px 20px; font-size:.9rem; transition:color .2s; }
        .sidebar-bottom a:hover { color:#ef4444; }
        .admin-main { margin-left:240px; flex:1; }
        .admin-topbar { background:#fff; padding:0 32px; height:64px; display:flex; align-items:center; justify-content:space-between; box-shadow:0 1px 4px rgba(0,0,0,.08); position:sticky; top:0; z-index:40; }
        .admin-topbar h1 { font-size:1.1rem; font-weight:700; color:#1e293b; }
        .admin-content { padding:28px 32px; }

        /* Product table with images */
        .prod-table-img { width:56px; height:48px; object-fit:contain; border-radius:6px; background:#f8fafc; padding:4px; }
        .prod-emoji-sm { font-size:2rem; }

        /* Form card */
        .form-card { background:#fff; border-radius:14px; box-shadow:0 1px 6px rgba(0,0,0,.07); padding:24px; margin-bottom:24px; }
        .form-card h3 { font-size:1rem; font-weight:800; color:#1e293b; margin-bottom:18px; padding-bottom:10px; border-bottom:2px solid #f1f5f9; }
        .form-row { display:flex; gap:16px; flex-wrap:wrap; }
        .form-group { flex:1; min-width:180px; }
        .form-group label { display:block; margin-bottom:6px; font-weight:600; font-size:.88rem; color:#374151; }
        .form-group input, .form-group select, .form-group textarea { width:100%; padding:9px 12px; border:1.5px solid #e2e8f0; border-radius:8px; font-size:.92rem; font-family:inherit; transition:border .2s; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { border-color:#ff6b00; outline:none; }

        /* Table */
        .table-card { background:#fff; border-radius:14px; box-shadow:0 1px 6px rgba(0,0,0,.07); overflow:hidden; }
        .table-card-header { padding:18px 24px; border-bottom:1px solid #f1f5f9; display:flex; justify-content:space-between; align-items:center; }
        .table-card-header h3 { font-size:1rem; font-weight:800; color:#1e293b; }
        table { width:100%; border-collapse:collapse; }
        thead tr { background:#f8fafc; }
        thead th { padding:12px 16px; text-align:left; font-size:.8rem; font-weight:700; color:#64748b; text-transform:uppercase; letter-spacing:.5px; }
        tbody tr { border-bottom:1px solid #f1f5f9; transition:background .15s; }
        tbody tr:hover { background:#fafafa; }
        tbody td { padding:12px 16px; font-size:.9rem; color:#1e293b; }
        tbody tr:last-child { border-bottom:none; }

        /* Buttons */
        .btn { display:inline-block; padding:8px 18px; border:none; border-radius:7px; font-size:.88rem; font-weight:700; cursor:pointer; text-decoration:none; transition:opacity .2s; }
        .btn:hover { opacity:.88; }
        .btn-orange { background:#ff6b00; color:#fff; }
        .btn-blue   { background:#2563eb; color:#fff; }
        .btn-red    { background:#ef4444; color:#fff; }
        .btn-sm { padding:6px 12px; font-size:.8rem; }

        /* Alerts */
        .alert { padding:12px 18px; border-radius:8px; margin-bottom:16px; font-size:.92rem; }
        .alert-success { background:#f0fdf4; color:#15803d; border:1px solid #bbf7d0; }
        .alert-error   { background:#fef2f2; color:#b91c1c; border:1px solid #fecaca; }

        /* Modal */
        .modal-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,.5); z-index:999; align-items:center; justify-content:center; }
        .modal-overlay.active { display:flex; }
        .modal { background:#fff; border-radius:16px; padding:28px; width:100%; max-width:520px; box-shadow:0 8px 40px rgba(0,0,0,.18); max-height:90vh; overflow-y:auto; }
        .modal h3 { font-size:1.1rem; font-weight:800; margin-bottom:20px; }
        .modal-close { float:right; background:none; border:none; font-size:1.4rem; cursor:pointer; color:#94a3b8; }

        @media (max-width:768px) {
            .admin-sidebar { display:none; }
            .admin-main { margin-left:0; }
            .admin-content { padding:16px; }
        }
    </style>
</head>
<body>
<div class="admin-wrap">
    <aside class="admin-sidebar">
        <div class="sidebar-logo">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Shop<span>Nepal</span></a>
            <p>Admin Panel</p>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard"><span>📊</span> Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/products" class="active"><span>📦</span> Products</a>
            <a href="${pageContext.request.contextPath}/admin/orders"><span>🧾</span> Orders</a>
            <a href="${pageContext.request.contextPath}/admin/users"><span>👥</span> Users</a>
        </nav>
        <div class="sidebar-bottom">
            <a href="${pageContext.request.contextPath}/logout"><span>🚪</span> Logout</a>
        </div>
    </aside>

    <div class="admin-main">
        <div class="admin-topbar">
            <h1>📦 Manage Products</h1>
        </div>
        <div class="admin-content">

            <c:if test="${not empty param.success}"><div class="alert alert-success">✅ ${param.success}</div></c:if>
            <c:if test="${not empty error}"><div class="alert alert-error">❌ ${error}</div></c:if>

            <!-- Add Product Form -->
            <div class="form-card">
                <h3>➕ Add New Product</h3>
                <form method="post" action="${pageContext.request.contextPath}/admin/products">
                    <input type="hidden" name="action" value="add">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Product Name *</label>
                            <input type="text" name="name" placeholder="e.g. Laptop Pro" required>
                        </div>
                        <div class="form-group">
                            <label>Category *</label>
                            <select name="category" required>
                                <option value="">Select Category</option>
                                <option value="Electronics">Electronics</option>
                                <option value="Clothing">Clothing</option>
                                <option value="Footwear">Footwear</option>
                                <option value="Accessories">Accessories</option>
                                <option value="Mobiles">Mobiles</option>
                                <option value="General">General</option>
                            </select>
                        </div>
                        <div class="form-group" style="flex:0 0 130px;">
                            <label>Price (Rs) *</label>
                            <input type="number" name="price" step="0.01" min="0" placeholder="0.00" required>
                        </div>
                        <div class="form-group" style="flex:0 0 100px;">
                            <label>Stock *</label>
                            <input type="number" name="stock" min="0" placeholder="0" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group" style="flex:2;">
                            <label>Description</label>
                            <input type="text" name="description" placeholder="Short product description">
                        </div>
                        <div class="form-group" style="flex:2;">
                            <label>Image Path (e.g. images/laptop.jpg)</label>
                            <input type="text" name="imageUrl" placeholder="images/product.jpg">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-orange" style="margin-top:8px;">Add Product</button>
                </form>
            </div>

            <!-- Products Table -->
            <div class="table-card">
                <div class="table-card-header">
                    <h3>All Products (${products.size()})</h3>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>Image</th><th>Name</th><th>Category</th>
                        <th>Price</th><th>Stock</th><th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty p.imageUrl}">
                                        <img src="${pageContext.request.contextPath}/${p.imageUrl}"
                                             alt="${p.name}" class="prod-table-img"
                                             onerror="this.style.display='none';this.nextSibling.style.display='inline'">
                                        <span class="prod-emoji-sm" style="display:none;">${p.categoryEmoji}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="prod-emoji-sm">${p.categoryEmoji}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong>${p.name}</strong><br><span style="color:#64748b;font-size:.8rem;">${p.description}</span></td>
                            <td>${p.category}</td>
                            <td><strong style="color:#ff6b00;">Rs ${p.price}</strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.stock == 0}"><span style="color:#ef4444;font-weight:700;">Out of Stock</span></c:when>
                                    <c:when test="${p.stock <= 5}"><span style="color:#f59e0b;font-weight:700;">${p.stock} (Low)</span></c:when>
                                    <c:otherwise><span style="color:#22c55e;font-weight:700;">${p.stock}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-blue btn-sm"
                                        onclick="openEdit(${p.id},'${p.name}','${p.description}',${p.price},${p.stock},'${p.category}','${p.imageUrl}')">
                                    ✏️ Edit
                                </button>
                                <form method="post" action="${pageContext.request.contextPath}/admin/products"
                                      style="display:inline;" onsubmit="return confirm('Delete ${p.name}?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${p.id}">
                                    <button type="submit" class="btn btn-red btn-sm">🗑️ Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty products}">
                        <tr><td colspan="6" style="text-align:center;padding:32px;color:#94a3b8;">No products found. Add your first product above.</td></tr>
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
        <h3>✏️ Edit Product</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/products">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="editId">
            <div class="form-group"><label>Product Name *</label><input type="text" name="name" id="editName" required></div>
            <div class="form-group"><label>Description</label><input type="text" name="description" id="editDesc"></div>
            <div class="form-row">
                <div class="form-group"><label>Price (Rs) *</label><input type="number" name="price" id="editPrice" step="0.01" required></div>
                <div class="form-group"><label>Stock *</label><input type="number" name="stock" id="editStock" required></div>
            </div>
            <div class="form-group">
                <label>Category *</label>
                <select name="category" id="editCat" required>
                    <option value="Electronics">Electronics</option>
                    <option value="Clothing">Clothing</option>
                    <option value="Footwear">Footwear</option>
                    <option value="Accessories">Accessories</option>
                    <option value="Mobiles">Mobiles</option>
                    <option value="General">General</option>
                </select>
            </div>
            <div class="form-group"><label>Image Path</label><input type="text" name="imageUrl" id="editImg" placeholder="images/product.jpg"></div>
            <button type="submit" class="btn btn-orange" style="margin-top:8px;width:100%;">Update Product</button>
        </form>
    </div>
</div>

<script>
    function openEdit(id, name, desc, price, stock, cat, img) {
        document.getElementById('editId').value    = id;
        document.getElementById('editName').value  = name;
        document.getElementById('editDesc').value  = desc;
        document.getElementById('editPrice').value = price;
        document.getElementById('editStock').value = stock;
        document.getElementById('editCat').value   = cat;
        document.getElementById('editImg').value   = img || '';
        document.getElementById('editModal').classList.add('active');
    }
    function closeEdit() { document.getElementById('editModal').classList.remove('active'); }
    window.addEventListener('click', function(e) {
        if (e.target.id === 'editModal') closeEdit();
    });
</script>
</body>
</html>
