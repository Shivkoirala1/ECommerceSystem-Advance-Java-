package com.ecommerce.controller;

import com.ecommerce.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("users", userDAO.findAll());
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
        }
        req.getRequestDispatcher("/views/admin/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            long id = Long.parseLong(req.getParameter("id"));
            userDAO.deleteUser(id);
            resp.sendRedirect(req.getContextPath() + "/admin/users?success=User+deleted");
        } catch (SQLException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/users?error=" + e.getMessage());
        }
    }
}
