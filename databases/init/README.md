# Database Initialization Scripts

This directory contains initialization scripts for all 5 NoSQL databases.

## Files

- **mongodb-init.js** - MongoDB collections, indexes, and sample data (20 users, 20 products, 50 orders, 100 reviews)
- **redis-init.sh** - Redis key-value data structures (user profiles, products, orders, carts, leaderboards)
- **cassandra-init.cql** - Cassandra keyspace, tables, and sample data (13 tables with proper partitioning)
- **neo4j-init.cypher** - Neo4j graph nodes and relationships (10 users, 10 products, 10 orders, 60+ relationships)
- **fuseki-init.ttl** - RDF/SPARQL triples (100+ triples with OWL properties)

## Data Theme

All scripts initialize databases with **e-commerce platform** data:
- Users, Products, Orders, Reviews, Payments, Categories, Cart Items

## Usage

See main README.md for initialization commands.

