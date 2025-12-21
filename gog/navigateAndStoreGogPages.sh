#!/bin/bash
baseUrl="https://www.gog.com/en/games"
pageSuffix="?page="
pageFileName="page"

curl $baseUrl --output temp.txt
./gog.sh temp.txt > page1.txt
./formatPage.sh page1.txt
./gog_image.sh formatted-page1.txt

for i in {2..209}
do
	#echo "url: " $baseUrl$pageSuffix$i 
	curl $baseUrl$pageSuffix$i --output temp.txt
	./gog.sh temp.txt > page$i.txt
	./formatPage.sh page$i.txt
	./gog_image.sh formatted-page$i.txt
done
