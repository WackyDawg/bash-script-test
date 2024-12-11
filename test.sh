#!/bin/bash

# Run a command
echo "Running the command..."
ls -la

# Check the exit status
if [ $? -eq 0 ]; then
    echo "Command finished successfully."
else
    echo "Command failed with exit code $?."
fi
