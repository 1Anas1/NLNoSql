#!/bin/bash
# Complete startup and test script for Linux/Mac
# This script: 1) Starts all databases, 2) Initializes them, 3) Tests them

echo "=== LLM NoSQL Multi-Engine Database Setup ==="
echo ""

# Check Docker
echo "Checking Docker..."
if ! docker ps &> /dev/null; then
    echo "✗ Docker is not running!"
    echo "  Please start Docker and try again."
    exit 1
fi
echo "✓ Docker is running"
echo ""

# Step 1: Start databases
echo "Step 1: Starting all databases..."
docker-compose up -d
if [ $? -ne 0 ]; then
    echo "✗ Failed to start databases"
    exit 1
fi
echo "✓ Databases started"
echo "  Waiting 30 seconds for services to initialize..."
sleep 30
echo ""

# Step 2: Initialize databases
echo "Step 2: Initializing databases with sample data..."
if [ -f "scripts/init-all-databases.sh" ]; then
    chmod +x scripts/init-all-databases.sh
    ./scripts/init-all-databases.sh
else
    echo "⚠ Init script not found, skipping initialization"
fi
echo ""

# Step 3: Test databases
echo "Step 3: Testing all databases..."
echo "Testing Redis..."
docker exec redis-nosql redis-cli GET user:123:name > /dev/null 2>&1 && echo "  ✓ Redis OK" || echo "  ✗ Redis failed"

echo "Testing MongoDB..."
docker exec mongodb-nosql mongosh -u admin -p admin123 --authenticationDatabase admin --quiet --eval "db.users.countDocuments()" > /dev/null 2>&1 && echo "  ✓ MongoDB OK" || echo "  ✗ MongoDB failed"

echo "Testing Cassandra..."
docker exec cassandra-nosql cqlsh -e "SELECT COUNT(*) FROM llm_nosql_keyspace.users;" > /dev/null 2>&1 && echo "  ✓ Cassandra OK" || echo "  ✗ Cassandra failed"

echo "Testing Neo4j..."
docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 "MATCH (n:User) RETURN count(n)" --format plain > /dev/null 2>&1 && echo "  ✓ Neo4j OK" || echo "  ✗ Neo4j failed"

echo "Testing Fuseki..."
curl -s http://localhost:3030/\$/ping > /dev/null 2>&1 && echo "  ✓ Fuseki OK" || echo "  ✗ Fuseki failed"

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Access Neo4j Browser: http://localhost:7474"
echo "  2. Access Fuseki Web UI: http://localhost:3030"
echo "  3. Run Python tests: python examples/test_*.py"
echo "  4. View logs: docker-compose logs -f"

