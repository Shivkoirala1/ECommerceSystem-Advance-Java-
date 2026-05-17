package com.ecommerce.controller;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.model.CartItem;
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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            List<CartItem> items = cartDAO.findByUser(user.getId());
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : items) {
                total = total.add(item.getLineTotal());
            }
            req.setAttribute("cartItems", items);
            req.setAttribute("cartTotal", total);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
        }
        req.getRequestDispatcher("/views/customer/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        User user = (User) req.getSession().getAttribute("user");

        try {
            if (action.equals("add")) {
                long productId = Long.parseLong(req.getParameter("productId"));
                int qty = Integer.parseInt(req.getParameter("quantity"));
                cartDAO.addOrUpdate(user.getId(), productId, qty);
                resp.sendRedirect(req.getContextPath() + "/customer/products?success=Added+to+cart");
            } else if (action.equals("remove")) {
                long itemId = Long.parseLong(req.getParameter("itemId"));
                cartDAO.removeItem(itemId);
                resp.sendRedirect(req.getContextPath() + "/cart");
            } else if (action.equals("clear")) {
                cartDAO.clearCart(user.getId());
                resp.sendRedirect(req.getContextPath() + "/cart");
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart");
            }
        } catch (SQLException e) {
            resp.sendRedirect(req.getContextPath() + "/cart?error=" + e.getMessage());
        }
    }
}
