#!/bin/bash

path="Roku/images/"
files=(`ls Roku/images`)
for i in ${files[@]}
do
	fle=`echo $i | sed 's/\..*$//g'`
	echo $fle
	python convert_jpg_to_png.py $fle $path
done
