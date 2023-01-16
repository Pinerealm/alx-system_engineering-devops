#!/usr/bin/python3
"""Export data gathered from the REST API 'jsonplaceholder.typicode.com/'
about a given employee ID using the requests library to a CSV file."""
import csv
import requests
import sys


def export_data_to_csv():
    """Export the data to a CSV file after getting it"""

    url = 'https://jsonplaceholder.typicode.com/'
    user_id = sys.argv[1]
    user = requests.get(url + 'users/' + user_id).json()
    todos = requests.get(url + 'todos?userId=' + user_id).json()

    with open('{}.csv'.format(user_id), 'w') as csvfile:
        writer = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        for task in todos:
            writer.writerow([user_id, user.get('username'),
                             task.get('completed'), task.get('title')])


if __name__ == '__main__':
    export_data_to_csv()
