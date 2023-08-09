#!/usr/bin/python3
"""The 2-recurse module"""
import requests


def recurse(subreddit, hot_list=[], after=""):
    """Returns recursively a list of all hot posts for a given subreddit
    """
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    params = {"limit": 100, "after": after}
    headers = {"User-Agent": "ALX-User"}
    response = requests.get(url, params=params, headers=headers,
                            allow_redirects=False)
    if response.status_code != 200:
        return None
    for post in response.json().get("data").get("children"):
        hot_list.append(post.get("data").get("title"))

    after = response.json().get("data").get("after")
    if after is None:
        return hot_list
    return recurse(subreddit, hot_list, after)
