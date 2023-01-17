#!/usr/bin/python3
"""Record all tasks from all employees using the REST API
'jsonplaceholder.typicode.com/' into a JSON file."""
import json
import requests


def export_all_data_to_json():
    """Export all the data to a JSON file after getting it"""

    url = 'https://jsonplaceholder.typicode.com/'
    users = requests.get(url + 'users').json()
    todos = requests.get(url + 'todos').json()

    tasks = {}
    for user in users:
        tasks[user.get('id')] = []
        for task in todos:
            if task.get('userId') == user.get('id'):
                tasks[user.get('id')]\
                    .append({'task': task.get('title'),
                             'completed': task.get('completed'),
                             'username': user.get('username')})

    with open('todo_all_employees.json', 'w') as jsonfile:
        json.dump(tasks, jsonfile)


if __name__ == '__main__':
    export_all_data_to_json()
