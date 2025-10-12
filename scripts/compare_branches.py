#!/usr/bin/env python3

import subprocess
import sys


def get_commit_messages(branch):
    # Get all commit messages (first lines) for the given branch
    cmd = f"git log {branch} --pretty=format:%s"
    result = subprocess.run(cmd, shell=True, text=True, capture_output=True)

    if result.returncode != 0:
        print(f"Error: {result.stderr}")
        sys.exit(1)

    return set(line for line in result.stdout.splitlines() if line)


def get_unique_commits(branch1, branch2):
    # Get commits in branch1 not in branch2
    cmd = f"git log {branch1} ^{branch2} --pretty=format:%s"
    result = subprocess.run(cmd, shell=True, text=True, capture_output=True)

    if result.returncode != 0:
        print(f"Error: {result.stderr}")
        sys.exit(1)

    # Get all first lines from branch1 not in branch2
    branch1_unique_lines = [line for line in result.stdout.splitlines() if line]

    # Get all first lines from branch2
    branch2_messages = get_commit_messages(branch2)

    # Filter out lines from branch1 that also appear in branch2
    unique_commits = [
        line for line in branch1_unique_lines if line not in branch2_messages
    ]
    return unique_commits


def main():
    if len(sys.argv) != 3:
        print("Usage: python compare_branches.py <branch1> <branch2>")
        sys.exit(1)

    branch1 = sys.argv[1]
    branch2 = sys.argv[2]

    commits = get_unique_commits(branch1, branch2)

    if commits:
        print(f"Commits in {branch1} not in {branch2} (unique by first line):")
        for commit in commits:
            print(commit)
    else:
        print(f"No unique commits in {branch1} that are not in {branch2}.")


if __name__ == "__main__":
    main()

