#!/bin/sh

cd "$(dirname "$0")"

rm display.png

if wget -O display.png http://matt-kindle.webscript.io/index; then
	eips -c
	eips -c
	eips -g display.png
else
	eips -c
	eips -c
	eips -g error.png
fi
