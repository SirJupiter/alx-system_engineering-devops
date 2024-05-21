#!/usr/bin/python3
"""script uses a REST API, for a given employee ID,
returns information about his/her TODO list progress."""

import requests
from sys import argv


if __name__ == "__main__":

    if argv[1]:
        api_user = f"https://jsonplaceholder.typicode.com/users/{argv[1]}"
        api_todo = "https://jsonplaceholder.typicode.com/todos"

        user_res = requests.get(api_user).json()
        todo_res = requests.get(api_todo, params={"userId": argv[1]}).json()

        name = user_res.get("name")
        total_tasks = len(todo_res)
        done_tasks = [
            task for task in todo_res if task.get("completed") is True]
        no_done_tasks = len(done_tasks)

        print(f"Employee {name} is done with "
              f"tasks({no_done_tasks}/{total_tasks}):")

        for task in done_tasks:
            print(f"\t {task.get('title')}")
