#/bin/bash
file=$1
egrep -o "\/watch\/[a-zA-Z0-9\-]*\"" $file | sed 's/\"//g'