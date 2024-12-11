#!/bin/bash

# Exit on errors
set -e

# Variables (Replace with your details)
GITHUB_USERNAME="WackyDawg"
GITHUB_EMAIL="juliannwadinobi@gmail.com"
GITHUB_REPO="bash-script-test"
REMOTE_URL="git@github.com:$GITHUB_USERNAME/$GITHUB_REPO.git"
REPO_DIR="$GITHUB_REPO"  # The directory where the repo will be cloned

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Please install Git and try again."
    exit 1
fi

# Step 1: Clone the repository
if [ ! -d "$REPO_DIR" ]; then
    git clone "$REMOTE_URL"
    if [ $? -eq 0 ]; then
        echo "Repository cloned successfully."
    else
        echo "Failed to clone repository."
        exit 1
    fi
else
    echo "Repository already exists. Pulling latest changes."
    cd "$REPO_DIR"
    git pull origin main
    if [ $? -eq 0 ]; then
        echo "Pulled latest changes successfully."
    else
        echo "Failed to pull latest changes."
        exit 1
    fi
fi

# Change to the repo directory
cd "$REPO_DIR"

# Set GitHub user and email
git config user.name "$GITHUB_USERNAME"
git config user.email "$GITHUB_EMAIL"

# Step 2: Create a new file
echo "This is a new file." > newfile.txt
git add newfile.txt

# Commit changes
git commit -m "Added new file"

# Push to GitHub
git branch -M main
git push origin main

# Success message
echo "New file 'newfile.txt' added and pushed to repository '$GITHUB_REPO'."
