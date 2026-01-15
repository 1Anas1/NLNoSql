# Complete startup and test script
# This script: 1) Starts all databases, 2) Initializes them, 3) Tests them

Write-Host "=== LLM NoSQL Multi-Engine Database Setup ===" -ForegroundColor Green
Write-Host ""

# Check Docker
Write-Host "Checking Docker..." -ForegroundColor Cyan
try {
    docker ps | Out-Null
    Write-Host "✓ Docker is running" -ForegroundColor Green
} catch {
    Write-Host "✗ Docker is not running!" -ForegroundColor Red
    Write-Host "  Please start Docker Desktop and try again." -ForegroundColor Yellow
    exit 1
}
Write-Host ""

# Step 1: Start databases
Write-Host "Step 1: Starting all databases..." -ForegroundColor Cyan
docker-compose up -d
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to start databases" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Databases started" -ForegroundColor Green
Write-Host "  Waiting 30 seconds for services to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 30
Write-Host ""

# Step 2: Initialize databases
Write-Host "Step 2: Initializing databases with sample data..." -ForegroundColor Cyan
if (Test-Path "scripts/init-all-databases.ps1") {
    & "scripts/init-all-databases.ps1"
} else {
    Write-Host "⚠ Init script not found, skipping initialization" -ForegroundColor Yellow
}
Write-Host ""

# Step 3: Test databases
Write-Host "Step 3: Testing all databases..." -ForegroundColor Cyan
if (Test-Path "scripts/test-all-databases.ps1") {
    & "scripts/test-all-databases.ps1"
} else {
    Write-Host "⚠ Test script not found" -ForegroundColor Yellow
}
Write-Host ""

Write-Host "=== Setup Complete ===" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Access Neo4j Browser: http://localhost:7474" -ForegroundColor White
Write-Host "  2. Access Fuseki Web UI: http://localhost:3030" -ForegroundColor White
Write-Host "  3. Run Python tests: python examples/test_*.py" -ForegroundColor White
Write-Host "  4. View logs: docker-compose logs -f" -ForegroundColor White

