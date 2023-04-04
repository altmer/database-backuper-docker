#!/bin/bash

/usr/bin/curl -X POST -d "{\"text\": \"$1\", \"chat_id\": \"$TELEGRAM_BOT_CHAT_ID\"}" -H "Content-Type: application/json" https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage
