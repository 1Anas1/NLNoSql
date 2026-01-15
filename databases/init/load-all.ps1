# Load all database initialization scripts
# Run this after: docker-compose up -d

Write-Host "=== Loading All Database Data ===" -ForegroundColor Green
Write-Host ""

# MongoDB (auto-loads on startup)
Write-Host "1. MongoDB (auto-loads on container start)" -ForegroundColor Cyan
Start-Sleep -Seconds 2

# Redis
Write-Host "2. Loading Redis..." -ForegroundColor Cyan
docker exec redis-nosql sh /tmp/init.sh 2>&1 | Out-Null
Write-Host "   Redis loaded" -ForegroundColor Green

# Cassandra
Write-Host "3. Loading Cassandra..." -ForegroundColor Cyan
Start-Sleep -Seconds 5
docker exec cassandra-nosql cqlsh -f /init.cql 2>&1 | Out-Null
Write-Host "   Cassandra loaded" -ForegroundColor Green

# Neo4j
Write-Host "4. Loading Neo4j..." -ForegroundColor Cyan
Start-Sleep -Seconds 3
docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 -f /init.cypher 2>&1 | Out-Null
Write-Host "   Neo4j loaded" -ForegroundColor Green

# Fuseki
Write-Host "5. Fuseki: Upload databases/init/fuseki-init.ttl via http://localhost:3030" -ForegroundColor Yellow

Write-Host ""
Write-Host "=== Loading Complete ===" -ForegroundColor Green

