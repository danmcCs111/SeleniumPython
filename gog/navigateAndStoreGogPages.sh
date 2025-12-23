#!/bin/bash
baseUrl="https://www.gog.com/en/games"
pageSuffix="?page="
pageFileName="page"

outputPath="tmp/"

curl $baseUrl --output "$outputPath"temp.txt
./gog.sh "$outputPath"temp.txt > "$outputPath"page1.txt
./formatPage.sh "$outputPath"page1.txt "$outputPath"formatted-page1.txt
./gog-insert.sh "$outputPath"formatted-page1.txt mapping-gog.txt > "$outputPath"formatted-page1-insert.txt
./gog_image.sh "$outputPath"formatted-page1.txt&

for i in {2..209}
do
	#echo "url: " $baseUrl$pageSuffix$i 
	curl $baseUrl$pageSuffix$i --output "$outputPath"temp.txt
	./gog.sh "$outputPath"temp.txt > "$outputPath"page$i.txt
	./formatPage.sh "$outputPath"page$i.txt "$outputPath"formatted-page$i.txt
	./gog-insert.sh "$outputPath"formatted-page$i.txt mapping-gog.txt > "$outputPath"formatted-page$i-insert.txt
	./gog_image.sh "$outputPath"formatted-page$i.txt&
done
