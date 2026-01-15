# Script d'installation automatique pour nouveau utilisateur (Windows)
# Usage: .\SETUP_NEW_USER.ps1

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "MultiLink Project - Setup Script" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier Docker
try {
    docker info | Out-Null
    Write-Host "✅ Docker détecté" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker n'est pas installé ou démarré!" -ForegroundColor Red
    Write-Host "Installez et démarrez Docker Desktop depuis: https://www.docker.com/products/docker-desktop" -ForegroundColor Yellow
    exit 1
}

Write-Host ""

# Démarrer les conteneurs
Write-Host "🚀 Démarrage des bases de données..." -ForegroundColor Cyan
docker-compose up -d

Write-Host ""
Write-Host "⏳ Attente du démarrage des conteneurs (30 secondes)..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# MongoDB (auto-loads)
Write-Host ""
Write-Host "📦 MongoDB: Données chargées automatiquement" -ForegroundColor Green
Start-Sleep -Seconds 2

# Redis
Write-Host "📦 Redis: Chargement des données..." -ForegroundColor Cyan
docker exec redis-nosql sh /tmp/init.sh 2>&1 | Out-Null
Write-Host "   ✅ Redis chargé" -ForegroundColor Green

# Cassandra
Write-Host "📦 Cassandra: Chargement des données..." -ForegroundColor Cyan
Start-Sleep -Seconds 5
docker exec cassandra-nosql cqlsh -f /init.cql 2>&1 | Out-Null
Write-Host "   ✅ Cassandra chargé" -ForegroundColor Green

# Neo4j
Write-Host "📦 Neo4j: Chargement des données..." -ForegroundColor Cyan
Start-Sleep -Seconds 3
docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 -f /init.cypher 2>&1 | Out-Null
Write-Host "   ✅ Neo4j chargé" -ForegroundColor Green

# Fuseki
Write-Host ""
Write-Host "⚠️  Fuseki: Upload manuel requis" -ForegroundColor Yellow
Write-Host "   1. Ouvrir http://localhost:3030" -ForegroundColor White
Write-Host "   2. Se connecter (admin/admin123)" -ForegroundColor White
Write-Host "   3. Upload le fichier databases\init\fuseki-init.ttl" -ForegroundColor White

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "✅ Installation terminée!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Vérification rapide:" -ForegroundColor Cyan
Write-Host "  - MongoDB: http://localhost:27017" -ForegroundColor White
Write-Host "  - Redis: http://localhost:6379" -ForegroundColor White
Write-Host "  - Neo4j Browser: http://localhost:7474" -ForegroundColor White
Write-Host "  - Fuseki: http://localhost:3030" -ForegroundColor White
Write-Host ""
Write-Host "Pour arrêter: docker-compose down" -ForegroundColor Yellow
Write-Host "Pour redémarrer: docker-compose up -d" -ForegroundColor Yellow

