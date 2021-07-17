#!/bin/sh

sed -i 's,$STREAM_URL,'"$STREAM_URL"',g' /usr/share/nginx/html/index.html
