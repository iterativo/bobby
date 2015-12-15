#!/bin/bash
# Program to check URL content for provided text and notify user when found

appname="$(basename "$0")"

### Options
: ${title:="$appname"}
: ${msg:="Found text in URL"}
: ${sound:="Ping.aiff"}

usage="
Usage: ./$appname [-h] url txt [-t title] [-m msg] [-s sound]
-- Program to check URL content for provided text (case insensitive) and notify user when found.

where:
  -h   show this help text
  url  URL's whose content will be searched
  txt  text expected to be found in URL
  -t   title for Apple Script notification (default: $title)
  -m   message to be shown in Apple Script notification (default: $msg)
  -s   sound name for Apple Script notification (default: $sound)

Example:
  ./$appname http://www.amazon.com/products/1 \"in stock\""

### Args length requirements check
if [ $# -lt 2 ] || [ $1 == "-h" ]; then
	echo "$usage"
	exit
fi

### Args
url=$1
txt=$2

urlregex="(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]"
if ! [[ $url =~ $urlregex ]]; then
	echo "ERROR: Invalid 'url' arg - please enter a valid URL."
	echo "For usage, run: ./$appname -h"
	exit
fi

if curl -s "$url" | grep -q -i "$txt"; then
	osascript -e 'display notification "'"$msg"'" with title "'"$title"'" sound name "'"$sound"'"'
else
	echo "not found"
fi

