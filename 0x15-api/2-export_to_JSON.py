#!/usr/bin/python3
"""script exports data in the JSON format"""

import json
import requests
from sys import argv


if __name__ == "__main__":

    if argv[1]:
        api_user = f"https://jsonplaceholder.typicode.com/users/{argv[1]}"
        api_todo = "https://jsonplaceholder.typicode.com/todos"

        user_res = requests.get(api_user).json()
        todo_res = requests.get(api_todo, params={"userId": argv[1]}).json()

        name = user_res.get("username")

        the_tasks = [
            {
                "task": task.get('title'),
                "completed": task.get('completed'),
                "username": name
            } for task in todo_res
        ]

        task_obj = {f"{argv[1]}": the_tasks}

        with open(f"{argv[1]}.json", 'w') as file:
            json.dump(task_obj, file)
