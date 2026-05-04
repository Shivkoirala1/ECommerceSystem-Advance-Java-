package com.ecommerce.dao;

import com.ecommerce.model.CartItem;
import com.ecommerce.model.Order;
import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public Order save(Order order, List<CartItem> items) throws SQLException {
        String insOrder = "INSERT INTO orders (user_id, total_price, status, delivery_address) VALUES (?,?,?,?)";
        String insItem  = "INSERT INTO order_items (order_id, product_id, product_name, unit_price, quantity, line_total) VALUES (?,?,?,?,?,?)";
        try (Connection con = DBConnection.getActiveConnection()) {
            con.setAutoCommit(false);
            try {
                long orderId;
                try (PreparedStatement ps = con.prepareStatement(insOrder, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setLong(1, order.getUserId());
                    ps.setBigDecimal(2, order.getTotalPrice());
                    ps.setString(3, "PENDING");
                    ps.setString(4, order.getDeliveryAddress());
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        rs.next();
                        orderId = rs.getLong(1);
                    }
                }
                try (PreparedStatement ps = con.prepareStatement(insItem)) {
                    for (CartItem item : items) {
                        ps.setLong(1, orderId);
                        ps.setLong(2, item.getProduct().getId());
                        ps.setString(3, item.getProduct().getName());
                        ps.setBigDecimal(4, item.getProduct().getPrice());
                        ps.setInt(5, item.getQuantity());
                        ps.setBigDecimal(6, item.getLineTotal());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
                con.commit();
                order.setId(orderId);
                return order;
            } catch (SQLException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    public List<Order> findByUser(long userId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE user_id=? ORDER BY id DESC";
        return queryOrders(sql, userId, true);
    }

    public List<Order> findAll() throws SQLException {
        String sql = "SELECT * FROM orders ORDER BY id DESC";
        return queryOrders(sql, -1, false);
    }

    public boolean updateStatus(long orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status=? WHERE id=?";
        try (Connection con = DBConnection.getActiveConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    private List<Order> queryOrders(String sql, long userId, boolean bindUserId) throws SQLException {
        try (Connection con = DBConnection.getActiveConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (bindUserId) ps.setLong(1, userId);
            List<Order> list = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getLong("id"));
                    o.setUserId(rs.getLong("user_id"));
                    o.setTotalPrice(rs.getBigDecimal("total_price"));
                    o.setStatus(rs.getString("status"));
                    o.setDeliveryAddress(rs.getString("delivery_address"));
                    Timestamp ts = rs.getTimestamp("order_date");
                    if (ts != null) o.setOrderDate(ts.toLocalDateTime());
                    o.setItems(getItems(con, o.getId()));
                    list.add(o);
                }
            }
            return list;
        }
    }

    private List<CartItem> getItems(Connection con, long orderId) throws SQLException {
        String sql = "SELECT * FROM order_items WHERE order_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, orderId);
            List<CartItem> items = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getLong("product_id"));
                    p.setName(rs.getString("product_name"));
                    p.setPrice(rs.getBigDecimal("unit_price"));
                    items.add(new CartItem(p, rs.getInt("quantity")));
                }
            }
            return items;
        }
    }
}
