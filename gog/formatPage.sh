#!/bin/bash

filename=$1
count=`cat $filename | wc -l`
count="$(( $count - 11 ))"
filenameFormat=$2
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
	all=$(echo "$l" `sed -n "${l}p" $filenameFormat | sed 's/$/,/g' | sed 's/^/)(/g'` | sed "s/ /-/g" | sed 's/"//g')
	repl="product-tile-product-tile--grid-href="
	replTag="|link|"
	all=`echo $all | sed "s/${repl}//g"`
	all=`echo "$all" | sed -E "s/$/${replTag}/g"`
	linesAll+=($all)
done


lines=(`egrep -n 'base-value|final-value|_ngcontent-gogcom-store-' $filenameFormat | sed 's/:.*$//g'`)
for l in ${lines[@]}
do
	all=$(echo "$l" `sed -n "${l}p" $filenameFormat | sed 's/$/,/g'` | sed "s/ /-/g" | sed 's/"//g')
	repl=("<\/span>" "_ngcontent-gogcom-store-c[0-9]+=>" "base-value-ng-star-inserted>" "final-value-ng-star-inserted>")
	replTag=("" "|title|" "|base-value|" "|final-value|")
	for i in ${!repl[@]}
	do
		r=${repl[$i]}
		rt=${replTag[$i]}
		allNew=`echo "$all" | sed -E "s/${r}//g"`
		if [[ "$allNew" != "$all" ]]; then
			if [[ "$i" -eq "1" ]]; then
				allNew=`echo $allNew | sed -E 's/[^[:alnum:]]/-/g' | sed -E 's/-$/,/g'` #title replace non-alpha
			fi
			allNew=`echo "$allNew" | sed -E "s/$/${rt}/g"`
		fi
		all=$allNew
	done

	linesAll+=($all)
done

sorted=`printArray ${linesAll[@]} | sort -n`
printArray ${sorted[@]} | sed -E 's/^[0-9]+\-//g' > $filenameFormat

