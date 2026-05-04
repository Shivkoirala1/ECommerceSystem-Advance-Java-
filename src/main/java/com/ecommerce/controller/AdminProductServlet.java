package com.ecommerce.controller;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("products", productDAO.findAll());
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
        }
        req.getRequestDispatcher("/views/admin/products.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";

        try {
            if (action.equals("add")) {
                addProduct(req, resp);
            } else if (action.equals("update")) {
                updateProduct(req, resp);
            } else if (action.equals("delete")) {
                deleteProduct(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        } catch (SQLException e) {
            try {
                req.setAttribute("error", "Operation failed: " + e.getMessage());
                req.setAttribute("products", productDAO.findAll());
            } catch (SQLException ex) {
                req.setAttribute("error", "Database error: " + ex.getMessage());
            }
            req.getRequestDispatcher("/views/admin/products.jsp").forward(req, resp);
        }
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException, ServletException {
        String name     = req.getParameter("name");
        String desc     = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String stockStr = req.getParameter("stock");
        String category = req.getParameter("category");

        if (name == null || name.trim().isEmpty() ||
                priceStr == null || stockStr == null ||
                category == null || category.trim().isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.setAttribute("products", productDAO.findAll());
            req.getRequestDispatcher("/views/admin/products.jsp").forward(req, resp);
            return;
        }

        Product p = new Product();
        p.setName(name.trim());
        p.setDescription(desc == null ? "" : desc.trim());
        p.setPrice(new BigDecimal(priceStr.trim()));
        p.setStock(Integer.parseInt(stockStr.trim()));
        p.setCategory(category.trim());
        productDAO.add(p);
        resp.sendRedirect(req.getContextPath() + "/admin/products?success=Product+added+successfully");
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        Product p = new Product();
        p.setId(id);
        p.setName(req.getParameter("name").trim());
        p.setDescription(req.getParameter("description").trim());
        p.setPrice(new BigDecimal(req.getParameter("price").trim()));
        p.setStock(Integer.parseInt(req.getParameter("stock").trim()));
        p.setCategory(req.getParameter("category").trim());
        productDAO.update(p);
        resp.sendRedirect(req.getContextPath() + "/admin/products?success=Product+updated+successfully");
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        productDAO.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/products?success=Product+deleted+successfully");
    }
}
