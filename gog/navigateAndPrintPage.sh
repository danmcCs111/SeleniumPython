#!/bin/bash
baseUrl="https://www.gog.com/en/games"
pageSuffix="?page="
pageFileName="page"

curl $baseUrl --output temp.txt
./gog.sh temp.txt > page1.txt
./getImage.sh page1.txt

for i in {2..209}
do
	#echo "url: " $baseUrl$pageSuffix$i 
	curl $baseUrl$pageSuffix$i --output page$i.txt
done
