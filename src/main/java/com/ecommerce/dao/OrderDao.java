package com.advance.ecommerce.dao;

import com.advance.ecommerce.db.Db;
import com.advance.ecommerce.model.Order;
import com.advance.ecommerce.model.OrderItem;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO {

  public long placeOrder(long userId, List<OrderItem> items) throws Exception {
    if (items == null || items.isEmpty()) {
      throw new IllegalArgumentException("Order items cannot be empty");
    }

    BigDecimal total = BigDecimal.ZERO;
    for (OrderItem it : items) {
      total = total.add(it.getLineTotal());
    }

    String insertOrderSql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, ?)";
    String insertItemSql =
        "INSERT INTO order_items (order_id, product_id, quantity, unit_price, line_total) VALUES (?, ?, ?, ?, ?)";

    try (Connection con = Db.getConnection()) {
      con.setAutoCommit(false);
      try {
        long orderId;
        try (PreparedStatement ps =
            con.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
          ps.setLong(1, userId);
          ps.setBigDecimal(2, total);
          ps.setString(3, "PLACED");
          ps.executeUpdate();
          try (ResultSet rs = ps.getGeneratedKeys()) {
            if (!rs.next()) throw new IllegalStateException("No generated key for order insert");
            orderId = rs.getLong(1);
          }
        }

        try (PreparedStatement ps = con.prepareStatement(insertItemSql)) {
          for (OrderItem it : items) {
            ps.setLong(1, orderId);
            ps.setLong(2, it.getProductId());
            ps.setInt(3, it.getQuantity());
            ps.setBigDecimal(4, it.getUnitPrice());
            ps.setBigDecimal(5, it.getLineTotal());
            ps.addBatch();
          }
          ps.executeBatch();
        }

        con.commit();
        return orderId;
      } catch (Exception e) {
        con.rollback();
        throw e;
      } finally {
        con.setAutoCommit(true);
      }
    }
  }

  public List<Order> getOrdersByUser(long userId) throws Exception {
    String sql =
        "SELECT o.id AS order_id, o.user_id, o.total_amount, o.status, o.created_at, "
            + "i.id AS item_id, i.product_id, i.quantity, i.unit_price, i.line_total "
            + "FROM orders o "
            + "LEFT JOIN order_items i ON i.order_id = o.id "
            + "WHERE o.user_id = ? "
            + "ORDER BY o.id DESC, i.id ASC";

    try (Connection con = Db.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
      ps.setLong(1, userId);
      try (ResultSet rs = ps.executeQuery()) {
        Map<Long, Order> map = new HashMap<>();
        while (rs.next()) {
          long orderId = rs.getLong("order_id");
          Order o =
              map.computeIfAbsent(
                  orderId,
                  ignored -> {
                    Order ord = new Order();
                    ord.setId(orderId);
                    return ord;
                  });

          o.setUserId(rs.getLong("user_id"));
          o.setTotalAmount(rs.getBigDecimal("total_amount"));
          o.setStatus(rs.getString("status"));
          Timestamp created = rs.getTimestamp("created_at");
          o.setCreatedAt(created == null ? null : created.toInstant());

          long itemId = rs.getLong("item_id");
          if (!rs.wasNull()) {
            OrderItem it = new OrderItem();
            it.setId(itemId);
            it.setOrderId(orderId);
            it.setProductId(rs.getLong("product_id"));
            it.setQuantity(rs.getInt("quantity"));
            it.setUnitPrice(rs.getBigDecimal("unit_price"));
            it.setLineTotal(rs.getBigDecimal("line_total"));
            o.getItems().add(it);
          }
        }
        return new ArrayList<>(map.values());
      }
    }
  }
}

