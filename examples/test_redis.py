#!/usr/bin/env python3
"""
Redis connection and query examples
Key-Value Store testing
"""

import redis

# Connect to Redis
r = redis.Redis(host='localhost', port=6379, decode_responses=True)

print("=== Redis Connection Test ===\n")

# Test connection
try:
    r.ping()
    print("✓ Connected to Redis successfully\n")
except Exception as e:
    print(f"✗ Connection failed: {e}\n")
    exit(1)

# Example 1: Get user name
print("Example 1: Get user name")
name = r.get("user:123:name")
print(f"User 123 name: {name}\n")

# Example 2: Get user profile (hash)
print("Example 2: Get user profile")
profile = r.hgetall("user:123:profile")
print(f"User 123 profile: {profile}\n")

# Example 3: Get top users by score (sorted set)
print("Example 3: Top users by score")
top_scores = r.zrevrange("leaderboard:score", 0, 2, withscores=True)
print("Top 3 users by score:")
for user_id, score in top_scores:
    name = r.get(f"{user_id}:name")
    print(f"  {name}: {score} points\n")

# Example 4: Get followers (set)
print("Example 4: Get followers")
followers = r.smembers("followers:user:123")
print(f"User 123 followers: {followers}\n")

# Example 5: Get activity feed (list)
print("Example 5: Get activity feed")
feed = r.lrange("feed:user:123", 0, -1)
print(f"User 123 activity feed: {feed}\n")

# Example 6: Increment views
print("Example 6: Increment views")
views_before = r.get("user:123:views")
r.incr("user:123:views")
views_after = r.get("user:123:views")
print(f"User 123 views: {views_before} → {views_after}\n")

print("=== Redis Tests Complete ===")

