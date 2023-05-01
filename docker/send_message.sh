#!/bin/bash -l

SIGNAL_CONFIG_PATH=$1
SENDER_PHONE_NUMBER="+YOUR_PHONE_NUMBER_HERE"
RECEIVER_GROUP="YOUR_BASE64_ENCODED_GROUP_ID_HERE"
SIGNAL_MESSAGE="GOOD MOOORNIIING"

SIGNAL_CLI_PATH=/app/signal-cli-0.11.9.1/bin/signal-cli

timestamp=`date -I"seconds"`
# Here we send downloaded images/videos from the subreddit to the Signal group
echo $($SIGNAL_CLI_PATH \
    --config $SIGNAL_CONFIG_PATH \
    -u $SENDER_PHONE_NUMBER \
    send -m "$SIGNAL_MESSAGE" -g $RECEIVER_GROUP -a $(ls *.mp4 *.gif *.png *.jpg *.jpeg 2> /dev/null))
echo -e "$timestamp $SENDER_PHONE_NUMBER => $RECEIVER_GROUP: $SIGNAL_MESSAGE"