#!/usr/bin/python3
"""script exports data in the JSON format"""

import json
import requests


if __name__ == "__main__":

    api_user = "https://jsonplaceholder.typicode.com/users"
    api_todo = "https://jsonplaceholder.typicode.com/todos"

    user_res = requests.get(api_user).json()

    # Testing to see what is in user_res
    # for user in user_res:
    #     print(user)

    task_obj = {}
    for user in user_res:
        user_id = user.get("id")
        username = user.get("username")

        todo_res = requests.get(api_todo, params={"userId": user_id}).json()

        the_tasks = [
            {
                "username": username,
                "task": task.get('title'),
                "completed": task.get('completed'),
            } for task in todo_res
        ]

        task_obj[f"{user_id}"] = the_tasks

    with open("todo_all_employees.json", 'w') as file:
        json.dump(task_obj, file)
