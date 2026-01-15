#!/bin/sh
# Redis initialization script - E-commerce Platform
# Comprehensive key-value data structure

echo "Initializing Redis with comprehensive e-commerce data..."

# Wait for Redis to be ready
sleep 2

# ========== USER DATA ==========
# User profiles (Hash)
redis-cli HMSET user:1:profile name "Alice Johnson" email "user1@example.com" age 28 city "Paris" role "customer" phone "+1-555-1000"
redis-cli HMSET user:2:profile name "Bob Smith" email "user2@example.com" age 32 city "London" role "admin" phone "+1-555-1001"
redis-cli HMSET user:3:profile name "Charlie Brown" email "user3@example.com" age 25 city "Berlin" role "vendor" phone "+1-555-1002"
redis-cli HMSET user:4:profile name "Diana Prince" email "user4@example.com" age 30 city "New York" role "customer" phone "+1-555-1003"
redis-cli HMSET user:5:profile name "Eve Wilson" email "user5@example.com" age 27 city "Tokyo" role "customer" phone "+1-555-1004"
redis-cli HMSET user:6:profile name "Frank Miller" email "user6@example.com" age 35 city "Sydney" role "customer" phone "+1-555-1005"
redis-cli HMSET user:7:profile name "Grace Lee" email "user7@example.com" age 29 city "Toronto" role "customer" phone "+1-555-1006"
redis-cli HMSET user:8:profile name "Henry Davis" email "user8@example.com" age 33 city "Madrid" role "customer" phone "+1-555-1007"
redis-cli HMSET user:9:profile name "Ivy Chen" email "user9@example.com" age 26 city "Rome" role "customer" phone "+1-555-1008"
redis-cli HMSET user:10:profile name "Jack Taylor" email "user10@example.com" age 31 city "Amsterdam" role "customer" phone "+1-555-1009"

# User sessions (String with TTL simulation)
redis-cli SETEX user:1:session 3600 "session_token_abc123"
redis-cli SETEX user:2:session 3600 "session_token_def456"
redis-cli SETEX user:3:session 3600 "session_token_ghi789"

# User activity scores (Sorted Set)
redis-cli ZADD leaderboard:activity 150 user:1
redis-cli ZADD leaderboard:activity 230 user:2
redis-cli ZADD leaderboard:activity 89 user:3
redis-cli ZADD leaderboard:activity 320 user:4
redis-cli ZADD leaderboard:activity 180 user:5
redis-cli ZADD leaderboard:activity 95 user:6
redis-cli ZADD leaderboard:activity 210 user:7
redis-cli ZADD leaderboard:activity 140 user:8
redis-cli ZADD leaderboard:activity 275 user:9
redis-cli ZADD leaderboard:activity 195 user:10

# ========== PRODUCT DATA ==========
# Product details (Hash)
redis-cli HMSET product:1:details name "Laptop Pro 15\"" sku "SKU-10001" category "Computers" brand "TechCorp" price "1299.99" stock 50
redis-cli HMSET product:2:details name "Wireless Mouse" sku "SKU-10002" category "Accessories" brand "GadgetPro" price "29.99" stock 100
redis-cli HMSET product:3:details name "Mechanical Keyboard" sku "SKU-10003" category "Accessories" brand "SmartTech" price "149.99" stock 75
redis-cli HMSET product:4:details name "4K Monitor" sku "SKU-10004" category "Electronics" brand "EliteDevices" price "599.99" stock 40
redis-cli HMSET product:5:details name "USB-C Hub" sku "SKU-10005" category "Accessories" brand "ProGear" price "79.99" stock 90
redis-cli HMSET product:6:details name "Webcam HD" sku "SKU-10006" category "Electronics" brand "TechCorp" price "99.99" stock 60
redis-cli HMSET product:7:details name "Noise Cancelling Headphones" sku "SKU-10007" category "Electronics" brand "GadgetPro" price "299.99" stock 45
redis-cli HMSET product:8:details name "SSD 1TB" sku "SKU-10008" category "Computers" brand "SmartTech" price "199.99" stock 80
redis-cli HMSET product:9:details name "RAM 16GB" sku "SKU-10009" category "Computers" brand "EliteDevices" price "129.99" stock 70
redis-cli HMSET product:10:details name "Graphics Card RTX 4080" sku "SKU-10010" category "Computers" brand "ProGear" price "1199.99" stock 25

# Product views counter
redis-cli SET product:1:views 1250
redis-cli SET product:2:views 890
redis-cli SET product:3:views 1560
redis-cli SET product:4:views 2100
redis-cli SET product:5:views 750
redis-cli SET product:6:views 980
redis-cli SET product:7:views 1340
redis-cli SET product:8:views 1100
redis-cli SET product:9:views 920
redis-cli SET product:10:views 1890

# Product ratings (Sorted Set)
redis-cli ZADD product:ratings 4.5 product:1
redis-cli ZADD product:ratings 4.2 product:2
redis-cli ZADD product:ratings 4.7 product:3
redis-cli ZADD product:ratings 4.6 product:4
redis-cli ZADD product:ratings 4.3 product:5
redis-cli ZADD product:ratings 4.4 product:6
redis-cli ZADD product:ratings 4.8 product:7
redis-cli ZADD product:ratings 4.5 product:8
redis-cli ZADD product:ratings 4.6 product:9
redis-cli ZADD product:ratings 4.9 product:10

# ========== ORDER DATA ==========
# Order details (Hash)
redis-cli HMSET order:1:details orderNumber "ORD-100001" userId 1 status "delivered" totalAmount "1299.99" createdAt "2024-01-05"
redis-cli HMSET order:2:details orderNumber "ORD-100002" userId 2 status "shipped" totalAmount "179.98" createdAt "2024-01-06"
redis-cli HMSET order:3:details orderNumber "ORD-100003" userId 3 status "processing" totalAmount "749.98" createdAt "2024-01-07"
redis-cli HMSET order:4:details orderNumber "ORD-100004" userId 4 status "delivered" totalAmount "299.99" createdAt "2024-01-08"
redis-cli HMSET order:5:details orderNumber "ORD-100005" userId 5 status "pending" totalAmount "329.98" createdAt "2024-01-09"

# Order status tracking (Sorted Set by timestamp)
redis-cli ZADD orders:by_date 1704456000 order:1
redis-cli ZADD orders:by_date 1704542400 order:2
redis-cli ZADD orders:by_date 1704628800 order:3
redis-cli ZADD orders:by_date 1704715200 order:4
redis-cli ZADD orders:by_date 1704801600 order:5

# ========== CART DATA ==========
# Shopping carts (Set of product IDs)
redis-cli SADD cart:user:1 product:2 product:5 product:8
redis-cli SADD cart:user:2 product:3 product:6
redis-cli SADD cart:user:3 product:1 product:4 product:7
redis-cli SADD cart:user:4 product:9 product:10
redis-cli SADD cart:user:5 product:2 product:3 product:5

# Cart quantities (Hash)
redis-cli HMSET cart:user:1:quantities product:2 2 product:5 1 product:8 1
redis-cli HMSET cart:user:2:quantities product:3 1 product:6 2
redis-cli HMSET cart:user:3:quantities product:1 1 product:4 1 product:7 1

# ========== CATEGORY DATA ==========
# Products by category (Set)
redis-cli SADD category:Computers:products product:1 product:8 product:9 product:10
redis-cli SADD category:Accessories:products product:2 product:3 product:5
redis-cli SADD category:Electronics:products product:4 product:6 product:7

# ========== RECOMMENDATIONS ==========
# User recommendations (List)
redis-cli LPUSH recommendations:user:1 product:3 product:7 product:9
redis-cli LPUSH recommendations:user:2 product:1 product:4 product:8
redis-cli LPUSH recommendations:user:3 product:2 product:5 product:6

# ========== RECENT ACTIVITY ==========
# Recent views (List)
redis-cli LPUSH activity:user:1:views product:1 product:3 product:5
redis-cli LPUSH activity:user:2:views product:2 product:4 product:6
redis-cli LPUSH activity:user:3:views product:7 product:8 product:9

# ========== SEARCH INDEX ==========
# Product search index (Set by keyword)
redis-cli SADD search:laptop product:1
redis-cli SADD search:mouse product:2
redis-cli SADD search:keyboard product:3
redis-cli SADD search:monitor product:4
redis-cli SADD search:headphones product:7
redis-cli SADD search:computer product:1 product:8 product:9 product:10

# ========== ANALYTICS ==========
# Daily sales counter
redis-cli SET stats:daily:sales:2024-01-15 1250
redis-cli SET stats:daily:sales:2024-01-16 1380
redis-cli SET stats:daily:sales:2024-01-17 1120

# Popular products (Sorted Set)
redis-cli ZADD popular:products 1890 product:10
redis-cli ZADD popular:products 2100 product:4
redis-cli ZADD popular:products 1560 product:3
redis-cli ZADD popular:products 1340 product:7
redis-cli ZADD popular:products 1250 product:1

# ========== CACHE DATA ==========
# Cached product pages (String with JSON-like data)
redis-cli SETEX cache:product:1:page 3600 "{\"name\":\"Laptop Pro 15\\\"\",\"price\":1299.99,\"inStock\":true}"
redis-cli SETEX cache:product:2:page 3600 "{\"name\":\"Wireless Mouse\",\"price\":29.99,\"inStock\":true}"

# ========== NOTIFICATIONS ==========
# User notifications (List)
redis-cli LPUSH notifications:user:1 "Order ORD-100001 has been delivered"
redis-cli LPUSH notifications:user:2 "New product in your wishlist"
redis-cli LPUSH notifications:user:3 "Your review was helpful to 5 users"

echo "Redis initialization complete!"

