#!/bin/bash

# Exit on errors
set -e

# Variables (Replace with your details)
GITHUB_USERNAME="WackyDawg"
GITHUB_EMAIL="juliannwadinobi@gmail.com"
GITHUB_REPO="bash-script-test"
REMOTE_URL="git@github.com:$GITHUB_USERNAME/$GITHUB_REPO.git"
FOLDER_TO_PUSH="path/to/your/folder"  # Replace with the folder you want to push

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Please install Git and try again."
    exit 1
fi

# Navigate to the folder to push
if [ ! -d "$FOLDER_TO_PUSH" ]; then
  echo "The folder '$FOLDER_TO_PUSH' does not exist. Please check the path."
  exit 1
fi
cd "$FOLDER_TO_PUSH"

# Initialize Git repository
if [ ! -d ".git" ]; then
  git init
fi

# Set GitHub user and email
git config user.name "$GITHUB_USERNAME"
git config user.email "$GITHUB_EMAIL"

# Add a README file if it doesn't exist
if [ ! -f "README.md" ]; then
  echo "# $GITHUB_REPO" > README.md
  git add README.md
fi

# Stage all files
git add .

# Commit changes
git commit -m "Initial commit"

# Add remote repository
git remote add origin "$REMOTE_URL" || git remote set-url origin "$REMOTE_URL"

# Push to GitHub
git branch -M main
git push -u origin main

# Success message
echo "Folder '$F
