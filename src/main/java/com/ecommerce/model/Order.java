package com.ecommerce.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class Order {
    private long id;
    private long userId;
    private BigDecimal totalPrice;
    private String status;
    private String deliveryAddress;
    private LocalDateTime orderDate;
    private List<CartItem> items;

    public Order() {}

    public long getId()                            { return id; }
    public void setId(long id)                     { this.id = id; }
    public long getUserId()                        { return userId; }
    public void setUserId(long userId)             { this.userId = userId; }
    public BigDecimal getTotalPrice()              { return totalPrice; }
    public void setTotalPrice(BigDecimal t)        { this.totalPrice = t; }
    public String getStatus()                      { return status; }
    public void setStatus(String status)           { this.status = status; }
    public String getDeliveryAddress()             { return deliveryAddress; }
    public void setDeliveryAddress(String addr)    { this.deliveryAddress = addr; }
    public LocalDateTime getOrderDate()            { return orderDate; }
    public void setOrderDate(LocalDateTime d)      { this.orderDate = d; }
    public List<CartItem> getItems()               { return items; }
    public void setItems(List<CartItem> items)     { this.items = items; }
}
