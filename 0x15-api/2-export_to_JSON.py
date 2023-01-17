#!/usr/bin/python3
"""Export data gathered from the REST API 'jsonplaceholder.typicode.com/'
about a given employee ID using the requests library to a JSON file."""
import json
import requests
import sys


def export_data_to_json():
    """Export the data to a JSON file after getting it"""

    url = 'https://jsonplaceholder.typicode.com/'
    user_id = sys.argv[1]
    user = requests.get(url + 'users/' + user_id).json()
    todos = requests.get(url + 'todos?userId=' + user_id).json()

    tasks = []
    for task in todos:
        tasks.append({'task': task.get('title'),
                      'completed': task.get('completed'),
                      'username': user.get('username')})

    with open('{}.json'.format(user_id), 'w') as jsonfile:
        json.dump({user_id: tasks}, jsonfile)


if __name__ == '__main__':
    export_data_to_json()
