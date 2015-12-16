#!/bin/bash
# Program to check URL content for provided text and notify user when found

appname="$(basename "$0")"

########################
#        Options       #
########################

: ${title:="$appname"}
: ${msg:="Found text in URL"}
: ${sound:="Ping.aiff"}

# Help text
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
  ./$appname http://www.amazon.com/products/1 \"in stock\"\n"

########################
#         Args         #
########################

# Check args were provided
if [ $# -lt 2 ] || [ $1 == "-h" ]; then
	printf "$usage"
	exit
fi

url=$1
txt=$2

# Check URL validity
urlregex="(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]"
if ! [[ $url =~ $urlregex ]]; then
	printf "ERROR: Invalid 'url' arg. Please enter a valid URL.\nFor usage, run: ./$appname -h\n"
	exit 1
fi

# Parse options
shift; shift
while test $# -gt 0; do
        case "$1" in
                -t)
                        shift
                        if test $# -gt 0; then
                                title=$1
                        else
                                printf "ERROR: No title specified.\n"
                                exit 1
                        fi
                        shift
                        ;;
                -m)
                        shift
                        if test $# -gt 0; then
                                msg=$1
                        else
                                printf "ERROR: No msg specified.\n"
                                exit 1
                        fi
                        shift
                        ;;
                -s)
                        shift
                        if test $# -gt 0; then
                                sound=$1
                        else
                                printf "ERROR: No sound specified.\n"
                                exit 1
                        fi
                        shift
                        ;;
                *)
                        break
                        ;;
        esac
done

# Execute URL content test
if curl -s "$url" | grep -q -i "$txt"; then
	osascript -e 'display notification "'"$msg"'" with title "'"$title"'" sound name "'"$sound"'"'
else
	printf "Unable to find text in URL, using:\n  url: \"$url\"\n  txt: \"$txt\"\n"
fi

