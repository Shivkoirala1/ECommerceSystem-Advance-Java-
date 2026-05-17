package com.ecommerce.controller;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.OrderDAO;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Order;
import com.ecommerce.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/order/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDAO  cartDAO  = new CartDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            List<CartItem> items = cartDAO.findByUser(user.getId());
            if (items.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart?error=Your+cart+is+empty");
                return;
            }
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : items) {
                total = total.add(item.getLineTotal());
            }
            req.setAttribute("cartItems", items);
            req.setAttribute("cartTotal", total);
            req.getRequestDispatcher("/views/customer/checkout.jsp").forward(req, resp);
        } catch (SQLException e) {
            resp.sendRedirect(req.getContextPath() + "/cart?error=" + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        String address = req.getParameter("address");

        if (address == null || address.trim().isEmpty()) {
            req.setAttribute("error", "Delivery address is required.");
            doGet(req, resp);
            return;
        }

        try {
            List<CartItem> items = cartDAO.findByUser(user.getId());
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : items) {
                total = total.add(item.getLineTotal());
            }
            Order order = new Order();
            order.setUserId(user.getId());
            order.setTotalPrice(total);
            order.setDeliveryAddress(address.trim());
            Order saved = orderDAO.save(order, items);
            cartDAO.clearCart(user.getId());
            resp.sendRedirect(req.getContextPath() + "/order/history?success=Order+%23"
                    + saved.getId() + "+placed+successfully!");
        } catch (SQLException e) {
            req.setAttribute("error", "Checkout failed: " + e.getMessage());
            doGet(req, resp);
        }
    }
}
