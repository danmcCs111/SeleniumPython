#!/bin/bash
url=$1
filename=$2
echo $url
fileName="GrabFolder/Roku/"`echo $filename | sed 's/title=//g' | sed -E 's/[^[:alnum:]]+/_/g'`.url
echo $fileName
echo [InternetShortcut] > $fileName
echo "URL="$url >> $fileName