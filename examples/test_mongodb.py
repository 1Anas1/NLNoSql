#!/usr/bin/env python3
"""
MongoDB connection and query examples
Document Store testing
"""

from pymongo import MongoClient
from datetime import datetime

# Connect to MongoDB
client = MongoClient(
    'mongodb://admin:admin123@localhost:27017/',
    authSource='admin'
)
db = client['llm_nosql_db']

print("=== MongoDB Connection Test ===\n")

# Test connection
try:
    client.admin.command('ping')
    print("✓ Connected to MongoDB successfully\n")
except Exception as e:
    print(f"✗ Connection failed: {e}\n")
    exit(1)

# Example 1: Find users by city
print("Example 1: Find users by city")
users_paris = list(db.users.find({"city": "Paris"}))
print(f"Users in Paris: {len(users_paris)}")
for user in users_paris:
    print(f"  - {user['name']} ({user['email']})\n")

# Example 2: Find top posts by likes
print("Example 2: Top posts by likes")
top_posts = list(db.posts.find().sort("likes", -1).limit(3))
print("Top 3 posts:")
for post in top_posts:
    user = db.users.find_one({"_id": post["userId"]})
    print(f"  - {post['title']} by {user['name']} ({post['likes']} likes)\n")

# Example 3: Aggregation - Users by city
print("Example 3: Aggregation - Users by city")
city_stats = list(db.users.aggregate([
    {"$group": {"_id": "$city", "count": {"$sum": 1}, "avgScore": {"$avg": "$score"}}},
    {"$sort": {"count": -1}}
]))
print("Users by city:")
for stat in city_stats:
    print(f"  - {stat['_id']}: {stat['count']} users, avg score: {stat['avgScore']:.0f}\n")

# Example 4: Find posts with comments
print("Example 4: Posts with comments")
posts_with_comments = list(db.posts.find({"comments": {"$gt": 0}}).sort("comments", -1))
print("Posts with comments:")
for post in posts_with_comments:
    print(f"  - {post['title']}: {post['comments']} comments\n")

# Example 5: Join-like query (using aggregation)
print("Example 5: Posts with author information")
posts_with_authors = list(db.posts.aggregate([
    {
        "$lookup": {
            "from": "users",
            "localField": "userId",
            "foreignField": "_id",
            "as": "author"
        }
    },
    {"$unwind": "$author"},
    {"$project": {"title": 1, "likes": 1, "authorName": "$author.name", "authorCity": "$author.city"}}
]))
print("Posts with authors:")
for post in posts_with_authors:
    print(f"  - {post['title']} by {post['authorName']} from {post['authorCity']} ({post['likes']} likes)\n")

# Example 6: Text search (if text index exists)
print("Example 6: Find users with specific tags")
tech_users = list(db.users.find({"tags": {"$in": ["tech", "programming"]}}))
print("Users with tech/programming tags:")
for user in tech_users:
    print(f"  - {user['name']}: {', '.join(user['tags'])}\n")

print("=== MongoDB Tests Complete ===")
client.close()

