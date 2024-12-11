#!/bin/bash

# Telegram Bot API Token and Chat ID
TOKEN="your_telegram_bot_token"
CHAT_ID="your_chat_id"

# Path to the file you want to send
FILE_PATH="/path/to/your/file"

# Send the file using Telegram Bot API
curl -X POST "https://api.telegram.org/bot$TOKEN/sendDocument" \
     -F chat_id="$CHAT_ID" \
     -F document=@"$FILE_PATH"
