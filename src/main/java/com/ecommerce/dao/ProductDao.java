package com.advance.ecommerce.dao;

import com.advance.ecommerce.db.Db;
import com.advance.ecommerce.model.Product;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductDAO {

  public long addProduct(Product p) throws Exception {
    String sql = "INSERT INTO products (name, description, price, stock) VALUES (?, ?, ?, ?)";
    try (Connection con = Db.getConnection();
        PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
      ps.setString(1, p.getName());
      ps.setString(2, p.getDescription());
      ps.setBigDecimal(3, p.getPrice());
      ps.setInt(4, p.getStock());
      ps.executeUpdate();
      try (ResultSet rs = ps.getGeneratedKeys()) {
        if (rs.next()) return rs.getLong(1);
        throw new IllegalStateException("No generated key returned for product insert");
      }
    }
  }

  public boolean updateProduct(Product p) throws Exception {
    String sql = "UPDATE products SET name=?, description=?, price=?, stock=? WHERE id=?";
    try (Connection con = Db.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
      ps.setString(1, p.getName());
      ps.setString(2, p.getDescription());
      ps.setBigDecimal(3, p.getPrice());
      ps.setInt(4, p.getStock());
      ps.setLong(5, p.getId());
      return ps.executeUpdate() > 0;
    }
  }

  public boolean deleteProduct(long id) throws Exception {
    String sql = "DELETE FROM products WHERE id=?";
    try (Connection con = Db.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
      ps.setLong(1, id);
      return ps.executeUpdate() > 0;
    }
  }

  public Optional<Product> getProductById(long id) throws Exception {
    String sql =
        "SELECT id, name, description, price, stock, created_at, updated_at FROM products WHERE id=?";
    try (Connection con = Db.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
      ps.setLong(1, id);
      try (ResultSet rs = ps.executeQuery()) {
        if (!rs.next()) return Optional.empty();
        return Optional.of(map(rs));
      }
    }
  }

  public List<Product> getAllProducts() throws Exception {
    String sql = "SELECT id, name, description, price, stock, created_at, updated_at FROM products";
    try (Connection con = Db.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      List<Product> out = new ArrayList<>();
      while (rs.next()) out.add(map(rs));
      return out;
    }
  }

  public boolean decreaseStock(long productId, int qty) throws Exception {
    String sql = "UPDATE products SET stock = stock - ? WHERE id=? AND stock >= ?";
    try (Connection con = Db.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
      ps.setInt(1, qty);
      ps.setLong(2, productId);
      ps.setInt(3, qty);
      return ps.executeUpdate() > 0;
    }
  }

  private static Product map(ResultSet rs) throws Exception {
    Product p = new Product();
    p.setId(rs.getLong("id"));
    p.setName(rs.getString("name"));
    p.setDescription(rs.getString("description"));
    BigDecimal price = rs.getBigDecimal("price");
    p.setPrice(price == null ? BigDecimal.ZERO : price);
    p.setStock(rs.getInt("stock"));

    Timestamp created = rs.getTimestamp("created_at");
    p.setCreatedAt(created == null ? null : created.toInstant());
    Timestamp updated = rs.getTimestamp("updated_at");
    p.setUpdatedAt(updated == null ? null : updated.toInstant());
    return p;
  }
}

