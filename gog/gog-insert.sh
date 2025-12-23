#!/bin/bash

function getTags()
{
	mapFile="$1"
	tags=(`egrep -o "^[^=]*=" $mapFile | sed 's/=//g'`)
}

function stripFromTag()
{
	local tag="$1"
	fileRecord="$2"
	url=`echo $fileRecord | egrep -o "[^|]*\|$tag\|" | sed "s/,|$tag|//g"`
	echo $url
}

function readFile()
{
	fileRecords=(`tr -d '\n' < $fileInput > output.txt; cat output.txt | egrep -o "([^)]*)"`)
}

fileInput=$1
mapFile=$2

getTags $mapFile
readFile
tag=(${tags[@]})

echo ${tag[@]}
for fileRecord in ${fileRecords[@]}
do
	for t in ${tag[@]}
	do
		stripFromTag $t $fileRecord
	done
done
