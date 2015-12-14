#!/bin/bash
# TODO Description

# URL txt check vars
str="<span class=\"customer_commit_display\">In Stock</span>"
url="http://www.apple.com/shop/product/G0RG1LL/A/refurbished-154-inch-macbook-pro-28ghz-quad-core-intel-i7-with-retina-display"

# Notification vars
title="MBP is available!"
msg="Go to refurbished outlet"
sound="default"

if curl -s "$url" | grep -q -i "$str"; then
	osascript -e 'display notification "'"$msg"'" with title "'"$title"'" sound name "'"$sound"'"'
else
	echo "not found"
fi

