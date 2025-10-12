#!/usr/bin/env python3

import subprocess
import sys


def get_commit_messages(present_in_branch, absent_in_branch):
    cmd = f"git log {present_in_branch} ^{absent_in_branch} --pretty=format:%s"
    result = subprocess.run(cmd, shell=True, text=True, capture_output=True)

    if result.returncode != 0:
        print(f"Error when running git log: {result.stderr}")
        sys.exit(1)

    return [line for line in result.stdout.splitlines() if line]


def get_unique_commits(branch1, branch2):
    branch1_unique_messages = get_commit_messages(branch1, branch2)
    branch2_unique_messages = get_commit_messages(branch2, branch1)

    # this is needed because there are commits with different hashes but same messages
    unique_commits = [
        line for line in branch1_unique_messages if line not in branch2_unique_messages
    ]
    return unique_commits


def main():
    if len(sys.argv) != 3:
        print("Usage: python3 compare_branches.py <branch1> <branch2>")
        sys.exit(1)

    branch1 = sys.argv[1]
    branch2 = sys.argv[2]

    commits = get_unique_commits(branch1, branch2)

    if commits:
        print(
            f"\nCommits in {branch1} not in {branch2} (unique by first line of commit message):\n"
        )
        for commit in commits:
            print(commit)
    else:
        print(f"No unique commits in {branch1} that are not in {branch2}.")


if __name__ == "__main__":
    main()
