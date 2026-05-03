package com.ecommerce.controller;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User u = (User) session.getAttribute("user");
            resp.sendRedirect(req.getContextPath() + (u.isAdmin() ? "/admin/dashboard" : "/customer/products"));
            return;
        }
        req.getRequestDispatcher("/views/common/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            req.setAttribute("error", "Username and password are required.");
            req.getRequestDispatcher("/views/common/login.jsp").forward(req, resp);
            return;
        }
        try {
            Optional<User> result = userDAO.login(username.trim(), password.trim());
            if (result.isEmpty()) {
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("/views/common/login.jsp").forward(req, resp);
                return;
            }
            User user = result.get();
            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60);
            String remember = req.getParameter("remember");
            if ("on".equals(remember)) {
                Cookie cookie = new Cookie("username", user.getUsername());
                cookie.setMaxAge(7 * 24 * 60 * 60);
                cookie.setPath("/");
                resp.addCookie(cookie);
            }
            resp.sendRedirect(req.getContextPath() + (user.isAdmin() ? "/admin/dashboard" : "/customer/products"));
        } catch (SQLException e) {
            req.setAttribute("error", "System error: " + e.getMessage());
            req.getRequestDispatcher("/views/common/login.jsp").forward(req, resp);
        }
    }
}
