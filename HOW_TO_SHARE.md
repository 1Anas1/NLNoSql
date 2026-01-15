# 📤 Comment Partager ce Projet

Guide pour partager le projet MultiLink avec votre ami, incluant toutes les bases de données et données.

## 📦 Méthodes de Partage

### Option 1: Via Git (Recommandé)

Si vous utilisez Git/GitHub/GitLab:

```bash
# 1. Créer un repository (si pas déjà fait)
git init
git add .
git commit -m "Initial commit - MultiLink project with all databases"

# 2. Pousser vers GitHub/GitLab
git remote add origin <your-repo-url>
git push -u origin main

# 3. Votre ami peut cloner:
git clone <your-repo-url>
cd projet
```

**Avantages:**
- ✅ Facile à mettre à jour
- ✅ Version control
- ✅ Pas de limite de taille (les données sont dans les scripts)

### Option 2: Via Fichier ZIP

1. **Créer le ZIP:**
   ```bash
   # Windows PowerShell
   Compress-Archive -Path . -DestinationPath multilink-project.zip -Force
   
   # Linux/Mac
   zip -r multilink-project.zip . -x "*.git*" -x "*__pycache__*"
   ```

2. **Partager le fichier ZIP** (email, cloud, USB, etc.)

3. **Votre ami extrait et suit les instructions**

**Fichiers à inclure:**
- ✅ Tous les fichiers du projet
- ✅ `databases/` avec tous les scripts d'init
- ✅ `docker-compose.yml`
- ✅ `README.md` et guides
- ❌ Exclure `.git/` (si Git)
- ❌ Exclure `__pycache__/` et `.pyc`

### Option 3: Via Cloud Storage

Uploader le projet sur:
- Google Drive
- Dropbox
- OneDrive
- etc.

## 📋 Checklist avant Partage

- [ ] Tous les fichiers sont présents dans `databases/init/`
- [ ] `docker-compose.yml` est à jour
- [ ] `README.md` contient les instructions
- [ ] Scripts `SETUP_NEW_USER.ps1` et `SETUP_NEW_USER.sh` sont présents
- [ ] Documentation `SHARING_GUIDE.md` et `QUICK_START.md` sont incluses

## 📝 Instructions pour votre Ami

Envoyez-lui ce message:

---

**Bonjour!**

Voici le projet MultiLink avec toutes les bases de données configurées.

### Installation rapide:

1. **Installer Docker Desktop** (si pas déjà fait)
   - https://www.docker.com/products/docker-desktop

2. **Extraire le projet** (si ZIP) ou cloner (si Git)

3. **Ouvrir un terminal** dans le dossier `projet`

4. **Exécuter:**

   **Windows:**
   ```powershell
   .\SETUP_NEW_USER.ps1
   ```

   **Linux/Mac:**
   ```bash
   chmod +x SETUP_NEW_USER.sh
   ./SETUP_NEW_USER.sh
   ```

5. **C'est tout!** Les bases de données seront démarrées et initialisées automatiquement.

### Documentation:

- `QUICK_START.md` - Guide rapide
- `SHARING_GUIDE.md` - Guide détaillé
- `README.md` - Documentation complète

### Accès Web:

- Neo4j Browser: http://localhost:7474 (neo4j/neo4j123)
- Fuseki: http://localhost:3030 (admin/admin123)

### Données incluses:

- 20 utilisateurs
- 20 produits
- 50 commandes
- 100+ avis
- 50 paiements

Bon développement! 🚀

---

## 🔍 Vérification Post-Partage

Demandez à votre ami de vérifier:

```bash
# Vérifier les conteneurs
docker ps
# Devrait afficher 5 conteneurs

# Tester MongoDB
docker exec mongodb-nosql mongosh -u admin -p admin123 --authenticationDatabase admin --eval "db = db.getSiblingDB('llm_nosql_db'); db.users.countDocuments()"
# Devrait retourner: 20

# Tester Redis
docker exec redis-nosql redis-cli DBSIZE
# Devrait retourner un nombre > 0
```

## ❓ Problèmes Courants

### "Docker n'est pas installé"
→ Installer Docker Desktop depuis https://www.docker.com/products/docker-desktop

### "Port déjà utilisé"
→ Arrêter les autres services utilisant les ports 6379, 27017, 9042, 7474, 7687, 3030

### "Cassandra ne démarre pas"
→ Attendre 30-60 secondes après `docker-compose up -d`

### "Fuseki ne charge pas les données"
→ Upload manuel requis via http://localhost:3030 (voir `SHARING_GUIDE.md`)

## 📧 Support

Si votre ami rencontre des problèmes:
1. Consulter `SHARING_GUIDE.md`
2. Vérifier que Docker Desktop est démarré
3. Vérifier les logs: `docker-compose logs`

