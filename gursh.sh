#!/bin/bash

if [ "$1" = "create" ] && [ -n "$2" ]; then
    REPO_NAME=$2
    REPO_PATH=~/Code/$REPO_NAME

    if [ -d "$REPO_PATH" ]; then
        echo "Repo already exists at $REPO_PATH"
    else
        mkdir -p $REPO_PATH
        cd $REPO_PATH
        git init
        code .
    fi
elif [ "$1" = "download" ] && [ "$2" = "kick" ] && [ -n "$3" ] && [ -n "$4" ]; then
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
    echo "Usage: gursh <command> <args>"
    echo "Commands:"
    echo "  create <repo_name> - Create a new repo in ~/Code/<repo_name> and open it in VS Code"
    echo "  download kick <URL> <DEST_PATH> - Download a video from kick.com"
fi