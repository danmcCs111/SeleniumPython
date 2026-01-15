#!/bin/bash
url=$1
filename=$2
echo $url
echo $filename
echo [InternetShortcut] > $filename
echo "URL="$url >> $filename