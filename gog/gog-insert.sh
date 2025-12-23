#!/bin/bash

function getTags()
{
	mapFile="$1"
	tags=(`egrep -o "^[^=]*=" $mapFile | sed 's/=//g'`)
}

function getDBColumns()
{
	mapFile="$1"
	dbColumns=(`egrep -o "=.*$" $mapFile | sed 's/=//g'`)
}

function stripFromTag()
{
	local tag="$1"
	fileRecord="$2"
	dbValue=`echo $fileRecord | egrep -o "[^|]*\|$tag\|" | sed "s/,|$tag|//g"`
}

function readFile()
{
	fileRecords=(`tr -d '\n' < $fileInput > output.txt; cat output.txt | egrep -o "([^)]*)"`)
}

fileInput=$1
mapFile=$2

getTags $mapFile
getDBColumns $mapFile
echo ${dbColumns[@]}
readFile
tag=(${tags[@]})

echo ${tag[@]}
for fileRecord in ${fileRecords[@]}
do
	dbValues=()
	colTags=()
	for ti in ${!tag[@]}
	do
		t=${tag[$ti]}
		stripFromTag $t $fileRecord
		if [ -z "$dbValue" ];
		then
			echo "blank"
		else
			dbValues+=($dbValue)
			colTags+=(${dbColumns[$ti]})
		fi
	done
	for dbi in ${!dbValues[@]}
	do
		db="${dbValues[$dbi]}"
		col="${colTags[$dbi]}"
		echo $db " " $col
	done
done
