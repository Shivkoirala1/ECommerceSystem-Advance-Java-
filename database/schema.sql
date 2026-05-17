-- ============================================
-- ECommerce System Database Schema
-- ShopNepal - Advanced Programming CS5054NT
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

-- image_url is NOW part of CREATE TABLE — no ALTER needed
CREATE TABLE products (
                          id          BIGINT AUTO_INCREMENT PRIMARY KEY,
                          name        VARCHAR(100)   NOT NULL,
                          description TEXT,
                          price       DECIMAL(10, 2) NOT NULL,
                          stock       INT            NOT NULL DEFAULT 0,
                          category    VARCHAR(50)    NOT NULL DEFAULT 'General',
                          image_url   VARCHAR(255)   DEFAULT NULL,
                          created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
                        id               BIGINT         AUTO_INCREMENT PRIMARY KEY,
                        user_id          BIGINT         NOT NULL,
                        total_price      DECIMAL(10, 2) NOT NULL,
                        status           VARCHAR(20)    NOT NULL DEFAULT 'PENDING',
                        delivery_address VARCHAR(255)   NOT NULL DEFAULT '',
                        order_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE order_items (
                             id           BIGINT         AUTO_INCREMENT PRIMARY KEY,
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
                      FOREIGN KEY (user_id)    REFERENCES users(id),
                      FOREIGN KEY (product_id) REFERENCES products(id)
);

-- ============================================
-- USERS: Admin password = admin123
-- ============================================
INSERT INTO users (username, full_name, email, phone, password, role, is_approved) VALUES
    ('admin', 'System Admin', 'admin@shopnepal.com', '9999999999',
     '$2a$10$BbEbJNdc.t1HEtb0eUZLOOlzO6B2gYBh47OGnLDz33SpnrkYWd.OO', 'ADMIN', 1);

-- ============================================
-- PRODUCTS — every product has its own unique
-- image_url exactly as you originally defined
-- ============================================

-- ===== ELECTRONICS =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('HP Victus Gaming Laptop',     'Core i7, RTX 4060, 16GB RAM, 512GB SSD — ideal for gaming and design', 95000.00,  8, 'Electronics', 'images/laptop.jpg'),
                                                                                ('Dell Inspiron 15',            'Core i5, 8GB RAM, 256GB SSD, perfect everyday laptop',                 72000.00, 12, 'Electronics', 'images/products/dell.jpg'),
                                                                                ('Lenovo IdeaPad Slim 5',       'Ryzen 5, 8GB RAM, 512GB SSD, lightweight and fast',                    68000.00, 15, 'Electronics', 'images/products/lenovo.jpg'),
                                                                                ('Sony WH-1000XM5 Headphones',  'Industry-leading noise cancellation, 30hr battery, premium sound',     28800.00, 20, 'Electronics', 'images/products/sonyheadphone.jpg'),
                                                                                ('JBL Flip 6 Bluetooth Speaker','Powerful bass, waterproof, 12hr playtime, PartyBoost enabled',          9500.00, 30, 'Electronics', 'images/products/jbl.jpg'),
                                                                                ('Earpods Pro Max',             'Active noise cancellation, crystal clear audio, wireless charging',     28800.00, 25, 'Electronics', 'images/earpods.jpg'),
                                                                                ('Zebronics Earbuds',           'True wireless, 20hr total playback, touch controls',                    1800.00, 60, 'Electronics', 'images/products/earbuds.jpg'),
                                                                                ('Samsung 43" Smart TV',        '4K UHD, HDR10+, built-in Netflix & YouTube, slim bezel design',        55000.00,  6, 'Electronics', 'images/products/smarttv.jpg'),
                                                                                ('Canon EOS M50 Camera',        '24.1MP mirrorless, 4K video, dual pixel autofocus, vlog-ready',        65000.00,  5, 'Electronics', 'images/products/camera.jpg'),
                                                                                ('Logitech Wireless Mouse',     'Ergonomic design, 18-month battery, 1000 DPI optical sensor',           1500.00, 80, 'Electronics', 'images/products/mouse.jpg'),
                                                                                ('Mechanical Keyboard',         'RGB backlit, tactile blue switches, anti-ghosting, USB-C',              4500.00, 35, 'Electronics', 'images/products/keyboard.jpg'),
                                                                                ('USB-C Hub 7-in-1',            'HDMI 4K, 3x USB 3.0, SD card, PD charging — plug and play',            2200.00, 50, 'Electronics', 'images/products/usb_hub.jpg'),
                                                                                ('Sonata Digital Watch',        'Multi-function display, stopwatch, alarm, water resistant',             1300.00, 40, 'Electronics', 'images/products/sonatadigital.jpg');

-- ===== PHONES =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('Redmi Note 14 Pro',  '200MP camera, 5000mAh battery, 5G, AMOLED 120Hz display',        38000.00, 20, 'Phone', 'images/products/redminote14pro.jpg'),
                                                                                ('Samsung Galaxy A55', '50MP triple camera, 5000mAh, 45W charging, IP67 rated',           52000.00, 15, 'Phone', 'images/products/samsunga55.jpg'),
                                                                                ('iPhone 15',          'A16 Bionic chip, 48MP camera, Dynamic Island, USB-C, 6.1" OLED', 145000.00,  8, 'Phone', 'images/products/iphone15.jpg'),
                                                                                ('Vivo V29e',          '50MP OIS camera, 5000mAh, 44W flash charge, 6.78" AMOLED',        32000.00, 22, 'Phone', 'images/products/vivov29e.jpg'),
                                                                                ('Oppo Reno 11F',      '64MP camera, 67W SUPERVOOC, 6.7" AMOLED, 8GB RAM',               36000.00, 18, 'Phone', 'images/products/opporeno11f.jpg'),
                                                                                ('Xiaomi Pad 6',       '11" 144Hz display, Snapdragon 870, quad speakers, 8840mAh tablet',42000.00, 10, 'Phone', 'images/products/xiaomipad6.jpg'),
                                                                                ('Nokia G42',          '50MP camera, 5G ready, 3-year software guarantee, 5000mAh',       22000.00, 30, 'Phone', 'images/products/nokia_g42.jpg');

-- ===== MEN WEAR =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('Nepal Cricket Jersey 2024', 'Official replica jersey, polyester, sizes S–XXL',                 799.00, 100, 'Men Wear', 'images/products/cricketjersey.jpg'),
                                                                                ('Men Polo T-Shirt',          '100% cotton pique, breathable, available in 6 colors',            650.00,  80, 'Men Wear', 'images/products/polo_tshirt.jpg'),
                                                                                ('Cargo Pants',               'Multi-pocket slim-fit cargo, durable cotton blend, khaki/black', 1800.00,  45, 'Men Wear', 'images/products/cargopants.jpg'),
                                                                                ('Men Formal Shirt',          'Oxford cotton, slim-fit, wrinkle resistant, office ready',        1200.00,  60, 'Men Wear', 'images/products/formalshirt.jpg'),
                                                                                ('Denim Jeans',               'Stretchable slim-fit denim, sizes 28–40, dark wash',             1500.00,  70, 'Men Wear', 'images/products/denim_jeans'),
                                                                                ('Men Hoodie Sweatshirt',     'Fleece lined, kangaroo pocket, unisex fit, multiple colors',     1100.00,  55, 'Men Wear', 'images/products/hoodie_sweatshirt.jpg'),
                                                                                ('Men Tracksuit Set',         'Moisture wicking, elasticated waist, gym & jogger use',          1400.00,  40, 'Men Wear', 'images/products/tracksuit_set.jpg');

-- ===== LADIES WEAR =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('Women Kurti Ethnic Set',  'Cotton printed kurti with palazzo, festival ready, sizes S–XL',     999.00,  60, 'Ladies Wear', 'images/products/kurti_set.jpg'),
                                                                                ('Women Floral Dress',      'Chiffon summer dress, flared hem, available in 5 prints',          1200.00,  50, 'Ladies Wear', 'images/products/floraldress.jpg'),
                                                                                ('Women Denim Jacket',      'Classic blue denim, stylish cut, perfect layering piece',          1800.00,  35, 'Ladies Wear', 'images/products/denimjacket.jpg'),
                                                                                ('Women Yoga Pants',        'High-waist, 4-way stretch, moisture wicking, squat proof',          850.00,  70, 'Ladies Wear', 'images/products/yogapants.jpg'),
                                                                                ('Women Crop Top',          'Ribbed cotton blend, trendy cuts, 8+ color options',                550.00,  90, 'Ladies Wear', 'images/products/crop_top.jpg'),
                                                                                ('Women Saree (Georgette)', 'Pure georgette silk-feel, hand-finished border, wedding collection',2500.00,  25, 'Ladies Wear', 'images/products/saree_georgette.jpg'),
                                                                                ('Women Palazzo Set',       'Rayon printed set, comfortable and breezy for summer',              780.00,  65, 'Ladies Wear', 'images/products/palazzoset.jpg');

-- ===== CHILD WEAR =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('Kids School Uniform Set',  'White shirt + navy pants/skirt combo, durable cotton, ages 4–14',  650.00,  80, 'Child Wear', 'images/products/schooluniform.jpg'),
                                                                                ('Kids Cartoon Printed Tee', 'Soft 100% cotton, bright prints, sizes 2–12 years',                350.00, 120, 'Child Wear', 'images/products/cartoontee.jpg'),
                                                                                ('Baby Romper 3-Pack',       'Soft jersey knit, snap buttons, 0–18 months, pastel colors',       750.00,  60, 'Child Wear', 'images/products/babyromper.jpg'),
                                                                                ('Kids Denim Overalls',      'Adjustable straps, reinforced knees, adorable for toddlers',        890.00,  45, 'Child Wear', 'images/products/denimoveralls.jpg'),
                                                                                ('Kids Sports Set',          'Breathable jersey + shorts, perfect for school PE & play',          480.00,  90, 'Child Wear', 'images/products/sportsset.jpg'),
                                                                                ('Kids Winter Jacket',       'Padded inner lining, hood, water resistant shell, ages 3–12',     1200.00,  40, 'Child Wear', 'images/products/winterjacket.jpg'),
                                                                                ('Toy Water Gun',            'Safe plastic, long-range spray, kids summer outdoor fun',          1000.00,  55, 'Child Wear', 'images/products/watergun.jpg');

-- ===== FOOTWEAR =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('Nike-Style Running Shoes', 'Breathable mesh upper, foam cushioning, anti-slip sole',           3200.00, 35, 'Footwear', 'images/products/runningshoes.jpg'),
                                                                                ('Leather Formal Shoes',     'Genuine leather upper, cushioned insole, classic Oxford style',    3800.00, 20, 'Footwear', 'images/products/leatherformal.jpg'),
                                                                                ('Sports Sandals',           'EVA sole, adjustable straps, water-friendly, unisex',               900.00, 50, 'Footwear', 'images/products/sportssandals.jpg'),
                                                                                ('Canvas Sneakers',          'Classic low-top canvas sneakers, rubber sole, 10+ colors',         1200.00, 60, 'Footwear', 'images/products/canvassneakers.jpg'),
                                                                                ('Ladies Heels',             'Block heel 3", padded insole, faux leather, elegant design',       1500.00, 30, 'Footwear', 'images/products/ladiesheels.jpg'),
                                                                                ('Kids School Shoes',        'Black leather-look, velcro strap, slip resistant, sizes 25–38',     700.00, 75, 'Footwear', 'images/products/kids_school_shoes.jpg'),
                                                                                ('Trekking Boots',           'Waterproof, ankle support, vibram sole, ideal for Nepal trails',   4500.00, 15, 'Footwear', 'images/products/trekking_boots.jpg'),
                                                                                ('Flip Flops / Slippers',    'EVA foam, arch support, indoor/outdoor, multiple colors',           299.00,100, 'Footwear', 'images/products/flipflops.jpg');

-- ===== ACCESSORIES =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('Leather Backpack',         'Waterproof 30L, laptop compartment, USB charging port',            2500.00, 40, 'Accessories', 'images/products/leatherbackpack.jpg'),
                                                                                ('Sunglasses UV400',         'Polarized lenses, lightweight frame, UV400 protection',              850.00, 55, 'Accessories', 'images/products/sunglasses.jpg'),
                                                                                ('Leather Wallet (Slim)',    'Genuine leather, RFID blocking, card slots, compact',               650.00, 70, 'Accessories', 'images/products/leatherwallet.jpg'),
                                                                                ('Smart Watch Fitness Band', 'Heart rate, SpO2, sleep tracking, 7-day battery, IP68',           3500.00, 30, 'Accessories', 'images/products/smartwatch.jpg'),
                                                                                ('Sonata Analog Watch',      'Stainless steel case, mineral glass, 5ATM water resistant',        1300.00, 45, 'Accessories', 'images/products/sonatawatch.jpg'),
                                                                                ('Travel Duffel Bag',        '40L, trolley-compatible, multiple compartments, waterproof base',  1800.00, 25, 'Accessories', 'images/products/travelduffel.jpg'),
                                                                                ('Scarf / Muffler Wool',     'Pure wool, traditional Nepali patterns, keeps warm in cold season', 450.00, 80, 'Accessories', 'images/products/scarfmuffler.jpg'),
                                                                                ('Belt Genuine Leather',     'Full grain leather, solid brass buckle, multiple sizes',            750.00, 60, 'Accessories', 'images/products/leatherbelt.jpg');

-- ===== HOME AND LIVING =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('Semi-Automatic Washing Machine','7.5kg load, powerful wash, spin dry, energy efficient',      18800.00,  8, 'Home and Living', 'images/products/washingmachine.jpg'),
                                                                                ('Sofa Set 3+1+1',               'Premium fabric upholstery, solid wood frame, living room set',45000.00,  4, 'Home and Living', 'images/products/sofaset.jpg'),
                                                                                ('Dining Table 6-Seater',        'Solid sheesham wood, polish finish, classic design',           35000.00,  5, 'Home and Living', 'images/products/diningtable.jpg'),
                                                                                ('Study Table with Shelf',       'MDF board, modern design, 2 shelves + drawer, home/office',    8500.00, 12, 'Home and Living', 'images/products/studytable.jpg'),
                                                                                ('Cotton Bed Sheet Set',         'King size, 300 thread count, 2 pillow covers included',        1200.00, 50, 'Home and Living', 'images/products/cottonbedsheet.jpg'),
                                                                                ('Kitchen Knife Set (5pcs)',     'German stainless steel, ergonomic handles, includes block',    2200.00, 30, 'Home and Living', 'images/products/kitchenknifeset.jpg'),
                                                                                ('Electric Kettle 1.8L',         'Fast boil 1500W, auto shut-off, BPA free, cordless',           1800.00, 40, 'Home and Living', 'images/products/electrickettle.jpg'),
                                                                                ('Induction Cooktop',            '2000W, 8 power levels, touch control, safety cut-off',         3500.00, 20, 'Home and Living', 'images/products/inductioncooktop.jpg'),
                                                                                ('Air Purifier HEPA',            'True HEPA + activated carbon filter, covers 300 sq ft',        7500.00, 10, 'Home and Living', 'images/products/airpurifierhepa.jpg'),
                                                                                ('Decorative Wall Clock',        'Silent sweep mechanism, modern minimalist design, 30cm',        650.00, 55, 'Home and Living', 'images/products/wallclock.jpg');

-- ===== FACIAL PRODUCTS =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('Himalaya Face Wash',          'Purifying neem & turmeric, removes oil and impurities, 150ml',  350.00,  80, 'Facial Products', 'images/products/facewash.jpg'),
                                                                                ('Garnier Micellar Water',      'Gentle makeup remover, no-rinse formula, suitable all skin types',450.00, 70, 'Facial Products', 'images/products/garnier.jpg'),
                                                                                ('Neutrogena Sunscreen SPF50',  'Lightweight, non-greasy, broad spectrum UVA/UVB protection',     650.00,  60, 'Facial Products', 'images/products/sunscreen.jpg'),
                                                                                ('Vitamin C Serum 30ml',        'Brightening serum, reduces dark spots, antioxidant-rich formula',1200.00, 45, 'Facial Products', 'images/products/vitamincserum.jpg'),
                                                                                ('Lakme CC Cream',              'Color correction + SPF24, lightweight coverage, daily wear',     350.00,  90, 'Facial Products', 'images/products/lakmecream.jpg'),
                                                                                ('Aloe Vera Gel 200ml',         'Pure 98% aloe vera, soothing moisturizer, hair & skin use',     280.00, 100, 'Facial Products', 'images/products/aloeverajel.jpg'),
                                                                                ('Charcoal Face Mask Pack',     'Deep cleansing, removes blackheads, pore minimizing, 5 sachets', 399.00,  65, 'Facial Products', 'images/products/charcoalmask.jpg'),
                                                                                ('Lip Balm Set (3pcs)',         'SPF15, fruit-flavored, moisturizing, long-lasting hydration',    250.00, 110, 'Facial Products', 'images/products/lipbam.jpg'),
                                                                                ('Cetaphil Moisturizing Cream', 'Dermatologist recommended, dry & sensitive skin, 250g tub',     900.00,  55, 'Facial Products', 'images/products/cetaphilmoisturiser.jpg');

-- ===== FOODS =====
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
                                                                                ('Dark Chocolate 72% (3-Pack)',   'Belgian premium cocoa, sugar-free option, rich antioxidants',      180.00, 120, 'Foods', 'images/products/dark_chocolate.jpg'),
                                                                                ('Pedigree Dog Food 3kg',         'Complete nutrition for adult dogs, chicken & vegetable flavour',   800.00,  30, 'Foods', 'images/products/pedigree.jpg'),
                                                                                ('Granola Breakfast Bars 6pcs',   'Oats, honey, nuts & seeds — healthy on-the-go breakfast snack',   350.00,  80, 'Foods', 'images/products/granola_bars.jpg'),
                                                                                ('Organic Honey 500g',            'Pure raw Himalayan honey, no added sugar, certified organic',      750.00,  45, 'Foods', 'images/products/honey.jpg'),
                                                                                ('Instant Noodles (Wai Wai 30pk)','Classic Nepali noodles, 30-pack bulk buy, multiple flavours',     450.00, 200, 'Foods', 'images/products/instant_noodles.jpg'),
                                                                                ('Protein Powder Whey 1kg',       'Chocolate flavor, 24g protein per serving, fast absorbing',      2800.00,  25, 'Foods', 'images/products/protein_powder.jpg'),
                                                                                ('Mixed Nuts Dry Fruits 500g',    'Premium almonds, cashews, walnuts & raisins — nutrition-packed',   900.00,  60, 'Foods', 'images/products/mixed_nuts.jpg'),
                                                                                ('Green Tea 100 Bags',            'Premium Himalayan green tea, antioxidant-rich, fresh aroma',       320.00,  90, 'Foods', 'images/products/green_tea.jpg'),
                                                                                ('Sel Roti Mix 500g',             'Traditional Nepali festival bread mix — easy to prepare at home',  180.00,  75, 'Foods', 'images/products/sel_roti.jpg'),
                                                                                ('Peanut Butter Crunchy 400g',    'High protein, no palm oil, no added sugar, gym-friendly snack',   420.00,  65, 'Foods', 'images/products/peanut_butter.jpg');