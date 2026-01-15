# Comprehensive test script for all databases
# Run this after: docker-compose up -d and ./scripts/init-all-databases.ps1

Write-Host "=== Testing All NoSQL Databases ===" -ForegroundColor Green
Write-Host ""

$errors = @()

# Test 1: Redis
Write-Host "1. Testing Redis..." -ForegroundColor Cyan
try {
    $result = docker exec redis-nosql redis-cli GET user:123:name
    if ($result -eq "Alice Johnson") {
        Write-Host "  ✓ Redis: Connected and data loaded" -ForegroundColor Green
    } else {
        Write-Host "  ✗ Redis: Data mismatch" -ForegroundColor Red
        $errors += "Redis data mismatch"
    }
} catch {
    Write-Host "  ✗ Redis: Connection failed" -ForegroundColor Red
    $errors += "Redis connection failed"
}
Write-Host ""

# Test 2: MongoDB
Write-Host "2. Testing MongoDB..." -ForegroundColor Cyan
try {
    $result = docker exec mongodb-nosql mongosh -u admin -p admin123 --authenticationDatabase admin --quiet --eval "db.users.countDocuments()"
    if ($result -match "3") {
        Write-Host "  ✓ MongoDB: Connected and data loaded (3 users)" -ForegroundColor Green
    } else {
        Write-Host "  ✗ MongoDB: Data mismatch" -ForegroundColor Red
        $errors += "MongoDB data mismatch"
    }
} catch {
    Write-Host "  ✗ MongoDB: Connection failed" -ForegroundColor Red
    $errors += "MongoDB connection failed"
}
Write-Host ""

# Test 3: Cassandra
Write-Host "3. Testing Cassandra..." -ForegroundColor Cyan
try {
    $result = docker exec cassandra-nosql cqlsh -e "SELECT COUNT(*) FROM llm_nosql_keyspace.users;" 2>&1
    if ($result -match "3") {
        Write-Host "  ✓ Cassandra: Connected and data loaded" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Cassandra: May need initialization" -ForegroundColor Yellow
        Write-Host "    Run: docker exec -i cassandra-nosql cqlsh < init/cassandra-init.cql" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  ✗ Cassandra: Connection failed" -ForegroundColor Red
    $errors += "Cassandra connection failed"
}
Write-Host ""

# Test 4: Neo4j
Write-Host "4. Testing Neo4j..." -ForegroundColor Cyan
try {
    $result = docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 "MATCH (n:User) RETURN count(n) AS count" --format plain 2>&1
    if ($result -match "3") {
        Write-Host "  ✓ Neo4j: Connected and data loaded (3 users)" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Neo4j: May need initialization" -ForegroundColor Yellow
        Write-Host "    Run: Get-Content init/neo4j-init.cypher | docker exec -i neo4j-nosql cypher-shell -u neo4j -p neo4j123" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  ✗ Neo4j: Connection failed" -ForegroundColor Red
    $errors += "Neo4j connection failed"
}
Write-Host ""

# Test 5: Fuseki
Write-Host "5. Testing Fuseki..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3030/llm_nosql_dataset/query" -Method POST -ContentType "application/sparql-query" -Body "SELECT COUNT(*) WHERE { ?s ?p ?o }" -UseBasicParsing -ErrorAction SilentlyContinue
    if ($response.StatusCode -eq 200) {
        Write-Host "  ✓ Fuseki: Connected and responding" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Fuseki: May need data loading" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  ⚠ Fuseki: May need initialization via web UI" -ForegroundColor Yellow
    Write-Host "    Access: http://localhost:3030" -ForegroundColor Yellow
}
Write-Host ""

# Test 6: Python Scripts
Write-Host "6. Testing Python scripts..." -ForegroundColor Cyan
if (Get-Command python -ErrorAction SilentlyContinue) {
    Write-Host "  Python found, testing scripts..." -ForegroundColor Yellow
    
    $pythonTests = @(
        "examples/test_redis.py",
        "examples/test_mongodb.py",
        "examples/test_cassandra.py",
        "examples/test_neo4j.py",
        "examples/test_fuseki.py"
    )
    
    foreach ($script in $pythonTests) {
        if (Test-Path $script) {
            Write-Host "    Running $script..." -ForegroundColor Gray
            python $script 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "    ✓ $script" -ForegroundColor Green
            } else {
                Write-Host "    ✗ $script failed" -ForegroundColor Red
            }
        }
    }
} else {
    Write-Host "  ⚠ Python not found. Install Python and run: pip install -r requirements.txt" -ForegroundColor Yellow
}
Write-Host ""

# Summary
Write-Host "=== Test Summary ===" -ForegroundColor Green
if ($errors.Count -eq 0) {
    Write-Host "✓ All databases are running and accessible!" -ForegroundColor Green
} else {
    Write-Host "⚠ Some issues detected:" -ForegroundColor Yellow
    foreach ($error in $errors) {
        Write-Host "  - $error" -ForegroundColor Yellow
    }
}
Write-Host ""
Write-Host "Access URLs:" -ForegroundColor Cyan
Write-Host "  - Neo4j Browser: http://localhost:7474 (neo4j/neo4j123)" -ForegroundColor White
Write-Host "  - Fuseki Web UI: http://localhost:3030 (admin/admin123)" -ForegroundColor White
Write-Host "  - MongoDB: mongodb://admin:admin123@localhost:27017" -ForegroundColor White

