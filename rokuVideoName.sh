#/bin/bash
file=$1
roku_titles=(`egrep -o "\<a title=[A-Za-z0-9\&\;\:\?\!\=\"\ \-]*/watch/[a-zA-Z0-9\-]*\"" $file | egrep -o "title=\"[^\"]*\"" | sed 's/ /\_/g' | awk '{system("echo " $0)}'`)
roku_urls=(`egrep -o "\<a title=[A-Za-z0-9\&\;\:\?\!\=\"\ \-]*/watch/[a-zA-Z0-9\-]*\"" $file | egrep -o "/watch/[^\"]*\"" | sed 's/\"//g' | awk '{system("echo https://therokuchannel.roku.com" $NF)}'`)


function rokuToUrl {
	roku_urls=("$@")
	for r in ${roku_urls[@]};
	do
		./rokuToUrl.sh $r
	done
}

function printArray {
	local arr=("$@")
	for r in ${arr[@]};
	do
		echo $r
	done
}

printArray "${roku_urls[@]}"
echo "url count: ${#roku_urls[@]}"

printArray "${roku_titles[@]}"
echo "title count: ${#roku_titles[@]}"


#rokuToUrl $roku_urls
