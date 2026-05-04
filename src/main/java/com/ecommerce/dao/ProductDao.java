package com.ecommerce.dao;

import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductDAO {

    public List<Product> findAll() throws SQLException {
        String sql = "SELECT * FROM products ORDER BY id DESC";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Product> list = new ArrayList<>();
            while (rs.next()) list.add(map(rs));
            return list;
        }
    }

    public List<Product> findByCategory(String category) throws SQLException {
        String sql = "SELECT * FROM products WHERE category = ? ORDER BY id DESC";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, category);
            try (ResultSet rs = ps.executeQuery()) {
                List<Product> list = new ArrayList<>();
                while (rs.next()) list.add(map(rs));
                return list;
            }
        }
    }

    public List<Product> search(String keyword) throws SQLException {
        String sql = "SELECT * FROM products WHERE name LIKE ? OR category LIKE ? ORDER BY id DESC";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                List<Product> list = new ArrayList<>();
                while (rs.next()) list.add(map(rs));
                return list;
            }
        }
    }

    public Optional<Product> findById(long id) throws SQLException {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return Optional.empty();
                return Optional.of(map(rs));
            }
        }
    }

    public Product add(Product p) throws SQLException {
        String sql = "INSERT INTO products (name, description, price, stock, category) VALUES (?,?,?,?,?)";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getCategory());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) p.setId(rs.getLong(1));
            }
            return p;
        }
    }

    public boolean update(Product p) throws SQLException {
        String sql = "UPDATE products SET name=?, description=?, price=?, stock=?, category=? WHERE id=?";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getCategory());
            ps.setLong(6, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(long id) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection c = DBConnection.getActiveConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Product map(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getLong("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setStock(rs.getInt("stock"));
        p.setCategory(rs.getString("category"));
        return p;
    }
}
