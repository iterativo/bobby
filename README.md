## Synopsis

Bash script to check if a URL has certain text in it. This can be useful when you’re waiting for text status change to happen on a website. For example, waiting to see when a product becomes available online. 

## Motivation

I wrote this after finding myself periodically checking a particular product to become available on a popular e-commerce site. With the help of this script, now I could just let it run in the background for me (via a [Cron](https://en.wikipedia.org/wiki/Cron) job)

## Usage

```
Usage: ./bobby.sh [-h] url txt [-t title] [-m msg] [-s sound]
-- Program to check URL content for provided text (case insensitive) and notify user when found.

where:
  -h   show this help text
  url  URL's whose content will be searched
  txt  text expected to be found in URL
  -t   title for Apple Script notification (default: bobby.sh)
  -m   message to be shown in Apple Script notification (default: Found text in URL)
  -s   sound name for Apple Script notification (default: Ping.aiff)

Example:
  ./bobby.sh http://www.amazon.com/products/1 "in stock"
```
