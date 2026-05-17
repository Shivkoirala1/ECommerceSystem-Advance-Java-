package com.ecommerce.controller;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final OrderDAO   orderDAO   = new OrderDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final UserDAO    userDAO    = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List orders = orderDAO.findAll();
            req.setAttribute("totalOrders",   orders.size());
            req.setAttribute("totalProducts", productDAO.findAll().size());
            req.setAttribute("totalUsers",    userDAO.findAll().size());
            req.setAttribute("recentOrders",  orders.size() > 5 ? orders.subList(0, 5) : orders);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
        }
        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }
}
