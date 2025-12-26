#!/bin/bash

requiredPackages=("pillow" "selenium")

function checkPipInstall()
{
	package="$1"
	installed=`pip list | grep "$package"`
	if [[ -n "$installed" ]]
	then
		echo "installed"
	else
		echo "missing"
	fi
}

function pipInstall()
{
	package="$1"
	pip install $package
}

pythonInstalled=$(where python)
if [[ -z $pythonInstalled ]]
then
	echo "python not found. install from browser or terminal"
	echo "or check environment/path variables"
	chrome "https://www.python.org/downloads/"
fi

for pack in ${requiredPackages[@]}
do
	val=$(checkPipInstall "$pack")
	echo $pack " - " $val
	if [ "$val" == "missing" ]
	then
		pipInstall $pack
	fi
done

