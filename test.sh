#!/bin/bash

# Exit on errors
set -e

# Variables (Replace with your details)
GITHUB_USERNAME="WackyDawg"
GITHUB_EMAIL="juliannwadinobi098@gmail.com"
GITHUB_REPO="bash-script-test"
REMOTE_URL="git@github.com:$GITHUB_USERNAME/$GITHUB_REPO.git"
FOLDER_TO_PUSH="test-folder"  # Folder to create and push

# Step 1: Create a test folder
if [ ! -d "$FOLDER_TO_PUSH" ]; then
    mkdir "$FOLDER_TO_PUSH"
    if [ $? -eq 0 ]; then
        echo "Command 'mkdir $FOLDER_TO_PUSH' finished successfully."
    else
        echo "Command 'mkdir $FOLDER_TO_PUSH' failed with exit code $?."
        exit 1
    fi
fi

# Navigate to the folder to push
cd "$FOLDER_TO_PUSH"
if [ $? -eq 0 ]; then
    echo "Command 'Navigate to folder $FOLDER_TO_PUSH' finished successfully."
else
    echo "Command 'Navigate to folder $FOLDER_TO_PUSH' failed with exit code $?."
    exit 1
fi

# Step 2: Initialize Git repository
if [ ! -d ".git" ]; then
    git init
    if [ $? -eq 0 ]; then
        echo "Command 'git init' finished successfully."
    else
        echo "Command 'git init' failed with exit code $?."
        exit 1
    fi
fi

# Step 3: Configure GitHub user and email
git config user.name "$GITHUB_USERNAME"
if [ $? -eq 0 ]; then
    echo "Command 'git config user.name' finished successfully."
else
    echo "Command 'git config user.name' failed with exit code $?."
    exit 1
fi

git config user.email "$GITHUB_EMAIL"
if [ $? -eq 0 ]; then
    echo "Command 'git config user.email' finished successfully."
else
    echo "Command 'git config user.email' failed with exit code $?."
    exit 1
fi

# Step 4: Add a README file
if [ ! -f "README.md" ]; then
    echo "# $GITHUB_REPO" > README.md
    git add README.md
    if [ $? -eq 0 ]; then
        echo "Command 'git add README.md' finished successfully."
    else
        echo "Command 'git add README.md' failed with exit code $?."
        exit 1
    fi
fi

# Step 5: Stage all files
git add .
if [ $? -eq 0 ]; then
    echo "Command 'git add .' finished successfully."
else
    echo "Command 'git add .' failed with exit code $?."
    exit 1
fi

# Step 6: Commit changes
git commit -m "Initial commit"
if [ $? -eq 0 ]; then
    echo "Command 'git commit' finished successfully."
else
    echo "Command 'git commit' failed with exit code $?."
    exit 1
fi

# Step 7: Add remote repository
git remote add origin "$REMOTE_URL" || git remote set-url origin "$REMOTE_URL"
if [ $? -eq 0 ]; then
    echo "Command 'git remote add/set-url' finished successfully."
else
    echo "Command 'git remote add/set-url' failed with exit code $?."
    exit 1
fi

# Step 8: Push to GitHub
git branch -M main
if [ $? -eq 0 ]; then
    echo "Command 'git branch -M main' finished successfully."
else
    echo "Command 'git branch -M main' failed with exit code $?."
    exit 1
fi

git push -u origin main
if [ $? -eq 0 ]; then
    echo "Command 'git push -u origin main' finished successfully."
else
    echo "Command 'git push -u origin main' failed with exit code $?."
    exit 1
fi

# Success message
echo "Test folder '$FOLDER_TO_PUSH' has been successfully pushed to GitHub repository '$GITHUB_REPO'."
