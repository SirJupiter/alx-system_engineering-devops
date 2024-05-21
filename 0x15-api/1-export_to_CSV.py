#!/usr/bin/python3
"""script exports data in the CSV format"""

import csv
import requests
from sys import argv


if __name__ == "__main__":

    if argv[1]:
        api_user = f"https://jsonplaceholder.typicode.com/users/{argv[1]}"
        api_todo = "https://jsonplaceholder.typicode.com/todos"

        user_res = requests.get(api_user).json()
        todo_res = requests.get(api_todo, params={"userId": argv[1]}).json()

        # print(user_res)
        name = user_res.get("username")

        # for todo in todo_res:
        #     print(todo.get('userId'), todo.get('username'),
        #           todo.get('completed'), todo.get('title'))

        task_titles = [
            [task.get('userId'),
             name,
             task.get('completed'),
             task.get('title')]
            for task in todo_res
        ]

        with open(f"{argv[1]}.csv", 'w') as file:
            writer = csv.writer(file, quoting=csv.QUOTE_ALL)

            for row in task_titles:
                writer.writerow(row)
