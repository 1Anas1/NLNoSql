// Neo4j initialization script - E-commerce Platform
// Comprehensive graph schema with extensive relationships

// ========== CREATE USERS ==========
CREATE (u1:User {id: 1, name: "Alice Johnson", email: "user1@example.com", age: 28, city: "Paris", role: "customer", phone: "+1-555-1000", createdAt: datetime("2024-01-01T00:00:00"), isActive: true})
CREATE (u2:User {id: 2, name: "Bob Smith", email: "user2@example.com", age: 32, city: "London", role: "admin", phone: "+1-555-1001", createdAt: datetime("2024-01-02T00:00:00"), isActive: true})
CREATE (u3:User {id: 3, name: "Charlie Brown", email: "user3@example.com", age: 25, city: "Berlin", role: "vendor", phone: "+1-555-1002", createdAt: datetime("2024-01-03T00:00:00"), isActive: true})
CREATE (u4:User {id: 4, name: "Diana Prince", email: "user4@example.com", age: 30, city: "New York", role: "customer", phone: "+1-555-1003", createdAt: datetime("2024-01-04T00:00:00"), isActive: true})
CREATE (u5:User {id: 5, name: "Eve Wilson", email: "user5@example.com", age: 27, city: "Tokyo", role: "customer", phone: "+1-555-1004", createdAt: datetime("2024-01-05T00:00:00"), isActive: true})
CREATE (u6:User {id: 6, name: "Frank Miller", email: "user6@example.com", age: 35, city: "Sydney", role: "customer", phone: "+1-555-1005", createdAt: datetime("2024-01-06T00:00:00"), isActive: true})
CREATE (u7:User {id: 7, name: "Grace Lee", email: "user7@example.com", age: 29, city: "Toronto", role: "customer", phone: "+1-555-1006", createdAt: datetime("2024-01-07T00:00:00"), isActive: true})
CREATE (u8:User {id: 8, name: "Henry Davis", email: "user8@example.com", age: 33, city: "Madrid", role: "customer", phone: "+1-555-1007", createdAt: datetime("2024-01-08T00:00:00"), isActive: true})
CREATE (u9:User {id: 9, name: "Ivy Chen", email: "user9@example.com", age: 26, city: "Rome", role: "customer", phone: "+1-555-1008", createdAt: datetime("2024-01-09T00:00:00"), isActive: true})
CREATE (u10:User {id: 10, name: "Jack Taylor", email: "user10@example.com", age: 31, city: "Amsterdam", role: "customer", phone: "+1-555-1009", createdAt: datetime("2024-01-10T00:00:00"), isActive: true})

// ========== CREATE PRODUCTS ==========
CREATE (p1:Product {id: 1, name: "Laptop Pro 15\"", sku: "SKU-10001", category: "Computers", brand: "TechCorp", price: 1299.99, stock: 50, rating: 4.5, reviewCount: 25})
CREATE (p2:Product {id: 2, name: "Wireless Mouse", sku: "SKU-10002", category: "Accessories", brand: "GadgetPro", price: 29.99, stock: 100, rating: 4.2, reviewCount: 15})
CREATE (p3:Product {id: 3, name: "Mechanical Keyboard", sku: "SKU-10003", category: "Accessories", brand: "SmartTech", price: 149.99, stock: 75, rating: 4.7, reviewCount: 30})
CREATE (p4:Product {id: 4, name: "4K Monitor", sku: "SKU-10004", category: "Electronics", brand: "EliteDevices", price: 599.99, stock: 40, rating: 4.6, reviewCount: 20})
CREATE (p5:Product {id: 5, name: "USB-C Hub", sku: "SKU-10005", category: "Accessories", brand: "ProGear", price: 79.99, stock: 90, rating: 4.3, reviewCount: 18})
CREATE (p6:Product {id: 6, name: "Webcam HD", sku: "SKU-10006", category: "Electronics", brand: "TechCorp", price: 99.99, stock: 60, rating: 4.4, reviewCount: 22})
CREATE (p7:Product {id: 7, name: "Noise Cancelling Headphones", sku: "SKU-10007", category: "Electronics", brand: "GadgetPro", price: 299.99, stock: 45, rating: 4.8, reviewCount: 35})
CREATE (p8:Product {id: 8, name: "SSD 1TB", sku: "SKU-10008", category: "Computers", brand: "SmartTech", price: 199.99, stock: 80, rating: 4.5, reviewCount: 28})
CREATE (p9:Product {id: 9, name: "RAM 16GB", sku: "SKU-10009", category: "Computers", brand: "EliteDevices", price: 129.99, stock: 70, rating: 4.6, reviewCount: 24})
CREATE (p10:Product {id: 10, name: "Graphics Card RTX 4080", sku: "SKU-10010", category: "Computers", brand: "ProGear", price: 1199.99, stock: 25, rating: 4.9, reviewCount: 40})

// ========== CREATE CATEGORIES ==========
CREATE (c1:Category {id: 1, name: "Electronics", slug: "electronics", description: "Electronics category"})
CREATE (c2:Category {id: 2, name: "Computers", slug: "computers", description: "Computers category"})
CREATE (c3:Category {id: 3, name: "Accessories", slug: "accessories", description: "Accessories category"})
CREATE (c4:Category {id: 4, name: "Mobile", slug: "mobile", description: "Mobile category"})
CREATE (c5:Category {id: 5, name: "Peripherals", slug: "peripherals", description: "Peripherals category"})

// ========== CREATE ORDERS ==========
CREATE (o1:Order {id: 1, orderNumber: "ORD-100001", status: "delivered", totalAmount: 1299.99, createdAt: datetime("2024-01-05T10:00:00")})
CREATE (o2:Order {id: 2, orderNumber: "ORD-100002", status: "shipped", totalAmount: 179.98, createdAt: datetime("2024-01-06T11:00:00")})
CREATE (o3:Order {id: 3, orderNumber: "ORD-100003", status: "processing", totalAmount: 749.98, createdAt: datetime("2024-01-07T12:00:00")})
CREATE (o4:Order {id: 4, orderNumber: "ORD-100004", status: "delivered", totalAmount: 299.99, createdAt: datetime("2024-01-08T13:00:00")})
CREATE (o5:Order {id: 5, orderNumber: "ORD-100005", status: "pending", totalAmount: 329.98, createdAt: datetime("2024-01-09T14:00:00")})
CREATE (o6:Order {id: 6, orderNumber: "ORD-100006", status: "shipped", totalAmount: 599.99, createdAt: datetime("2024-01-10T15:00:00")})
CREATE (o7:Order {id: 7, orderNumber: "ORD-100007", status: "delivered", totalAmount: 199.99, createdAt: datetime("2024-01-11T16:00:00")})
CREATE (o8:Order {id: 8, orderNumber: "ORD-100008", status: "processing", totalAmount: 129.99, createdAt: datetime("2024-01-12T17:00:00")})
CREATE (o9:Order {id: 9, orderNumber: "ORD-100009", status: "delivered", totalAmount: 1199.99, createdAt: datetime("2024-01-13T18:00:00")})
CREATE (o10:Order {id: 10, orderNumber: "ORD-100010", status: "shipped", totalAmount: 79.99, createdAt: datetime("2024-01-14T19:00:00")})

// ========== CREATE REVIEWS ==========
CREATE (r1:Review {id: 1, rating: 5, title: "Great laptop", content: "Excellent product!", helpful: 10, createdAt: datetime("2024-01-10T10:00:00"), verified: true})
CREATE (r2:Review {id: 2, rating: 4, title: "Good mouse", content: "Works well", helpful: 5, createdAt: datetime("2024-01-11T11:00:00"), verified: false})
CREATE (r3:Review {id: 3, rating: 5, title: "Amazing keyboard", content: "Best keyboard ever!", helpful: 15, createdAt: datetime("2024-01-12T12:00:00"), verified: true})
CREATE (r4:Review {id: 4, rating: 4, title: "Nice monitor", content: "Good quality", helpful: 8, createdAt: datetime("2024-01-13T13:00:00"), verified: false})
CREATE (r5:Review {id: 5, rating: 5, title: "Perfect hub", content: "Very useful", helpful: 12, createdAt: datetime("2024-01-14T14:00:00"), verified: true})

// ========== CREATE PAYMENTS ==========
CREATE (pay1:Payment {id: 1, amount: 1299.99, method: "credit_card", status: "completed", transactionId: "TXN-1000001", createdAt: datetime("2024-01-05T10:05:00")})
CREATE (pay2:Payment {id: 2, amount: 179.98, method: "paypal", status: "completed", transactionId: "TXN-1000002", createdAt: datetime("2024-01-06T11:05:00")})
CREATE (pay3:Payment {id: 3, amount: 749.98, method: "bank_transfer", status: "processing", transactionId: "TXN-1000003", createdAt: datetime("2024-01-07T12:05:00")})

// ========== RELATIONSHIPS: USER PLACED ORDER ==========
CREATE (u1)-[:PLACED_ORDER {createdAt: datetime("2024-01-05T10:00:00")}]->(o1)
CREATE (u2)-[:PLACED_ORDER {createdAt: datetime("2024-01-06T11:00:00")}]->(o2)
CREATE (u3)-[:PLACED_ORDER {createdAt: datetime("2024-01-07T12:00:00")}]->(o3)
CREATE (u4)-[:PLACED_ORDER {createdAt: datetime("2024-01-08T13:00:00")}]->(o4)
CREATE (u5)-[:PLACED_ORDER {createdAt: datetime("2024-01-09T14:00:00")}]->(o5)
CREATE (u6)-[:PLACED_ORDER {createdAt: datetime("2024-01-10T15:00:00")}]->(o6)
CREATE (u7)-[:PLACED_ORDER {createdAt: datetime("2024-01-11T16:00:00")}]->(o7)
CREATE (u8)-[:PLACED_ORDER {createdAt: datetime("2024-01-12T17:00:00")}]->(o8)
CREATE (u9)-[:PLACED_ORDER {createdAt: datetime("2024-01-13T18:00:00")}]->(o9)
CREATE (u10)-[:PLACED_ORDER {createdAt: datetime("2024-01-14T19:00:00")}]->(o10)

// ========== RELATIONSHIPS: ORDER CONTAINS PRODUCT ==========
CREATE (o1)-[:CONTAINS {quantity: 1, price: 1299.99}]->(p1)
CREATE (o2)-[:CONTAINS {quantity: 2, price: 29.99}]->(p2)
CREATE (o2)-[:CONTAINS {quantity: 1, price: 149.99}]->(p3)
CREATE (o3)-[:CONTAINS {quantity: 1, price: 599.99}]->(p4)
CREATE (o3)-[:CONTAINS {quantity: 1, price: 149.99}]->(p3)
CREATE (o4)-[:CONTAINS {quantity: 1, price: 299.99}]->(p7)
CREATE (o5)-[:CONTAINS {quantity: 1, price: 199.99}]->(p8)
CREATE (o5)-[:CONTAINS {quantity: 1, price: 129.99}]->(p9)
CREATE (o6)-[:CONTAINS {quantity: 1, price: 599.99}]->(p4)
CREATE (o7)-[:CONTAINS {quantity: 1, price: 199.99}]->(p8)
CREATE (o8)-[:CONTAINS {quantity: 1, price: 129.99}]->(p9)
CREATE (o9)-[:CONTAINS {quantity: 1, price: 1199.99}]->(p10)
CREATE (o10)-[:CONTAINS {quantity: 1, price: 79.99}]->(p5)

// ========== RELATIONSHIPS: PRODUCT BELONGS TO CATEGORY ==========
CREATE (p1)-[:BELONGS_TO]->(c2)
CREATE (p2)-[:BELONGS_TO]->(c3)
CREATE (p3)-[:BELONGS_TO]->(c3)
CREATE (p4)-[:BELONGS_TO]->(c1)
CREATE (p5)-[:BELONGS_TO]->(c3)
CREATE (p6)-[:BELONGS_TO]->(c1)
CREATE (p7)-[:BELONGS_TO]->(c1)
CREATE (p8)-[:BELONGS_TO]->(c2)
CREATE (p9)-[:BELONGS_TO]->(c2)
CREATE (p10)-[:BELONGS_TO]->(c2)

// ========== RELATIONSHIPS: USER REVIEWED PRODUCT ==========
CREATE (u1)-[:WROTE_REVIEW {createdAt: datetime("2024-01-10T10:00:00")}]->(r1)
CREATE (r1)-[:REVIEWS]->(p1)
CREATE (u2)-[:WROTE_REVIEW {createdAt: datetime("2024-01-11T11:00:00")}]->(r2)
CREATE (r2)-[:REVIEWS]->(p2)
CREATE (u3)-[:WROTE_REVIEW {createdAt: datetime("2024-01-12T12:00:00")}]->(r3)
CREATE (r3)-[:REVIEWS]->(p3)
CREATE (u4)-[:WROTE_REVIEW {createdAt: datetime("2024-01-13T13:00:00")}]->(r4)
CREATE (r4)-[:REVIEWS]->(p4)
CREATE (u5)-[:WROTE_REVIEW {createdAt: datetime("2024-01-14T14:00:00")}]->(r5)
CREATE (r5)-[:REVIEWS]->(p5)

// ========== RELATIONSHIPS: USER ADDED TO CART ==========
CREATE (u1)-[:ADDED_TO_CART {quantity: 2, addedAt: datetime("2024-01-20T10:00:00")}]->(p2)
CREATE (u2)-[:ADDED_TO_CART {quantity: 1, addedAt: datetime("2024-01-21T11:00:00")}]->(p3)
CREATE (u3)-[:ADDED_TO_CART {quantity: 1, addedAt: datetime("2024-01-22T12:00:00")}]->(p4)
CREATE (u4)-[:ADDED_TO_CART {quantity: 3, addedAt: datetime("2024-01-23T13:00:00")}]->(p5)

// ========== RELATIONSHIPS: ORDER HAS PAYMENT ==========
CREATE (o1)-[:PAID_WITH]->(pay1)
CREATE (o2)-[:PAID_WITH]->(pay2)
CREATE (o3)-[:PAID_WITH]->(pay3)

// ========== RELATIONSHIPS: USER MADE PAYMENT ==========
CREATE (u1)-[:MADE_PAYMENT]->(pay1)
CREATE (u2)-[:MADE_PAYMENT]->(pay2)
CREATE (u3)-[:MADE_PAYMENT]->(pay3)

// ========== RELATIONSHIPS: USER FOLLOWS USER ==========
CREATE (u1)-[:FOLLOWS {since: datetime("2024-01-10T08:00:00")}]->(u2)
CREATE (u1)-[:FOLLOWS {since: datetime("2024-01-12T10:00:00")}]->(u3)
CREATE (u2)-[:FOLLOWS {since: datetime("2024-01-11T09:00:00")}]->(u1)
CREATE (u2)-[:FOLLOWS {since: datetime("2024-01-15T11:00:00")}]->(u4)
CREATE (u3)-[:FOLLOWS {since: datetime("2024-01-13T12:00:00")}]->(u1)
CREATE (u4)-[:FOLLOWS {since: datetime("2024-01-14T13:00:00")}]->(u5)
CREATE (u5)-[:FOLLOWS {since: datetime("2024-01-16T14:00:00")}]->(u6)

// ========== CREATE INDEXES ==========
CREATE INDEX user_id_index IF NOT EXISTS FOR (u:User) ON (u.id);
CREATE INDEX user_email_index IF NOT EXISTS FOR (u:User) ON (u.email);
CREATE INDEX product_id_index IF NOT EXISTS FOR (p:Product) ON (p.id);
CREATE INDEX product_sku_index IF NOT EXISTS FOR (p:Product) ON (p.sku);
CREATE INDEX order_id_index IF NOT EXISTS FOR (o:Order) ON (o.id);
CREATE INDEX order_number_index IF NOT EXISTS FOR (o:Order) ON (o.orderNumber);
CREATE INDEX category_id_index IF NOT EXISTS FOR (c:Category) ON (c.id);
