#!/bin/sh

# If a command fails then the deploy stops
hugo -D

set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -t hermit # if using a theme, replace with `hugo -t <YOURTHEME>`

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

# Add changes to git.
git add .

git commit -m "$msg"

# Push source and build repos.
git push origin master

# Go To Public folder
cd public

# Add changes to git.
git add .

git commit -m "$msg"

# Push source and build repos.
git push origin master