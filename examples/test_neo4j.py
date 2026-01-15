#!/usr/bin/env python3
"""
Neo4j connection and query examples
Graph Database testing
"""

from neo4j import GraphDatabase

# Connect to Neo4j
driver = GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "neo4j123"))

print("=== Neo4j Connection Test ===\n")

# Test connection
try:
    driver.verify_connectivity()
    print("✓ Connected to Neo4j successfully\n")
except Exception as e:
    print(f"✗ Connection failed: {e}\n")
    exit(1)

# Example 1: Find all users
print("Example 1: Find all users")
with driver.session() as session:
    result = session.run("MATCH (u:User) RETURN u.name AS name, u.email AS email, u.city AS city")
    print("Users:")
    for record in result:
        print(f"  - {record['name']} ({record['email']}) from {record['city']}\n")

# Example 2: Find users and their posts
print("Example 2: Users and their posts")
with driver.session() as session:
    result = session.run("""
        MATCH (u:User)-[:POSTED]->(p:Post)
        RETURN u.name AS author, p.title AS title, p.likes AS likes
        ORDER BY p.likes DESC
    """)
    print("Posts by users:")
    for record in result:
        print(f"  - {record['title']} by {record['author']} ({record['likes']} likes)\n")

# Example 3: Find followers relationships
print("Example 3: Followers relationships")
with driver.session() as session:
    result = session.run("""
        MATCH (u1:User)-[r:FOLLOWS]->(u2:User)
        RETURN u1.name AS follower, u2.name AS following
    """)
    print("Follow relationships:")
    for record in result:
        print(f"  - {record['follower']} follows {record['following']}\n")

# Example 4: Find mutual followers (friends of friends)
print("Example 4: Mutual connections (friends of friends)")
with driver.session() as session:
    result = session.run("""
        MATCH (u1:User)-[:FOLLOWS]->(u2:User)-[:FOLLOWS]->(u3:User)
        WHERE u1 <> u3
        RETURN DISTINCT u1.name AS user1, u3.name AS user2
    """)
    print("Mutual connections:")
    for record in result:
        print(f"  - {record['user1']} and {record['user2']} have mutual connections\n")

# Example 5: Find posts liked by a user's followers
print("Example 5: Posts liked by user's followers")
with driver.session() as session:
    result = session.run("""
        MATCH (u:User {name: 'Alice Johnson'})-[:FOLLOWS]->(follower:User)-[:LIKED]->(p:Post)
        RETURN DISTINCT follower.name AS follower, p.title AS post
    """)
    print("Posts liked by Alice's followers:")
    for record in result:
        print(f"  - {record['follower']} liked: {record['post']}\n")

# Example 6: Shortest path between users
print("Example 6: Shortest path between users")
with driver.session() as session:
    result = session.run("""
        MATCH path = shortestPath(
            (u1:User {name: 'Alice Johnson'})-[*]-(u2:User {name: 'Charlie Brown'})
        )
        RETURN path
    """)
    print("Shortest path from Alice to Charlie:")
    for record in result:
        path = record['path']
        print(f"  Path length: {len(path.relationships)}\n")

# Example 7: Get user statistics
print("Example 7: User statistics")
with driver.session() as session:
    result = session.run("""
        MATCH (u:User)
        OPTIONAL MATCH (u)-[:POSTED]->(p:Post)
        OPTIONAL MATCH (u)-[:FOLLOWS]->(f:User)
        RETURN u.name AS name, 
               COUNT(DISTINCT p) AS posts,
               COUNT(DISTINCT f) AS following
    """)
    print("User statistics:")
    for record in result:
        print(f"  - {record['name']}: {record['posts']} posts, following {record['following']} users\n")

print("=== Neo4j Tests Complete ===")
driver.close()

