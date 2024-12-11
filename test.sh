#!/bin/bash

# Telegram Bot API Token
TOKEN="6766505665:AAEs3Y_PtHdjryOrFHcvL-g7MLTETxnyiKI"

# Function to create hello.txt file
create_file() {
  echo "Hello, this is a message from your Telegram bot!" > hello.txt
  echo "File hello.txt created."
}

# Use getUpdates API to retrieve chat_id from recent messages
CHAT_ID=$(curl -s "https://api.telegram.org/bot$TOKEN/getUpdates" | jq -r '.result[0].message.chat.id')

# Call the function to create the file
create_file

# Path to the file you want to send
FILE_PATH="hello.txt"

# Send the file to the retrieved chat_id using the Telegram Bot API
curl -X POST "https://api.telegram.org/bot$TOKEN/sendDocument" \
     -F chat_id="$CHAT_ID" \
     -F document=@"$FILE_PATH"

# Clean up the hello.txt file after sending it
rm hello.txt
