#!/usr/bin/python3
"""The 100-count module"""
import requests


def count_words(subreddit, word_list, after="", word_dict={}):
    """Parses the title of all hot articles, and prints a sorted count of
    given keywords
    """
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    params = {"limit": 100, "after": after}
    headers = {"User-Agent": "ALX-User"}
    response = requests.get(url, params=params, headers=headers,
                            allow_redirects=False)
    if response.status_code != 200:
        return None

    for post in response.json().get("data").get("children"):
        title = post.get("data").get("title").lower().split()
        for word in word_list:
            word = word.lower()
            if word in title:
                word_dict[word] = word_dict.get(word, 0) + 1

    after = response.json().get("data").get("after")
    if after is None:
        if len(word_dict) == 0:
            return
        for key, value in sorted(word_dict.items(),
                                 key=lambda item: item[1], reverse=True):
            print("{}: {}".format(key, value))
        return word_dict
    return count_words(subreddit, word_list, after, word_dict)
