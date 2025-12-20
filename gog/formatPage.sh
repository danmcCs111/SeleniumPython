#!/bin/bash

filename=$1
count=`cat $filename | wc -l`
count="$(( $count - 11 ))"
filenameFormat=formatted-$filename
head -$count $filename > $filenameFormat

rangeEnd=$(( $(( $count -1 )) / 4 ))
echo $rangeEnd

lines=(`grep -n product-tile $filenameFormat | sed 's/:.*$//g'`)

function printArray()
{
	arr="$@"
	for l in ${arr[@]}
	do
		echo "$l"
	done
}

for l in ${lines[@]}
do
	all=$(echo "$l" `sed -n "${l}p" $filenameFormat | sed 's/^/)(/g'` | sed "s/ /-/g" | sed 's/"//g')
	repl="product-tile-product-tile--grid-href="
	all=`echo $all | sed "s/${repl}//g"`
	#echo $all
	linesAll+=($all)
done


lines=(`egrep -n 'base-value|final-value|_ngcontent-gogcom-store-' $filenameFormat | sed 's/:.*$//g'`)
for l in ${lines[@]}
do
	all=$(echo "$l" `sed -n "${l}p" $filenameFormat | sed 's/$/,/g'` | sed "s/ /-/g" | sed 's/"//g')
	repl=("_ngcontent-gogcom-store-c[0-9]+=>" "base-value-ng-star-inserted>" "final-value-ng-star-inserted>" "<\/span>")
	#repl="_ngcontent-gogcom-store-c[0-9]+=>"
	#all=`echo $all | sed -E "s/${repl}//g"`
	for r in ${repl[@]}
	do
		all=`echo "$all" | sed -E "s/${r}//g"`
	done

	linesAll+=($all)
done

sorted=`printArray ${linesAll[@]} | sort -n`
printArray ${sorted[@]} | sed -E 's/^[0-9]+\-//g' > $filenameFormat

