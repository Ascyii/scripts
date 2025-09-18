#!/bin/sh

# Read the list of Git repositories from /tmp/all_git_projects
repos=$(cat /tmp/all_git_projects)

# Function to handle each repository
sync_repo() {
	repo=$1
	if [ -d "$HOME/$repo" ]; then
		cd "$HOME/$repo" || return

		if [ -d ".git" ]; then
			git add .
			remote_count=$(git remote -v | wc -l)
			status_output=$(git status --short)

			if [ -n "$status_output" ]; then
				echo "Status for: $repo"
				echo "$status_output"

				if git rev-parse --verify HEAD >/dev/null 2>&1; then
					last_msg=$(git log -1 --pretty=%B)

					# Use rg to check for `+ auto` at the end
					if printf "%s" "$last_msg" | rg '\+ auto$' >/dev/null; then
						amend_output=$(git commit --amend --no-edit 2>&1)
					else
						new_msg="${last_msg} + auto"
						amend_output=$(git commit --amend -m "$new_msg" 2>&1)
					fi

					echo "Amended last commit for $repo: $amend_output"
				else
					commit_output=$(git commit -m 'auto + auto' 2>&1)
					echo "Initial commit for $repo: $commit_output"
				fi
			fi

			if [ "$remote_count" -gt 0 ]; then
				fetch_output=$(git fetch --all 2>&1)
				pull_output=$(git pull 2>&1)
				push_output=$(git push 2>&1)
				if [ -n "$fetch_output" ]; then
					echo "Fetching updates for $repo: $fetch_output"
				fi
				if [ "$pull_output" != "Already up to date." ]; then
					echo "Pulling changes for $repo: $pull_output"
				fi
				if [ "$push_output" != "Everything up-to-date" ]; then
					echo "Pushing changes to remote for $repo: $push_output"
				fi
			fi
		fi
	fi
}

for repo in $repos; do
	basename_repo=$(basename "$repo")
	case "$basename_repo" in
	r_*) continue ;;
	esac
	sync_repo "$repo" &
done

wait

echo "Sync completed for all repositories."
