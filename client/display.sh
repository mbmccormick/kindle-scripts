#!/bin/sh

cd "$(dirname "$0")"

rm display.png
eips -c
eips -c

if wget -O display.png http://matt-kindle.webscript.io/index; then
	eips -g display.png
else
	eips -g error.png
fi
