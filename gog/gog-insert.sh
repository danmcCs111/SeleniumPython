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

insertPrefix="INSERT INTO gamedatabase.Game ("
insertSuffix="CURRENT_TIMESTAMP);"

defEnd="InsertDate_Game_GameDatabase)"
defEnd2="values("

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
		if [ -n "$dbValue" ];
		then
			dbValues+=($dbValue)
			colTags+=(${dbColumns[$ti]})
		fi
	done
	echo $insertPrefix
	for col in ${colTags[@]}
	do
		echo $col "," | sed 's/ //g'
	done
	echo $defEnd
	echo $defEnd2
	for dbi in ${!dbValues[@]}
	do
		db="${dbValues[$dbi]}"
		db=$(echo '"' $db "\"," | sed 's/ //g')
		if [[ "$db" =~ "$" ]]
		then
			db=`echo $db | sed 's/[$]//g' | sed "s/\"//g"`
		elif [[ "$db" =~ ^"\"(" ]]
		then
			db=`echo $db | sed 's/^\"[(]/\"/g'`
		fi
		echo $db
	done
	echo $insertSuffix
done
