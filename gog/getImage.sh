#!/bin/bash

filename=$1
count=`cat $filename | wc -l`
count="$(( $count - 11 ))"

rangeEnd=$(( $(( $count -1 )) / 4 ))
echo $rangeEnd

for i in {0..47}
do
	rStart=$(( $i * 4 ))
	rStart=$(( $rStart + 1 ))
	rEnd=$(( $(( $i + 1 )) * 4 ))

	sed -n "${rStart},${rEnd}p" $filename
	echo
done
