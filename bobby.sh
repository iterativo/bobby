#!/bin/bash
# TODO Description

appname="$(basename "$0")"

: ${title:="$appname"}
: ${msg:="Found text in URL"}
: ${sound:="Ping.aiff"}

usage="
Usage: ./$appname [-h] url txt [-t title] [-m msg] [-s sound]
-- Program to check URL content for provided text (case insensitive) and generate Apple Script notification when found.

where:
  -h   show this help text
  url  URL's whose content will be searched
  txt  text expected to be found in URL
  -t   title for Apple Script notification (default: $title)
  -m   message to be shown in Apple Script notification (default: $msg)
  -s   sound name for Apple Script notification (default: $sound)

Example:
  ./$appname http://www.amazon.com/products/1 \"in stock\""

if [ $# -lt 2 ] || [ $1 -eq -h ]; then
	echo "$usage"
	exit
fi

# URL txt check vars
url=$1
str=$2

# Notification vars
title="MBP is available!"
msg="Go to refurbished outlet"
sound="default"

if curl -s "$url" | grep -q -i "$str"; then
	osascript -e 'display notification "'"$msg"'" with title "'"$title"'" sound name "'"$sound"'"'
else
	echo "not found"
fi

