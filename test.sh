#!/bin/bash

GITHUB_USERNAME="kazet"
GITHUB_REPO="wpgarlic"
REMOTE_URL="https://github.com/$GITHUB_USERNAME/$GITHUB_REPO.git"

# Step 1: Clone the repository
if [ ! -d "$GITHUB_REPO" ]; then
    git clone "$REMOTE_URL"
    if [ $? -eq 0 ]; then
        echo "Command 'git clone' finished successfully."
    else
        echo "Command 'git clone' failed with exit code $?."
        exit 1
    fi
fi

# Step 2: Navigate into the cloned repository
cd "$GITHUB_REPO" || exit 1

if [ ! -e venv ]; then
    python3 -m venv venv
fi

. venv/bin/activate

pip install --quiet -r requirements.txt

# Step 6: Fuzz WordPress plugin
./bin/fuzz_object plugin responsive-vector-maps --version 6.4.0
if [ $? -eq 0 ]; then
    echo "Command './bin/fuzz_object plugin responsive-vector-maps --version 6.4.0' finished successfully."
else
    echo "Command './bin/fuzz_object plugin responsive-vector-maps --version 6.4.0' failed with exit code $?."
    exit 1
fi

# Deactivate the virtual environment
deactivate
