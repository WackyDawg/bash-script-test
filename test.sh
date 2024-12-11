#!/bin/bash

GITHUB_USERNAME="kazet"
GITHUB_REPO="wpgarlic"
REMOTE_URL="https://github.com/$GITHUB_USERNAME/$GITHUB_REPO.git"

# Step 6: Start a local server
echo "Starting a local server..."
python3 -m http.server 8000 --bind 0.0.0.0
if [ $? -eq 0 ]; then
    echo "Local server started successfully at http://localhost:8000"
else
    echo "Failed to start the local server."
    exit 1
fi

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

# Step 3: Create and activate a virtual environment
if [ ! -e venv ]; then
    python3 -m venv venv
    if [ $? -eq 0 ]; then
        echo "Virtual environment 'venv' created successfully."
    else
        echo "Failed to create virtual environment 'venv'."
        exit 1
    fi
fi

# Activate the virtual environment
. venv/bin/activate
if [ $? -eq 0 ]; then
    echo "Virtual environment activated."
else
    echo "Failed to activate the virtual environment."
    exit 1
fi

# Step 4: Install Python requirements inside the virtual environment
if [ -f "requirements.txt" ]; then
    pip install --quiet --upgrade pip
    pip install --quiet -r requirements.txt
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
