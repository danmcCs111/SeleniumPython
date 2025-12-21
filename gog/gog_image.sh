#!/bin/bash
imgPath="../GrabFolder/Gog/images/"
fileInput=$1

urls=(`grep "|link|" "$fileInput" | sed 's/^)(//g' | sed 's/|//g' | tr , ',' | sed 's/,link//g'`)
titles=(`grep "|title|" "$fileInput" | sed 's/^)(//g' | sed 's/|//g' | tr , ',' | sed 's/,title//g'`)

for i in ${!urls[@]}
do
	url=${urls[$i]}
	title=${titles[$i]}
	imgLink=$(curl $url | egrep -o "thumbnail\" content=\"[^\"]*\"" | sed "s/thumbnail\" content=\"//g" | sed "s/\"$//g")
	echo $imgLink
	curl $imgLink --output $imgPath$title.png
done
