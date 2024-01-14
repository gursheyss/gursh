#!/bin/bash

if [ "$1" = "download" ] && [ "$2" = "kick" ] && [ -n "$3" ] && [ -n "$4" ]; then
    URL=$3
    DEST_PATH=$4
    ID=$(basename $URL)

    echo "ID: $ID"

    API_URL="https://kick.com/api/v1/video/$ID"

    RESPONSE=$(curl --request GET --header 'Content-Type: application/json' -A "Mozilla/5.0 (X11; Linux x86_64; rv:120.0) Gecko/20100101 Firefox/120.0" $API_URL)
    echo "Response: $RESPONSE"

    SOURCE_URL=$(echo $RESPONSE | jq -r '.source')
    echo "Source URL: $SOURCE_URL"

    if [ -f "$DEST_PATH/$ID" ]; then
        rm "$DEST_PATH/$ID"
    fi

    yt-dlp -o "$DEST_PATH/$ID" $SOURCE_URL
else
    echo "Usage: gursh download kick <URL> <DEST_PATH>"
fi