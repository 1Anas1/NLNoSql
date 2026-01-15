#!/bin/bash
# Load all database initialization scripts
# Run this after: docker-compose up -d

echo "=== Loading All Database Data ==="

# MongoDB (auto-loads on startup)
echo "1. MongoDB (auto-loads on container start)"
sleep 2

# Redis
echo "2. Loading Redis..."
docker exec redis-nosql sh /tmp/init.sh 2>&1 | tail -1

# Cassandra
echo "3. Loading Cassandra..."
sleep 5
docker exec cassandra-nosql cqlsh -f /init.cql 2>&1 | tail -1

# Neo4j
echo "4. Loading Neo4j..."
sleep 3
docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 -f /init.cypher 2>&1 | tail -1

# Fuseki
echo "5. Fuseki: Upload databases/init/fuseki-init.ttl via http://localhost:3030"

echo ""
echo "=== Loading Complete ==="

