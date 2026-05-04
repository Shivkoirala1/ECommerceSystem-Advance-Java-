package com.ecommerce.controller;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/order/history")
public class OrderHistoryServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            req.setAttribute("orders", orderDAO.findByUser(user.getId()));
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
        }
        req.getRequestDispatcher("/views/customer/orderhistory.jsp").forward(req, resp);
    }
}
