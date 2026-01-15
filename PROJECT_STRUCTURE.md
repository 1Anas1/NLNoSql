# MultiLink Project Structure

## Clean Project Organization

```
projet/
├── databases/                    # All database configurations and initialization
│   ├── init/                     # Database initialization scripts
│   │   ├── mongodb-init.js       # MongoDB collections and data
│   │   ├── redis-init.sh         # Redis key-value data
│   │   ├── cassandra-init.cql    # Cassandra schema and data
│   │   ├── neo4j-init.cypher     # Neo4j graph data
│   │   ├── fuseki-init.ttl       # RDF/SPARQL data
│   │   ├── load-all.sh           # Load all databases (Linux/Mac)
│   │   ├── load-all.ps1          # Load all databases (Windows)
│   │   └── README.md             # Init scripts documentation
│   ├── config/                   # Database configurations
│   │   └── fuseki-config.ttl     # Fuseki server configuration
│   └── README.md                 # Databases documentation
│
├── src/                          # MultiLink source code
│   └── multilink/               # Main package
│       ├── __init__.py
│       ├── main.py               # Main entry point
│       ├── schema_extraction/   # Step 0: Schema inference
│       ├── intent_extraction/   # Step 2: NL to Intent
│       ├── linking/             # Step 3: Parallel linking
│       ├── query_planning/      # Step 4: Logical planning
│       ├── translation/         # Step 5: Engine translation
│       └── connectors/          # DB connectors
│           ├── __init__.py
│           └── base.py          # Base connector interface
│
├── tests/                        # Test suites (to be created)
├── docs/                         # Documentation
│   └── ARCHITECTURE.md          # System architecture
│
├── docker-compose.yml            # All databases orchestration
├── requirements.txt              # Python dependencies
├── .gitignore                   # Git ignore rules
├── README.md                     # Main project documentation
├── projet.md                     # Project specification (French)
└── PROJECT_STRUCTURE.md         # This file
```

## Key Files

### Database Files
- All database initialization scripts are in `databases/init/`
- All database configurations are in `databases/config/`
- `docker-compose.yml` references paths starting with `databases/`

### Source Code
- Main MultiLink implementation in `src/multilink/`
- Organized by pipeline steps (schema extraction, intent extraction, linking, planning, translation)
- Base connector interface for all database types

### Documentation
- `README.md` - Quick start and overview
- `docs/ARCHITECTURE.md` - System architecture details
- `projet.md` - Complete project specification
- `databases/README.md` - Database documentation

## Next Steps

1. **Remove old directories** (`init/`, `config/`, `scripts/`, `examples/`) if they still exist
2. **Implement MultiLink modules** in `src/multilink/`
3. **Add tests** in `tests/`
4. **Add more documentation** as needed

## Database Initialization

All databases are initialized with e-commerce platform data:
- Users, Products, Orders, Reviews, Payments, Categories, Cart Items

See `databases/init/README.md` for details.

