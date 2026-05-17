package com.ecommerce.model;

import java.math.BigDecimal;

public class CartItem {
    private long id;
    private Product product;
    private int quantity;

    public CartItem() {}
    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public long getId()                    { return id; }
    public void setId(long id)             { this.id = id; }
    public Product getProduct()            { return product; }
    public void setProduct(Product p)      { this.product = p; }
    public int getQuantity()               { return quantity; }
    public void setQuantity(int qty)       { this.quantity = qty; }

    public BigDecimal getLineTotal() {
        if (product == null || product.getPrice() == null) return BigDecimal.ZERO;
        return product.getPrice().multiply(BigDecimal.valueOf(quantity));
    }
}
