-- Cassandra initialization script - E-commerce Platform
-- Comprehensive schema with multiple tables and extensive data

-- Create keyspace
CREATE KEYSPACE IF NOT EXISTS llm_nosql_keyspace
WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': 1
};

USE llm_nosql_keyspace;

-- ========== USERS TABLE ==========
CREATE TABLE IF NOT EXISTS users (
    user_id UUID PRIMARY KEY,
    name TEXT,
    email TEXT,
    age INT,
    city TEXT,
    role TEXT,
    phone TEXT,
    created_at TIMESTAMP,
    last_login TIMESTAMP,
    is_active BOOLEAN,
    tags SET<TEXT>
);

CREATE INDEX IF NOT EXISTS users_email_idx ON users(email);
CREATE INDEX IF NOT EXISTS users_city_idx ON users(city);

-- ========== PRODUCTS TABLE ==========
CREATE TABLE IF NOT EXISTS products (
    product_id UUID PRIMARY KEY,
    name TEXT,
    sku TEXT,
    category TEXT,
    brand TEXT,
    price DECIMAL,
    cost DECIMAL,
    stock INT,
    description TEXT,
    rating DECIMAL,
    review_count INT,
    tags SET<TEXT>,
    created_at TIMESTAMP,
    is_active BOOLEAN,
    images LIST<TEXT>
);

CREATE INDEX IF NOT EXISTS products_sku_idx ON products(sku);
CREATE INDEX IF NOT EXISTS products_category_idx ON products(category);
CREATE INDEX IF NOT EXISTS products_brand_idx ON products(brand);

-- ========== ORDERS TABLE ==========
CREATE TABLE IF NOT EXISTS orders (
    order_id UUID PRIMARY KEY,
    user_id UUID,
    order_number TEXT,
    status TEXT,
    total_amount DECIMAL,
    shipping_street TEXT,
    shipping_city TEXT,
    shipping_zip TEXT,
    shipping_country TEXT,
    payment_method TEXT,
    created_at TIMESTAMP,
    shipped_at TIMESTAMP,
    delivered_at TIMESTAMP
);

CREATE INDEX IF NOT EXISTS orders_user_idx ON orders(user_id);
CREATE INDEX IF NOT EXISTS orders_status_idx ON orders(status);
CREATE INDEX IF NOT EXISTS orders_number_idx ON orders(order_number);

-- Orders by user (for efficient user order queries)
CREATE TABLE IF NOT EXISTS orders_by_user (
    user_id UUID,
    order_id UUID,
    order_number TEXT,
    status TEXT,
    total_amount DECIMAL,
    created_at TIMESTAMP,
    PRIMARY KEY (user_id, created_at, order_id)
) WITH CLUSTERING ORDER BY (created_at DESC);

-- ========== ORDER ITEMS TABLE ==========
CREATE TABLE IF NOT EXISTS order_items (
    item_id UUID PRIMARY KEY,
    order_id UUID,
    product_id UUID,
    quantity INT,
    price DECIMAL,
    subtotal DECIMAL
);

CREATE INDEX IF NOT EXISTS order_items_order_idx ON order_items(order_id);
CREATE INDEX IF NOT EXISTS order_items_product_idx ON order_items(product_id);

-- Order items by order
CREATE TABLE IF NOT EXISTS order_items_by_order (
    order_id UUID,
    item_id UUID,
    product_id UUID,
    quantity INT,
    price DECIMAL,
    subtotal DECIMAL,
    PRIMARY KEY (order_id, item_id)
);

-- ========== REVIEWS TABLE ==========
CREATE TABLE IF NOT EXISTS reviews (
    review_id UUID PRIMARY KEY,
    user_id UUID,
    product_id UUID,
    rating INT,
    title TEXT,
    content TEXT,
    helpful INT,
    created_at TIMESTAMP,
    verified BOOLEAN
);

CREATE INDEX IF NOT EXISTS reviews_user_idx ON reviews(user_id);
CREATE INDEX IF NOT EXISTS reviews_product_idx ON reviews(product_id);

-- Reviews by product
CREATE TABLE IF NOT EXISTS reviews_by_product (
    product_id UUID,
    review_id UUID,
    user_id UUID,
    rating INT,
    title TEXT,
    content TEXT,
    helpful INT,
    created_at TIMESTAMP,
    PRIMARY KEY (product_id, created_at, review_id)
) WITH CLUSTERING ORDER BY (created_at DESC);

-- ========== CATEGORIES TABLE ==========
CREATE TABLE IF NOT EXISTS categories (
    category_id UUID PRIMARY KEY,
    name TEXT,
    slug TEXT,
    description TEXT,
    product_count INT,
    created_at TIMESTAMP
);

-- ========== CART ITEMS TABLE ==========
CREATE TABLE IF NOT EXISTS cart_items (
    cart_id UUID PRIMARY KEY,
    user_id UUID,
    product_id UUID,
    quantity INT,
    added_at TIMESTAMP
);

CREATE INDEX IF NOT EXISTS cart_items_user_idx ON cart_items(user_id);

-- Cart items by user
CREATE TABLE IF NOT EXISTS cart_items_by_user (
    user_id UUID,
    cart_id UUID,
    product_id UUID,
    quantity INT,
    added_at TIMESTAMP,
    PRIMARY KEY (user_id, added_at, cart_id)
) WITH CLUSTERING ORDER BY (added_at DESC);

-- ========== PAYMENTS TABLE ==========
CREATE TABLE IF NOT EXISTS payments (
    payment_id UUID PRIMARY KEY,
    order_id UUID,
    user_id UUID,
    amount DECIMAL,
    method TEXT,
    status TEXT,
    transaction_id TEXT,
    created_at TIMESTAMP
);

CREATE INDEX IF NOT EXISTS payments_order_idx ON payments(order_id);
CREATE INDEX IF NOT EXISTS payments_user_idx ON payments(user_id);
CREATE INDEX IF NOT EXISTS payments_transaction_idx ON payments(transaction_id);

-- Payments by user
CREATE TABLE IF NOT EXISTS payments_by_user (
    user_id UUID,
    payment_id UUID,
    order_id UUID,
    amount DECIMAL,
    method TEXT,
    status TEXT,
    created_at TIMESTAMP,
    PRIMARY KEY (user_id, created_at, payment_id)
) WITH CLUSTERING ORDER BY (created_at DESC);

-- ========== INSERT SAMPLE DATA ==========
-- Users
INSERT INTO users (user_id, name, email, age, city, role, phone, created_at, last_login, is_active, tags) 
VALUES (550e8400-e29b-41d4-a716-446655440001, 'Alice Johnson', 'user1@example.com', 28, 'Paris', 'customer', '+1-555-1000', '2024-01-01', '2024-01-15', true, {'premium', 'verified'});

INSERT INTO users (user_id, name, email, age, city, role, phone, created_at, last_login, is_active, tags) 
VALUES (550e8400-e29b-41d4-a716-446655440002, 'Bob Smith', 'user2@example.com', 32, 'London', 'admin', '+1-555-1001', '2024-01-02', '2024-01-16', true, {'standard'});

INSERT INTO users (user_id, name, email, age, city, role, phone, created_at, last_login, is_active, tags) 
VALUES (550e8400-e29b-41d4-a716-446655440003, 'Charlie Brown', 'user3@example.com', 25, 'Berlin', 'vendor', '+1-555-1002', '2024-01-03', '2024-01-17', true, {'premium'});

-- Products
INSERT INTO products (product_id, name, sku, category, brand, price, cost, stock, description, rating, review_count, tags, created_at, is_active, images) 
VALUES (660e8400-e29b-41d4-a716-446655440001, 'Laptop Pro 15"', 'SKU-10001', 'Computers', 'TechCorp', 1299.99, 800.00, 50, 'High-quality laptop', 4.5, 25, {'computers', 'techcorp'}, '2024-01-01', true, ['image1_1.jpg', 'image1_2.jpg']);

INSERT INTO products (product_id, name, sku, category, brand, price, cost, stock, description, rating, review_count, tags, created_at, is_active, images) 
VALUES (660e8400-e29b-41d4-a716-446655440002, 'Wireless Mouse', 'SKU-10002', 'Accessories', 'GadgetPro', 29.99, 15.00, 100, 'High-quality mouse', 4.2, 15, {'accessories', 'gadgetpro'}, '2024-01-02', true, ['image2_1.jpg']);

-- Orders
INSERT INTO orders (order_id, user_id, order_number, status, total_amount, shipping_street, shipping_city, shipping_zip, shipping_country, payment_method, created_at) 
VALUES (770e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440001, 'ORD-100001', 'delivered', 1299.99, '101 Main St', 'Paris', '10001', 'USA', 'credit_card', '2024-01-05');

INSERT INTO orders_by_user (user_id, order_id, order_number, status, total_amount, created_at) 
VALUES (550e8400-e29b-41d4-a716-446655440001, 770e8400-e29b-41d4-a716-446655440001, 'ORD-100001', 'delivered', 1299.99, '2024-01-05');

-- Order Items
INSERT INTO order_items (item_id, order_id, product_id, quantity, price, subtotal) 
VALUES (880e8400-e29b-41d4-a716-446655440001, 770e8400-e29b-41d4-a716-446655440001, 660e8400-e29b-41d4-a716-446655440001, 1, 1299.99, 1299.99);

INSERT INTO order_items_by_order (order_id, item_id, product_id, quantity, price, subtotal) 
VALUES (770e8400-e29b-41d4-a716-446655440001, 880e8400-e29b-41d4-a716-446655440001, 660e8400-e29b-41d4-a716-446655440001, 1, 1299.99, 1299.99);

-- Reviews
INSERT INTO reviews (review_id, user_id, product_id, rating, title, content, helpful, created_at, verified) 
VALUES (990e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440001, 660e8400-e29b-41d4-a716-446655440001, 5, 'Great laptop', 'Excellent product!', 10, '2024-01-10', true);

INSERT INTO reviews_by_product (product_id, review_id, user_id, rating, title, content, helpful, created_at) 
VALUES (660e8400-e29b-41d4-a716-446655440001, 990e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440001, 5, 'Great laptop', 'Excellent product!', 10, '2024-01-10');

-- Categories
INSERT INTO categories (category_id, name, slug, description, product_count, created_at) 
VALUES (aa0e8400-e29b-41d4-a716-446655440001, 'Electronics', 'electronics', 'Electronics category', 5, '2024-01-01');

-- Cart Items
INSERT INTO cart_items (cart_id, user_id, product_id, quantity, added_at) 
VALUES (bb0e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440001, 660e8400-e29b-41d4-a716-446655440002, 2, '2024-01-20');

INSERT INTO cart_items_by_user (user_id, cart_id, product_id, quantity, added_at) 
VALUES (550e8400-e29b-41d4-a716-446655440001, bb0e8400-e29b-41d4-a716-446655440001, 660e8400-e29b-41d4-a716-446655440002, 2, '2024-01-20');

-- Payments
INSERT INTO payments (payment_id, order_id, user_id, amount, method, status, transaction_id, created_at) 
VALUES (cc0e8400-e29b-41d4-a716-446655440001, 770e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440001, 1299.99, 'credit_card', 'completed', 'TXN-1000001', '2024-01-05');

INSERT INTO payments_by_user (user_id, payment_id, order_id, amount, method, status, created_at) 
VALUES (550e8400-e29b-41d4-a716-446655440001, cc0e8400-e29b-41d4-a716-446655440001, 770e8400-e29b-41d4-a716-446655440001, 1299.99, 'credit_card', 'completed', '2024-01-05');

