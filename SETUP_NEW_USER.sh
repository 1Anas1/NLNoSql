#!/bin/bash
# Script d'installation automatique pour nouveau utilisateur
# Usage: ./SETUP_NEW_USER.sh

set -e

echo "=========================================="
echo "MultiLink Project - Setup Script"
echo "=========================================="
echo ""

# Vérifier Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker n'est pas installé!"
    echo "Installez Docker Desktop depuis: https://www.docker.com/products/docker-desktop"
    exit 1
fi

if ! docker info &> /dev/null; then
    echo "❌ Docker n'est pas démarré!"
    echo "Démarrez Docker Desktop et réessayez."
    exit 1
fi

echo "✅ Docker détecté"
echo ""

# Démarrer les conteneurs
echo "🚀 Démarrage des bases de données..."
docker-compose up -d

echo ""
echo "⏳ Attente du démarrage des conteneurs (30 secondes)..."
sleep 30

# MongoDB (auto-loads)
echo ""
echo "📦 MongoDB: Données chargées automatiquement"
sleep 2

# Redis
echo "📦 Redis: Chargement des données..."
docker exec redis-nosql sh /tmp/init.sh 2>&1 | tail -1

# Cassandra
echo "📦 Cassandra: Chargement des données..."
sleep 5
docker exec cassandra-nosql cqlsh -f /init.cql 2>&1 | tail -1

# Neo4j
echo "📦 Neo4j: Chargement des données..."
sleep 3
docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 -f /init.cypher 2>&1 | tail -1

# Fuseki
echo ""
echo "⚠️  Fuseki: Upload manuel requis"
echo "   1. Ouvrir http://localhost:3030"
echo "   2. Se connecter (admin/admin123)"
echo "   3. Upload le fichier databases/init/fuseki-init.ttl"

echo ""
echo "=========================================="
echo "✅ Installation terminée!"
echo "=========================================="
echo ""
echo "Vérification rapide:"
echo "  - MongoDB: http://localhost:27017"
echo "  - Redis: http://localhost:6379"
echo "  - Neo4j Browser: http://localhost:7474"
echo "  - Fuseki: http://localhost:3030"
echo ""
echo "Pour arrêter: docker-compose down"
echo "Pour redémarrer: docker-compose up -d"

