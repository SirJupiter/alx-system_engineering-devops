#!/usr/bin/python3
"""2-recurse.py"""

import requests


def recurse(subreddit, hot_list=[], after=None):
    """returns a list containing the titles of all hot articles for a given
    subreddit
    """
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/bdov_)"}
    params = {'limit': 100, 'after': after}

    try:
        response = requests.get(url, headers=headers, params=params)

        if response.status_code == 200:
            data = response.json()
            for post in data['data']['children']:
                hot_list.append(post['data']['title'])

            if data['data']['after']:
                return recurse(subreddit, hot_list, data['data']['after'])
            else:
                return hot_list
        else:
            return None

    except Exception:
        return None
