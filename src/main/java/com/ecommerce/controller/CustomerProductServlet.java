package com.ecommerce.controller;

import com.ecommerce.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/customer/products")
public class CustomerProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String search   = req.getParameter("search");
            String category = req.getParameter("category");
            if (search != null && !search.trim().isEmpty()) {
                req.setAttribute("products", productDAO.search(search.trim()));
                req.setAttribute("search", search);
            } else if (category != null && !category.trim().isEmpty()) {
                req.setAttribute("products", productDAO.findByCategory(category.trim()));
                req.setAttribute("category", category);
            } else {
                req.setAttribute("products", productDAO.findAll());
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
        }
        req.getRequestDispatcher("/views/customer/products.jsp").forward(req, resp);
    }
}
