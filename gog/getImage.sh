#!/bin/bash

filename=$1
count=`cat $filename | wc -l`
count="$(( $count - 11 ))"
head -$count $filename > tmp$filename
cat tmp$filename > $filename

rangeEnd=$(( $(( $count -1 )) / 4 ))
echo $rangeEnd

lines=(`grep -n product-tile $filename | sed 's/:.*$//g'`)
for l in ${lines[@]}
do
	sed -n "${l}p" $filename | sed 's/^/)(/g'
done

lines=(`egrep -n 'base-value|final-value|_ngcontent-gogcom-store-' $filename | sed 's/:.*$//g'`)
for l in ${lines[@]}
do
	sed -n "${l}p" $filename | sed 's/$/,/g' 
done

