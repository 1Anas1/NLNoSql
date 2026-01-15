# Guide de Partage - MultiLink Project

Ce guide explique comment partager et configurer ce projet avec toutes les bases de données et données.

## 📦 Ce qui est inclus

- ✅ 5 bases de données NoSQL configurées (Redis, MongoDB, Cassandra, Neo4j, Fuseki)
- ✅ Scripts d'initialisation avec données e-commerce complètes
- ✅ Structure de code MultiLink prête pour développement
- ✅ Docker Compose pour orchestrer toutes les bases de données

## 🚀 Pour celui qui reçoit le projet

### Prérequis

1. **Docker Desktop** installé et démarré
   - Windows/Mac: https://www.docker.com/products/docker-desktop
   - Linux: `sudo apt-get install docker.io docker-compose`

2. **Git** (optionnel, pour cloner le repo)

### Installation rapide

#### Option 1: Via Git (recommandé)

```bash
# Cloner le projet
git clone <repository-url>
cd projet

# Démarrer toutes les bases de données
docker-compose up -d

# Attendre que tous les conteneurs soient prêts (30-60 secondes)
# Puis initialiser les données
```

#### Option 2: Via fichier ZIP

1. Extraire le fichier ZIP
2. Ouvrir un terminal dans le dossier `projet`
3. Exécuter:
   ```bash
   docker-compose up -d
   ```

### Initialisation des données

Une fois les conteneurs démarrés, initialiser les données:

#### Windows (PowerShell)

```powershell
# MongoDB (se charge automatiquement au démarrage)
# Vérifier: docker exec mongodb-nosql mongosh -u admin -p admin123 --authenticationDatabase admin --eval "db = db.getSiblingDB('llm_nosql_db'); db.users.countDocuments()"

# Redis
docker exec redis-nosql sh /tmp/init.sh

# Cassandra (attendre 10-15 secondes après le démarrage)
Start-Sleep -Seconds 15
docker exec cassandra-nosql cqlsh -f /init.cql

# Neo4j
docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 -f /init.cypher

# Fuseki - Upload manuel via http://localhost:3030
# 1. Aller sur http://localhost:3030
# 2. Se connecter (admin/admin123)
# 3. Upload le fichier databases/init/fuseki-init.ttl
```

#### Linux/Mac

```bash
# MongoDB (se charge automatiquement)
docker exec mongodb-nosql mongosh -u admin -p admin123 --authenticationDatabase admin --eval "db = db.getSiblingDB('llm_nosql_db'); db.users.countDocuments()"

# Redis
docker exec redis-nosql sh /tmp/init.sh

# Cassandra
sleep 15
docker exec cassandra-nosql cqlsh -f /init.cql

# Neo4j
docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 -f /init.cypher

# Fuseki - Upload manuel via http://localhost:3030
```

### Script automatique (Windows)

Un script PowerShell est disponible pour automatiser tout:

```powershell
.\databases\init\load-all.ps1
```

## ✅ Vérification

Vérifier que tout fonctionne:

```bash
# Vérifier les conteneurs
docker ps

# Devrait afficher 5 conteneurs:
# - redis-nosql
# - mongodb-nosql
# - cassandra-nosql
# - neo4j-nosql
# - fuseki-nosql
```

### Tests rapides

**MongoDB:**
```bash
docker exec mongodb-nosql mongosh -u admin -p admin123 --authenticationDatabase admin --eval "db = db.getSiblingDB('llm_nosql_db'); db.users.countDocuments()"
# Devrait retourner: 20
```

**Redis:**
```bash
docker exec redis-nosql redis-cli DBSIZE
# Devrait retourner un nombre > 0
```

**Cassandra:**
```bash
docker exec cassandra-nosql cqlsh -e "SELECT COUNT(*) FROM llm_nosql_keyspace.users;"
```

**Neo4j:**
```bash
docker exec neo4j-nosql cypher-shell -u neo4j -p neo4j123 "MATCH (n:User) RETURN count(n)"
# Devrait retourner: 10
```

**Fuseki:**
- Ouvrir http://localhost:3030
- Se connecter avec admin/admin123
- Vérifier que le dataset contient des données

## 🌐 Accès aux interfaces web

- **Neo4j Browser**: http://localhost:7474 (neo4j/neo4j123)
- **Fuseki Web UI**: http://localhost:3030 (admin/admin123)

## 📊 Données incluses

Toutes les bases contiennent des données e-commerce:

- **20 utilisateurs** avec profils complets
- **20 produits** dans 5 catégories
- **50 commandes** avec statuts variés
- **100+ avis** produits
- **50 paiements** avec différentes méthodes
- **30 articles** dans les paniers
- **5 catégories** de produits

## 🛠️ Commandes utiles

```bash
# Arrêter toutes les bases de données
docker-compose down

# Redémarrer
docker-compose up -d

# Voir les logs
docker-compose logs -f

# Supprimer toutes les données (ATTENTION!)
docker-compose down -v
```

## 📁 Structure du projet

```
projet/
├── databases/          # Configurations et scripts d'init
├── src/               # Code source MultiLink
├── docs/              # Documentation
├── docker-compose.yml # Orchestration Docker
└── README.md          # Documentation principale
```

## ❓ Problèmes courants

### Docker Desktop n'est pas démarré
- Démarrer Docker Desktop avant d'exécuter `docker-compose up -d`

### Port déjà utilisé
- Arrêter les autres services utilisant les ports 6379, 27017, 9042, 7474, 7687, 3030

### Cassandra prend du temps à démarrer
- Attendre 15-30 secondes après `docker-compose up -d` avant d'initialiser

### Fuseki ne charge pas les données
- Upload manuel requis via l'interface web http://localhost:3030

## 📧 Support

Pour toute question, consulter:
- `README.md` - Documentation principale
- `docs/ARCHITECTURE.md` - Architecture du système
- `projet.md` - Spécification complète du projet

