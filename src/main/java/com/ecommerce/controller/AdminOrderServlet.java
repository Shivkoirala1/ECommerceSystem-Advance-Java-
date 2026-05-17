package com.ecommerce.controller;

import com.ecommerce.dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("orders", orderDAO.findAll());
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
        }
        req.getRequestDispatcher("/views/admin/orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            long orderId  = Long.parseLong(req.getParameter("orderId"));
            String status = req.getParameter("status");
            orderDAO.updateStatus(orderId, status);
            resp.sendRedirect(req.getContextPath() + "/admin/orders?success=Status+updated");
        } catch (SQLException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/orders?error=" + e.getMessage());
        }
    }
}
