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

# Step 3: Run pip install requirements
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
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


# Step 4:  Fuzz wordpress plugin
run_fuzz_object() {
    ./bin/fuzz_object plugin responsive-vector-maps --version 6.4.0
    if [ $? -eq 0 ]; then
        echo "Command './bin/fuzz_object plugin responsive-vector-maps --version 6.4.0' finished successfully."
    else
        echo "Command './bin/fuzz_object plugin responsive-vector-maps --version 6.4.0' failed with exit code $?."
        exit 1
    fi
}

# Run the fuzz_object command
run_fuzz_object



