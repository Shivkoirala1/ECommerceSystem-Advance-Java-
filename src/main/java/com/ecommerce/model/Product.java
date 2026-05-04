package com.ecommerce.model;

import java.math.BigDecimal;

public class Product {
    private long id;
    private String name;
    private String description;
    private BigDecimal price;
    private int stock;
    private String category;

    public Product() {}

    public long getId()                        { return id; }
    public void setId(long id)                 { this.id = id; }
    public String getName()                    { return name; }
    public void setName(String name)           { this.name = name; }
    public String getDescription()             { return description; }
    public void setDescription(String d)       { this.description = d; }
    public BigDecimal getPrice()               { return price; }
    public void setPrice(BigDecimal price)     { this.price = price; }
    public int getStock()                      { return stock; }
    public void setStock(int stock)            { this.stock = stock; }
    public String getCategory()                { return category; }
    public void setCategory(String category)   { this.category = category; }
}
