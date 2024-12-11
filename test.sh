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

# Step 3: Create a virtual environment
if [ ! -d "venv" ]; then
    python3 -m venv venv
    if [ $? -eq 0 ]; then
        echo "Virtual environment 'venv' created successfully."
    else
        echo "Failed to create virtual environment 'venv'."
        exit 1
    fi
fi

# Step 4: Activate the virtual environment
# shellcheck disable=SC1091
source venv/bin/activate

# Step 5: Upgrade pip and install Python requirements inside the virtual environment
if [ -f "requirements.txt" ]; then
    pip install --upgrade pip
    pip install --upgrade setuptools
    pip install -r requirements.txt --break-system-packages
    if [ $? -eq 0 ]; then
        echo "Command 'pip install -r requirements.txt' finished successfully."
    else
        echo "Command 'pip install -r requirements.txt' failed with exit code $?."
        exit 1
    fi
else
    echo "'requirements.txt' not found. Please make sure the file exists in the current directory."
    exit 1
fi

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
