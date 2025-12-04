#!/bin/bash
url=$1
filename=$2
echo $url
fileName="GrabFolder/Roku/images/"`echo $filename | sed 's/title=//g' | sed -E 's/[^[:alnum:]]+/_/g'`.jpg
echo $fileName
curl --output "$fileName" $url