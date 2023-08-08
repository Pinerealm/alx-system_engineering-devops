#!/usr/bin/python3
"""The 1-top_ten module"""
import requests


def top_ten(subreddit):
    """Prints the titles of the top ten hot posts for a given subreddit
    """
    url = "https://www.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    headers = {"User-Agent": "ALX-User"}
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code != 200:
        print("None")
        return
    for post in response.json().get("data").get("children"):
        print(post.get("data").get("title"))
