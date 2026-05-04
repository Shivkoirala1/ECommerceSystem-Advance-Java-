-- ============================================
-- ECommerce System Database Schema
-- ============================================

CREATE DATABASE IF NOT EXISTS ecommerce_jsp;
USE ecommerce_jsp;

DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
                       id          BIGINT AUTO_INCREMENT PRIMARY KEY,
                       username    VARCHAR(50)  NOT NULL UNIQUE,
                       full_name   VARCHAR(100) NOT NULL,
                       email       VARCHAR(100) NOT NULL UNIQUE,
                       phone       VARCHAR(20)  DEFAULT NULL,
                       password    VARCHAR(255) NOT NULL,
                       role        VARCHAR(20)  NOT NULL DEFAULT 'CUSTOMER',
                       is_approved TINYINT(1)   NOT NULL DEFAULT 1,
                       created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
                          id          BIGINT AUTO_INCREMENT PRIMARY KEY,
                          name        VARCHAR(100)   NOT NULL,
                          description TEXT,
                          price       DECIMAL(10, 2) NOT NULL,
                          stock       INT            NOT NULL DEFAULT 0,
                          category    VARCHAR(50)    NOT NULL DEFAULT 'General',
                          created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
                        id               BIGINT AUTO_INCREMENT PRIMARY KEY,
                        user_id          BIGINT         NOT NULL,
                        total_price      DECIMAL(10, 2) NOT NULL,
                        status           VARCHAR(20)    NOT NULL DEFAULT 'PENDING',
                        delivery_address VARCHAR(255)   NOT NULL DEFAULT '',
                        order_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE order_items (
                             id           BIGINT AUTO_INCREMENT PRIMARY KEY,
                             order_id     BIGINT         NOT NULL,
                             product_id   BIGINT         NOT NULL,
                             product_name VARCHAR(255),
                             unit_price   DECIMAL(10, 2),
                             quantity     INT            NOT NULL,
                             line_total   DECIMAL(10, 2) NOT NULL,
                             FOREIGN KEY (order_id)   REFERENCES orders(id),
                             FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE cart (
                      id         BIGINT AUTO_INCREMENT PRIMARY KEY,
                      user_id    BIGINT NOT NULL,
                      product_id BIGINT NOT NULL,
                      quantity   INT    NOT NULL DEFAULT 1,
                      FOREIGN KEY (user_id)   REFERENCES users(id),
                      FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Admin password = admin123 (BCrypt $2a$ hash compatible with jbcrypt 0.4)
INSERT INTO users (username, full_name, email, phone, password, role, is_approved) VALUES
    ('admin', 'System Admin', 'admin@ecommerce.com', '9999999999',
     '$2a$10$BbEbJNdc.t1HEtb0eUZLOOlzO6B2gYBh47OGnLDz33SpnrkYWd.OO', 'ADMIN', 1);

INSERT INTO products (name, description, price, stock, category) VALUES
                                                                     ('Laptop',        'High performance laptop',     85000.00, 10, 'Electronics'),
                                                                     ('Smartphone',    'Latest android smartphone',   45000.00, 25, 'Electronics'),
                                                                     ('Headphones',    'Noise cancelling headphones',  3500.00, 50, 'Electronics'),
                                                                     ('T-Shirt',       'Cotton casual t-shirt',          799.00,100, 'Clothing'),
                                                                     ('Running Shoes', 'Comfortable running shoes',    3200.00, 30, 'Footwear'),
                                                                     ('Backpack',      'Waterproof travel backpack',   2500.00, 40, 'Accessories');
