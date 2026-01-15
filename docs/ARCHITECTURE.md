# MultiLink Architecture

## Pipeline Overview

```
Natural Language Query
    ↓
[Step 0] Schema Extraction → RAG Schema
    ↓
[Step 1] NL Query Input
    ↓
[Step 2] Intent Extraction → Structured Intent
    ↓
[Step 3] Parallel Linking → Linked Intent
    ↓
[Step 4] Query Planning → Logical Query Plan
    ↓
[Step 5] Query Translation → Engine-Specific Query
    ↓
Execution → Results
```

## Module Structure

### schema_extraction/
- Extract implicit schemas from NoSQL databases
- Sample documents, infer structure, enrich semantically
- Generate RAG-ready schema representations

### intent_extraction/
- Parse NL queries into structured intents
- Schema-agnostic LLM-based parsing
- Multilingual support

### linking/
- **Lexical Linking**: String similarity matching
- **Semantic Linking**: Embedding-based matching
- **Structural Linking**: Schema-aware validation
- Score fusion and field selection

### query_planning/
- Generate DB-agnostic logical query plans
- LLM-guided planning with constraints
- Operation ordering and validation

### translation/
- Translate logical plans to engine-specific queries
- MongoDB, Redis, Cassandra, Neo4j, Fuseki translators
- Syntax validation and error handling

### connectors/
- Database connection interfaces
- Query execution wrappers
- Schema introspection utilities

## Database Support

| Engine | Query Language | Translator |
|--------|---------------|------------|
| MongoDB | Aggregation Pipeline | `MongoDBTranslator` |
| Redis | Commands/RediSearch | `RedisTranslator` |
| Cassandra | CQL | `CassandraTranslator` |
| Neo4j | Cypher | `Neo4jTranslator` |
| Fuseki | SPARQL | `FusekiTranslator` |

