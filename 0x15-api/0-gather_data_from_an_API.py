#!/usr/bin/python3
"""Get data from the REST API 'jsonplaceholder.typicode.com/'
about a given employee ID using the requests library.
"""
import requests
import sys


def get_data():
    """Get and display the data"""

    url = 'https://jsonplaceholder.typicode.com/'
    user_id = sys.argv[1]
    user = requests.get(url + 'users/' + user_id).json()
    todos = requests.get(url + 'todos?userId=' + user_id).json()

    tasks = []
    for task in todos:
        if task.get('completed') is True:
            tasks.append(task.get('title'))

    print('Employee {} is done with tasks({}/{}):'.format(
        user.get('name'), len(tasks), len(todos)))
    for task in tasks:
        print('\t {}'.format(task))


if __name__ == '__main__':
    get_data()
