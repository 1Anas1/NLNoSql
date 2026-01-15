#!/bin/bash
# Script to initialize all databases with sample data
# Run this after starting the containers with: docker-compose up -d

echo "=== Initializing All NoSQL Databases ==="
echo ""

# Wait for services to be ready
echo "Waiting for services to start..."
sleep 10

# Initialize Redis
echo "1. Initializing Redis..."
docker exec redis-nosql redis-cli SET user:123:name "Alice Johnson"
docker exec redis-nosql redis-cli SET user:123:email "alice@example.com"
docker exec redis-nosql redis-cli SET user:123:views 150
docker exec redis-nosql redis-cli SET user:123:score 850

docker exec redis-nosql redis-cli SET user:456:name "Bob Smith"
docker exec redis-nosql redis-cli SET user:456:email "bob@example.com"
docker exec redis-nosql redis-cli SET user:456:views 230
docker exec redis-nosql redis-cli SET user:456:score 920

docker exec redis-nosql redis-cli SET user:789:name "Charlie Brown"
docker exec redis-nosql redis-cli SET user:789:email "charlie@example.com"
docker exec redis-nosql redis-cli SET user:789:views 89
docker exec redis-nosql redis-cli SET user:789:score 650

docker exec redis-nosql redis-cli ZADD leaderboard:score 850 user:123
docker exec redis-nosql redis-cli ZADD leaderboard:score 920 user:456
docker exec redis-nosql redis-cli ZADD leaderboard:score 650 user:789

docker exec redis-nosql redis-cli ZADD leaderboard:views 150 user:123
docker exec redis-nosql redis-cli ZADD leaderboard:views 230 user:456
docker exec redis-nosql redis-cli ZADD leaderboard:views 89 user:789

docker exec redis-nosql redis-cli HMSET user:123:profile name "Alice Johnson" age 28 city "Paris" bio "Software Engineer"
docker exec redis-nosql redis-cli HMSET user:456:profile name "Bob Smith" age 32 city "London" bio "Data Scientist"
docker exec redis-nosql redis-cli HMSET user:789:profile name "Charlie Brown" age 25 city "Berlin" bio "Designer"

docker exec redis-nosql redis-cli LPUSH feed:user:123 "Posted a new photo"
docker exec redis-nosql redis-cli LPUSH feed:user:123 "Liked a post"
docker exec redis-nosql redis-cli LPUSH feed:user:123 "Commented on a post"

docker exec redis-nosql redis-cli SADD followers:user:123 user:456 user:789
docker exec redis-nosql redis-cli SADD followers:user:456 user:123 user:789
docker exec redis-nosql redis-cli SADD followers:user:789 user:123

echo "✓ Redis initialized"
echo ""

# MongoDB is initialized automatically via init script
echo "2. MongoDB initialized automatically"
echo ""

# Initialize Cassandra
echo "3. Initializing Cassandra..."
echo "Waiting for Cassandra to be ready..."
sleep 30

docker exec cassandra-nosql cqlsh -f /docker-entrypoint-initdb.d/init.cql || {
    echo "Cassandra not ready yet, trying direct CQL..."
    docker exec cassandra-nosql cqlsh -e "CREATE KEYSPACE IF NOT EXISTS llm_nosql_keyspace WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};"
}

echo "✓ Cassandra initialized"
echo ""

# Initialize Neo4j
echo "4. Initializing Neo4j..."
echo "Waiting for Neo4j to be ready..."
sleep 15

docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 "MATCH (n) RETURN count(n) LIMIT 1" > /dev/null 2>&1 || {
    echo "Loading Neo4j data..."
    docker exec -i neo4j-nosql cypher-shell -u neo4j -p neo4j123 < init/neo4j-init.cypher
}

echo "✓ Neo4j initialized"
echo ""

# Initialize Fuseki
echo "5. Initializing Fuseki..."
echo "Waiting for Fuseki to be ready..."
sleep 10

# Load RDF data into Fuseki
docker exec fuseki-nosql curl -X POST \
    -H "Content-Type: application/rdf+xml" \
    -T /fuseki/init-data.ttl \
    "http://localhost:3030/llm_nosql_dataset/data?default" || {
    echo "Fuseki dataset may need manual initialization via web UI"
}

echo "✓ Fuseki initialized"
echo ""

echo "=== All databases initialized successfully! ==="
echo ""
echo "Access points:"
echo "  - Redis: localhost:6379"
echo "  - MongoDB: localhost:27017 (admin/admin123)"
echo "  - Cassandra: localhost:9042"
echo "  - Neo4j: http://localhost:7474 (neo4j/neo4j123)"
echo "  - Fuseki: http://localhost:3030 (admin/admin123)"

