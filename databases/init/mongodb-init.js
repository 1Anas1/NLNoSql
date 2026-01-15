// MongoDB initialization script - E-commerce Platform
// Comprehensive schema with multiple collections and extensive data

db = db.getSiblingDB('llm_nosql_db');

print('Initializing MongoDB with comprehensive e-commerce data...');

// ========== USERS COLLECTION ==========
const users = [];
const userNames = ['Alice Johnson', 'Bob Smith', 'Charlie Brown', 'Diana Prince', 'Eve Wilson', 
                   'Frank Miller', 'Grace Lee', 'Henry Davis', 'Ivy Chen', 'Jack Taylor',
                   'Kate Anderson', 'Liam O\'Brien', 'Mia Rodriguez', 'Noah Kim', 'Olivia White',
                   'Paul Martinez', 'Quinn Johnson', 'Rachel Green', 'Sam Thompson', 'Tina Wang'];
const cities = ['Paris', 'London', 'Berlin', 'New York', 'Tokyo', 'Sydney', 'Toronto', 'Madrid', 'Rome', 'Amsterdam'];
const roles = ['customer', 'admin', 'vendor', 'moderator'];

for (let i = 0; i < 20; i++) {
  users.push({
    _id: i + 1,
    name: userNames[i],
    email: `user${i + 1}@example.com`,
    age: 20 + (i % 40),
    city: cities[i % cities.length],
    role: roles[i % roles.length],
    phone: `+1-555-${String(1000 + i).padStart(4, '0')}`,
    createdAt: new Date(2024, 0, 1 + i),
    lastLogin: new Date(2024, 0, 15 + (i % 10)),
    isActive: i < 18,
    tags: i % 2 === 0 ? ['premium', 'verified'] : ['standard']
  });
}
db.users.insertMany(users);

// ========== PRODUCTS COLLECTION ==========
const products = [];
const productNames = [
  'Laptop Pro 15"', 'Wireless Mouse', 'Mechanical Keyboard', '4K Monitor', 'USB-C Hub',
  'Webcam HD', 'Noise Cancelling Headphones', 'SSD 1TB', 'RAM 16GB', 'Graphics Card RTX 4080',
  'Smartphone Pro', 'Tablet Air', 'Smart Watch', 'Wireless Earbuds', 'Power Bank 20000mAh',
  'Laptop Stand', 'Desk Lamp', 'Cable Organizer', 'Mouse Pad', 'USB Flash Drive 128GB'
];
const categories = ['Electronics', 'Computers', 'Accessories', 'Mobile', 'Peripherals'];
const brands = ['TechCorp', 'GadgetPro', 'SmartTech', 'EliteDevices', 'ProGear'];

for (let i = 0; i < 20; i++) {
  products.push({
    _id: i + 1,
    name: productNames[i],
    sku: `SKU-${String(10000 + i).padStart(5, '0')}`,
    category: categories[i % categories.length],
    brand: brands[i % brands.length],
    price: 29.99 + (i * 47.50),
    cost: 15.00 + (i * 25.00),
    stock: 100 - (i * 3),
    description: `High-quality ${productNames[i].toLowerCase()} with advanced features.`,
    rating: 4.0 + (i % 10) / 10,
    reviewCount: 10 + (i * 5),
    tags: [categories[i % categories.length].toLowerCase(), brands[i % brands.length].toLowerCase()],
    createdAt: new Date(2024, 0, 1 + (i % 20)),
    isActive: i < 18,
    images: [`image${i + 1}_1.jpg`, `image${i + 1}_2.jpg`]
  });
}
db.products.insertMany(products);

// ========== ORDERS COLLECTION ==========
const orders = [];
const statuses = ['pending', 'processing', 'shipped', 'delivered', 'cancelled'];

for (let i = 0; i < 50; i++) {
  orders.push({
    _id: i + 1,
    userId: (i % 20) + 1,
    orderNumber: `ORD-${String(100000 + i).padStart(6, '0')}`,
    status: statuses[i % statuses.length],
    totalAmount: 99.99 + (i * 23.45),
    shippingAddress: {
      street: `${100 + i} Main St`,
      city: cities[(i * 3) % cities.length],
      zipCode: `${10000 + i}`,
      country: 'USA'
    },
    paymentMethod: i % 3 === 0 ? 'credit_card' : i % 3 === 1 ? 'paypal' : 'bank_transfer',
    createdAt: new Date(2024, 0, 1 + (i % 30)),
    shippedAt: i > 10 ? new Date(2024, 0, 2 + (i % 30)) : null,
    deliveredAt: i > 20 ? new Date(2024, 0, 5 + (i % 30)) : null
  });
}
db.orders.insertMany(orders);

// ========== ORDER ITEMS COLLECTION ==========
const orderItems = [];
let itemId = 1;
for (let i = 0; i < 50; i++) {
  const itemCount = 1 + (i % 4);
  for (let j = 0; j < itemCount; j++) {
    orderItems.push({
      _id: itemId++,
      orderId: i + 1,
      productId: ((i * 2) + j) % 20 + 1,
      quantity: 1 + (j % 3),
      price: 29.99 + (((i * 2) + j) % 20) * 47.50,
      subtotal: (1 + (j % 3)) * (29.99 + (((i * 2) + j) % 20) * 47.50)
    });
  }
}
db.orderItems.insertMany(orderItems);

// ========== REVIEWS COLLECTION ==========
const reviews = [];
for (let i = 0; i < 100; i++) {
  reviews.push({
    _id: i + 1,
    userId: (i % 20) + 1,
    productId: (i % 20) + 1,
    rating: 1 + (i % 5),
    title: `Review ${i + 1}`,
    content: `This is a detailed review for product ${(i % 20) + 1}. ${i % 2 === 0 ? 'Great product!' : 'Could be better.'}`,
    helpful: i * 3,
    createdAt: new Date(2024, 0, 1 + (i % 30)),
    verified: i % 3 === 0
  });
}
db.reviews.insertMany(reviews);

// ========== CATEGORIES COLLECTION ==========
const categoriesData = categories.map((cat, idx) => ({
  _id: idx + 1,
  name: cat,
  slug: cat.toLowerCase().replace(' ', '-'),
  description: `${cat} category with various products`,
  productCount: products.filter(p => p.category === cat).length,
  createdAt: new Date(2024, 0, 1)
}));
db.categories.insertMany(categoriesData);

// ========== CART ITEMS COLLECTION ==========
const cartItems = [];
for (let i = 0; i < 30; i++) {
  cartItems.push({
    _id: i + 1,
    userId: (i % 20) + 1,
    productId: (i % 20) + 1,
    quantity: 1 + (i % 3),
    addedAt: new Date(2024, 0, 15 + (i % 10))
  });
}
db.cartItems.insertMany(cartItems);

// ========== PAYMENTS COLLECTION ==========
const payments = [];
for (let i = 0; i < 50; i++) {
  payments.push({
    _id: i + 1,
    orderId: i + 1,
    userId: (i % 20) + 1,
    amount: 99.99 + (i * 23.45),
    method: i % 3 === 0 ? 'credit_card' : i % 3 === 1 ? 'paypal' : 'bank_transfer',
    status: i % 4 === 0 ? 'pending' : i % 4 === 1 ? 'processing' : i % 4 === 2 ? 'completed' : 'failed',
    transactionId: `TXN-${String(1000000 + i).padStart(7, '0')}`,
    createdAt: new Date(2024, 0, 1 + (i % 30))
  });
}
db.payments.insertMany(payments);

// ========== CREATE INDEXES ==========
print('Creating indexes...');

// Users indexes
db.users.createIndex({ email: 1 }, { unique: true });
db.users.createIndex({ city: 1 });
db.users.createIndex({ role: 1 });
db.users.createIndex({ createdAt: -1 });

// Products indexes
db.products.createIndex({ sku: 1 }, { unique: true });
db.products.createIndex({ category: 1 });
db.products.createIndex({ brand: 1 });
db.products.createIndex({ price: 1 });
db.products.createIndex({ rating: -1 });
db.products.createIndex({ tags: 1 });

// Orders indexes
db.orders.createIndex({ orderNumber: 1 }, { unique: true });
db.orders.createIndex({ userId: 1 });
db.orders.createIndex({ status: 1 });
db.orders.createIndex({ createdAt: -1 });
db.orders.createIndex({ "shippingAddress.city": 1 });

// Order items indexes
db.orderItems.createIndex({ orderId: 1 });
db.orderItems.createIndex({ productId: 1 });

// Reviews indexes
db.reviews.createIndex({ userId: 1 });
db.reviews.createIndex({ productId: 1 });
db.reviews.createIndex({ rating: -1 });
db.reviews.createIndex({ createdAt: -1 });

// Cart items indexes
db.cartItems.createIndex({ userId: 1 });
db.cartItems.createIndex({ productId: 1 });

// Payments indexes
db.payments.createIndex({ orderId: 1 });
db.payments.createIndex({ userId: 1 });
db.payments.createIndex({ transactionId: 1 }, { unique: true });
db.payments.createIndex({ status: 1 });

print('MongoDB initialization complete!');
print(`Created: ${users.length} users, ${products.length} products, ${orders.length} orders, ${orderItems.length} order items, ${reviews.length} reviews, ${cartItems.length} cart items, ${payments.length} payments`);

