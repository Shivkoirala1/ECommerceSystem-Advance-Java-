package com.ecommerce.controller;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;
import com.ecommerce.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Read all values first
        String fullName = req.getParameter("fullName");
        String username = req.getParameter("username");
        String email    = req.getParameter("email");
        String phone    = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirmPassword");

        // Helper to forward back WITH all values preserved
        // Values are kept via ${param.xxx} in JSP automatically
        // We just need to set the error and forward (not redirect)

        if (ValidationUtil.isEmpty(fullName) || ValidationUtil.isEmpty(username) ||
                ValidationUtil.isEmpty(email)    || ValidationUtil.isEmpty(phone)     ||
                ValidationUtil.isEmpty(password)) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil.isValidName(fullName)) {
            req.setAttribute("error", "Full name must contain only letters and spaces.");
            req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil.isValidUsername(username)) {
            req.setAttribute("error", "Username must be 4-20 characters, letters/numbers/underscore only.");
            req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            req.setAttribute("error", "Please enter a valid email address.");
            req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            req.setAttribute("error", "Phone must be exactly 10 digits.");
            req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil.isValidPassword(password)) {
            req.setAttribute("error", "Password must be at least 6 characters with 1 uppercase and 1 number.");
            req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
            return;
        }
        if (confirm == null || !password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
            return;
        }

        try {
            if (userDAO.findByUsername(username).isPresent()) {
                req.setAttribute("error", "Username '" + username + "' is already taken. Please choose another.");
                req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
                return;
            }
            if (userDAO.findByEmail(email).isPresent()) {
                req.setAttribute("error", "Email '" + email + "' is already registered.");
                req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
                return;
            }
            if (userDAO.findByPhone(phone).isPresent()) {
                req.setAttribute("error", "Phone number '" + phone + "' is already registered.");
                req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
                return;
            }
            User user = new User();
            user.setFullName(fullName.trim());
            user.setUsername(username.trim());
            user.setEmail(email.trim());
            user.setPhone(phone.trim());
            user.setPassword(password);
            user.setRole("CUSTOMER");
            userDAO.register(user);
            resp.sendRedirect(req.getContextPath() + "/login?success=Account+created+successfully!+Please+login.");
        } catch (SQLException e) {
            req.setAttribute("error", "Registration failed: " + e.getMessage());
            req.getRequestDispatcher("/views/common/register.jsp").forward(req, resp);
        }
    }
}
