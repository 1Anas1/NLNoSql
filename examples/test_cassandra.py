#!/usr/bin/env python3
"""
Cassandra connection and query examples
Wide-Column Store testing
"""

from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider
from uuid import uuid4

# Connect to Cassandra
cluster = Cluster(['localhost'], port=9042)
session = cluster.connect()

print("=== Cassandra Connection Test ===\n")

# Test connection
try:
    session.execute("SELECT release_version FROM system.local")
    print("✓ Connected to Cassandra successfully\n")
except Exception as e:
    print(f"✗ Connection failed: {e}\n")
    exit(1)

# Use keyspace
session.set_keyspace('llm_nosql_keyspace')

# Example 1: Get all users
print("Example 1: Get all users")
rows = session.execute("SELECT user_id, name, email, city FROM users")
print("Users:")
for row in rows:
    print(f"  - {row.name} ({row.email}) from {row.city}\n")

# Example 2: Get posts by user (using clustering key)
print("Example 2: Get posts by user")
# First, get a user_id
user_rows = session.execute("SELECT user_id FROM users LIMIT 1")
if user_rows:
    user_id = user_rows[0].user_id
    print(f"Fetching posts for user_id: {user_id}")
    post_rows = session.execute(
        "SELECT post_id, title, created_at FROM posts_by_user WHERE user_id = ? ORDER BY created_at DESC",
        [user_id]
    )
    print("Posts:")
    for row in post_rows:
        print(f"  - {row.title} (created: {row.created_at})\n")

# Example 3: Insert a new user
print("Example 3: Insert a new user")
new_user_id = uuid4()
session.execute(
    """
    INSERT INTO users (user_id, name, email, age, city, bio, created_at, tags)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """,
    [new_user_id, "Diana Prince", "diana@example.com", 30, "Athens", "Developer", "2024-01-26", {"tech", "devops"}]
)
print(f"✓ Inserted user: Diana Prince (ID: {new_user_id})\n")

# Example 4: Query with WHERE clause
print("Example 4: Find users by city")
rows = session.execute("SELECT name, city FROM users WHERE city = ? ALLOW FILTERING", ["Paris"])
print("Users in Paris:")
for row in rows:
    print(f"  - {row.name}\n")

# Example 5: Count users
print("Example 5: Count users")
count_row = session.execute("SELECT COUNT(*) as count FROM users").one()
print(f"Total users: {count_row.count}\n")

# Example 6: Get table schema
print("Example 6: Get table schema")
rows = session.execute(
    "SELECT column_name, type FROM system_schema.columns WHERE keyspace_name = ? AND table_name = ?",
    ['llm_nosql_keyspace', 'users']
)
print("Users table schema:")
for row in rows:
    print(f"  - {row.column_name}: {row.type}\n")

print("=== Cassandra Tests Complete ===")
cluster.shutdown()

