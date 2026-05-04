package com.ecommerce.dao;

import com.ecommerce.model.User;
import com.ecommerce.util.DBConnection;
import com.ecommerce.util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserDAO {

    public Optional<User> findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return Optional.empty();
                return Optional.of(map(rs));
            }
        }
    }

    public Optional<User> findByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return Optional.empty();
                return Optional.of(map(rs));
            }
        }
    }

    public Optional<User> findByPhone(String phone) throws SQLException {
        String sql = "SELECT * FROM users WHERE phone = ?";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return Optional.empty();
                return Optional.of(map(rs));
            }
        }
    }

    public Optional<User> login(String username, String rawPassword) throws SQLException {
        Optional<User> user = findByUsername(username);
        if (user.isEmpty()) return Optional.empty();
        if (!PasswordUtil.checkPassword(rawPassword, user.get().getPassword()))
            return Optional.empty();
        return user;
    }

    public User register(User user) throws SQLException {
        String sql = "INSERT INTO users (full_name, username, email, phone, password, role, is_approved) VALUES (?,?,?,?,?,?,1)";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, PasswordUtil.hashPassword(user.getPassword()));
            ps.setString(6, user.getRole() == null ? "CUSTOMER" : user.getRole());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) user.setId(rs.getLong(1));
            }
            return user;
        }
    }

    public List<User> findAll() throws SQLException {
        String sql = "SELECT * FROM users ORDER BY id DESC";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<User> list = new ArrayList<>();
            while (rs.next()) list.add(map(rs));
            return list;
        }
    }

    public boolean deleteUser(long id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private User map(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getLong("id"));
        u.setFullName(rs.getString("full_name"));
        u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setPassword(rs.getString("password"));
        u.setRole(rs.getString("role"));
        u.setApproved(rs.getInt("is_approved") == 1);
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) u.setCreatedAt(ts.toLocalDateTime());
        return u;
    }
}
