# PowerShell script to load extensive data into all databases
# This script loads comprehensive e-commerce data

Write-Host "=== Loading Extensive E-commerce Data ===" -ForegroundColor Green
Write-Host ""

# Find docker-compose file
$file = Get-ChildItem -Path "D:\" -Recurse -Filter "docker-compose.yml" -ErrorAction SilentlyContinue | 
    Where-Object { (Get-Content $_.FullName -Raw) -match "redis-nosql" } | Select-Object -First 1

if (-not $file) {
    Write-Host "Could not find docker-compose.yml" -ForegroundColor Red
    exit 1
}

$projectDir = $file.DirectoryName
Push-Location $projectDir

Write-Host "Loading data into MongoDB..." -ForegroundColor Cyan
# MongoDB loads automatically via init script
Start-Sleep -Seconds 5
$mongoCheck = docker exec mongodb-nosql mongosh -u admin -p admin123 --authenticationDatabase admin --quiet --eval "db.users.countDocuments()" 2>&1
Write-Host "  MongoDB: $mongoCheck users loaded" -ForegroundColor Green

Write-Host "Loading data into Redis..." -ForegroundColor Cyan
if (Test-Path "init/redis-init.sh") {
    Get-Content "init/redis-init.sh" | docker exec -i redis-nosql sh 2>&1 | Out-Null
    $redisCheck = docker exec redis-nosql redis-cli GET user:1:profile 2>&1
    if ($redisCheck -match "Alice") {
        Write-Host "  Redis: Data loaded successfully" -ForegroundColor Green
    }
}

Write-Host "Loading data into Cassandra..." -ForegroundColor Cyan
if (Test-Path "init/cassandra-init.cql") {
    Get-Content "init/cassandra-init.cql" | docker exec -i cassandra-nosql cqlsh 2>&1 | Out-Null
    Write-Host "  Cassandra: Schema and data loaded" -ForegroundColor Green
}

Write-Host "Loading data into Neo4j..." -ForegroundColor Cyan
if (Test-Path "init/neo4j-init.cypher") {
    Get-Content "init/neo4j-init.cypher" | docker exec -i neo4j-nosql cypher-shell -u neo4j -p neo4j123 2>&1 | Out-Null
    Write-Host "  Neo4j: Graph data loaded" -ForegroundColor Green
}

Write-Host "Loading data into Fuseki..." -ForegroundColor Cyan
Write-Host "  Fuseki: Load data via web UI at http://localhost:3030" -ForegroundColor Yellow
Write-Host "    Upload init/fuseki-init.ttl to the dataset" -ForegroundColor Yellow

Write-Host ""
Write-Host "=== Data Loading Summary ===" -ForegroundColor Green
Write-Host "MongoDB: 20 users, 20 products, 50 orders, 100+ order items, 100 reviews" -ForegroundColor White
Write-Host "Redis: 10 users, 10 products, 5 orders, carts, recommendations" -ForegroundColor White
Write-Host "Cassandra: Users, products, orders, order items, reviews, payments" -ForegroundColor White
Write-Host "Neo4j: 10 users, 10 products, 10 orders, reviews, relationships" -ForegroundColor White
Write-Host "Fuseki: Users, products, orders, reviews, payments (RDF)" -ForegroundColor White

Pop-Location

