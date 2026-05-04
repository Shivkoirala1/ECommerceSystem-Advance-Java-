package com.ecommerce.dao;

import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public List<CartItem> findByUser(long userId) throws SQLException {
        String sql = "SELECT c.id, c.quantity, p.id as pid, p.name, p.description, "
                + "p.price, p.stock, p.category FROM cart c "
                + "JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
        try (Connection con = DBConnection.getActiveConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, userId);
            List<CartItem> items = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getLong("pid"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getBigDecimal("price"));
                    p.setStock(rs.getInt("stock"));
                    p.setCategory(rs.getString("category"));
                    CartItem item = new CartItem(p, rs.getInt("quantity"));
                    item.setId(rs.getLong("id"));
                    items.add(item);
                }
            }
            return items;
        }
    }

    public void addOrUpdate(long userId, long productId, int quantity) throws SQLException {
        String check = "SELECT id, quantity FROM cart WHERE user_id=? AND product_id=?";
        try (Connection con = DBConnection.getActiveConnection();
             PreparedStatement ps = con.prepareStatement(check)) {
            ps.setLong(1, userId);
            ps.setLong(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int newQty = rs.getInt("quantity") + quantity;
                    String upd = "UPDATE cart SET quantity=? WHERE id=?";
                    try (PreparedStatement u = con.prepareStatement(upd)) {
                        u.setInt(1, newQty);
                        u.setLong(2, rs.getLong("id"));
                        u.executeUpdate();
                    }
                } else {
                    String ins = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?,?,?)";
                    try (PreparedStatement i = con.prepareStatement(ins)) {
                        i.setLong(1, userId);
                        i.setLong(2, productId);
                        i.setInt(3, quantity);
                        i.executeUpdate();
                    }
                }
            }
        }
    }

    public void removeItem(long cartItemId) throws SQLException {
        String sql = "DELETE FROM cart WHERE id=?";
        try (Connection con = DBConnection.getActiveConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, cartItemId);
            ps.executeUpdate();
        }
    }

    public void clearCart(long userId) throws SQLException {
        String sql = "DELETE FROM cart WHERE user_id=?";
        try (Connection con = DBConnection.getActiveConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.executeUpdate();
        }
    }
}
