#!/bin/bash
# TODO Description

str="<span class=\"customer_commit_display\">In Stock</span>"
url="http://www.apple.com/shop/product/G0RG1LL/A/refurbished-154-inch-macbook-pro-28ghz-quad-core-intel-i7-with-retina-display"

if curl -s "$url" | grep -q -i "$str"; then
	echo "found"
else
	echo "not found"
fi

