#!/usr/bin/env python3
"""
Apache Jena Fuseki connection and query examples
RDF Store / SPARQL testing
"""

from SPARQLWrapper import SPARQLWrapper, JSON

# Connect to Fuseki
sparql = SPARQLWrapper("http://localhost:3030/llm_nosql_dataset/query")
sparql.setReturnFormat(JSON)

print("=== Fuseki SPARQL Connection Test ===\n")

# Example 1: Get all users
print("Example 1: Get all users")
sparql.setQuery("""
    PREFIX ex: <http://example.org/social#>
    PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    
    SELECT ?name ?email ?city ?score
    WHERE {
        ?user a ex:User ;
              foaf:name ?name ;
              ex:hasEmail ?email ;
              ex:hasCity ?city ;
              ex:hasScore ?score .
    }
    ORDER BY DESC(?score)
""")

try:
    results = sparql.query().convert()
    print("Users:")
    for result in results["results"]["bindings"]:
        print(f"  - {result['name']['value']} ({result['email']['value']}) from {result['city']['value']}, score: {result['score']['value']}\n")
except Exception as e:
    print(f"✗ Query failed: {e}\n")

# Example 2: Find users and their posts
print("Example 2: Users and their posts")
sparql.setQuery("""
    PREFIX ex: <http://example.org/social#>
    PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    
    SELECT ?name ?title ?likes
    WHERE {
        ?user a ex:User ;
              foaf:name ?name ;
              ex:createdPost ?post .
        ?post a ex:Post ;
              ex:hasTitle ?title ;
              ex:hasLikes ?likes .
    }
    ORDER BY DESC(?likes)
""")

try:
    results = sparql.query().convert()
    print("Posts by users:")
    for result in results["results"]["bindings"]:
        print(f"  - {result['title']['value']} by {result['name']['value']} ({result['likes']['value']} likes)\n")
except Exception as e:
    print(f"✗ Query failed: {e}\n")

# Example 3: Find followers relationships
print("Example 3: Followers relationships")
sparql.setQuery("""
    PREFIX ex: <http://example.org/social#>
    PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    
    SELECT ?follower ?following
    WHERE {
        ?user1 a ex:User ;
               foaf:name ?follower ;
               ex:follows ?user2 .
        ?user2 a ex:User ;
               foaf:name ?following .
    }
""")

try:
    results = sparql.query().convert()
    print("Follow relationships:")
    for result in results["results"]["bindings"]:
        print(f"  - {result['follower']['value']} follows {result['following']['value']}\n")
except Exception as e:
    print(f"✗ Query failed: {e}\n")

# Example 4: Find posts liked by users
print("Example 4: Posts liked by users")
sparql.setQuery("""
    PREFIX ex: <http://example.org/social#>
    PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    
    SELECT ?name ?title
    WHERE {
        ?user a ex:User ;
              foaf:name ?name ;
              ex:liked ?post .
        ?post a ex:Post ;
              ex:hasTitle ?title .
    }
""")

try:
    results = sparql.query().convert()
    print("Posts liked by users:")
    for result in results["results"]["bindings"]:
        print(f"  - {result['name']['value']} liked: {result['title']['value']}\n")
except Exception as e:
    print(f"✗ Query failed: {e}\n")

# Example 5: Count users by city
print("Example 5: Count users by city")
sparql.setQuery("""
    PREFIX ex: <http://example.org/social#>
    
    SELECT ?city (COUNT(?user) AS ?count)
    WHERE {
        ?user a ex:User ;
              ex:hasCity ?city .
    }
    GROUP BY ?city
    ORDER BY DESC(?count)
""")

try:
    results = sparql.query().convert()
    print("Users by city:")
    for result in results["results"]["bindings"]:
        print(f"  - {result['city']['value']}: {result['count']['value']} users\n")
except Exception as e:
    print(f"✗ Query failed: {e}\n")

# Example 6: Find users with high scores
print("Example 6: Users with high scores")
sparql.setQuery("""
    PREFIX ex: <http://example.org/social#>
    PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    
    SELECT ?name ?score
    WHERE {
        ?user a ex:User ;
              foaf:name ?name ;
              ex:hasScore ?score .
        FILTER (?score > 800)
    }
    ORDER BY DESC(?score)
""")

try:
    results = sparql.query().convert()
    print("Users with score > 800:")
    for result in results["results"]["bindings"]:
        print(f"  - {result['name']['value']}: {result['score']['value']} points\n")
except Exception as e:
    print(f"✗ Query failed: {e}\n")

print("=== Fuseki SPARQL Tests Complete ===")

