#!/usr/bin/python3
"""1-top_ten.py"""

import requests


def top_ten(subreddit):
    """returns the top 10 hot posts of a subreddit"""
    url = "https://www.reddit.com/r/{}/hot/.json".format(subreddit)
    headers = {"User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/bdov_)"}

    try:
        response = requests.get(url, headers=headers)

        if response.status_code == 200:
            data = response.json()
            for post in data['data']['children']:
                print(post['data']['title'])

    except Exception:
        return None
