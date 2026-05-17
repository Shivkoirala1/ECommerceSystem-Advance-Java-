package com.ecommerce.model;

import java.math.BigDecimal;

public class Product {
    private long id;
    private String name;
    private String description;
    private BigDecimal price;
    private int stock;
    private String category;
    private String imageUrl;

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
    public String getImageUrl()                { return imageUrl; }
    public void setImageUrl(String imageUrl)   { this.imageUrl = imageUrl; }

    // Returns emoji based on category if no image set
    public String getCategoryEmoji() {
        if (category == null) return "📦";
        switch (category.toLowerCase()) {
            case "electronics": return "💻";
            case "clothing":    return "👕";
            case "footwear":    return "👟";
            case "accessories": return "🎒";
            case "mobiles":     return "📱";
            default:            return "📦";
        }
    }
}
