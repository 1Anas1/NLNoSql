# Databases Configuration

This directory contains all database initialization scripts and configurations.

## Structure

```
databases/
├── init/              # Initialization scripts with sample data
│   ├── mongodb-init.js      # MongoDB collections and data
│   ├── redis-init.sh        # Redis key-value data
│   ├── cassandra-init.cql   # Cassandra schema and data
│   ├── neo4j-init.cypher    # Neo4j graph data
│   └── fuseki-init.ttl      # RDF/SPARQL data
└── config/            # Database configurations
    └── fuseki-config.ttl    # Fuseki server configuration
```

## Data Theme: E-Commerce Platform

All databases are initialized with consistent e-commerce data:

- **Users**: Customer profiles with roles, locations
- **Products**: Product catalog with categories, prices, stock
- **Orders**: Order records with statuses, shipping info
- **Order Items**: Line items linking orders to products
- **Reviews**: Product reviews with ratings
- **Payments**: Payment transactions
- **Cart Items**: Shopping cart data
- **Categories**: Product categories

## Initialization

See main README.md for initialization commands.

## Data Counts

- **MongoDB**: 20 users, 20 products, 50 orders, 100 reviews, 30 cart items, 50 payments
- **Redis**: 100+ keys with various data structures
- **Cassandra**: 13 tables with sample data
- **Neo4j**: 10 users, 10 products, 10 orders, 60+ relationships
- **Fuseki**: 100+ RDF triples

