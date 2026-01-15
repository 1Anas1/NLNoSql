# 🚀 Quick Start Guide

Guide rapide pour démarrer le projet MultiLink avec toutes les bases de données.

## ⚡ Installation en 3 étapes

### 1. Prérequis
- **Docker Desktop** installé et démarré
- Terminal (PowerShell sur Windows, Bash sur Linux/Mac)

### 2. Démarrer les bases de données

```bash
docker-compose up -d
```

Attendre 30-60 secondes que tous les conteneurs démarrent.

### 3. Initialiser les données

#### Windows:
```powershell
.\SETUP_NEW_USER.ps1
```

#### Linux/Mac:
```bash
chmod +x SETUP_NEW_USER.sh
./SETUP_NEW_USER.sh
```

**OU** manuellement:

```bash
# Redis
docker exec redis-nosql sh /tmp/init.sh

# Cassandra (attendre 15 secondes après docker-compose)
sleep 15
docker exec cassandra-nosql cqlsh -f /init.cql

# Neo4j
docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 -f /init.cypher

# Fuseki: Upload databases/init/fuseki-init.ttl via http://localhost:3030
```

## ✅ Vérification

```bash
# Vérifier que tous les conteneurs tournent
docker ps

# Devrait afficher 5 conteneurs:
# redis-nosql, mongodb-nosql, cassandra-nosql, neo4j-nosql, fuseki-nosql
```

## 🌐 Accès Web

- **Neo4j Browser**: http://localhost:7474 (neo4j/neo4j123)
- **Fuseki**: http://localhost:3030 (admin/admin123)

## 📊 Données

Toutes les bases contiennent:
- 20 utilisateurs
- 20 produits
- 50 commandes
- 100+ avis
- 50 paiements

## 🛑 Arrêter

```bash
docker-compose down
```

## 📚 Documentation complète

- `SHARING_GUIDE.md` - Guide détaillé de partage
- `README.md` - Documentation principale
- `docs/ARCHITECTURE.md` - Architecture du système

