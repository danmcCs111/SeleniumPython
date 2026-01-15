#/bin/bash
file=$1

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

function imageArray {
	local arr=("$@")
	for r in ${arr[@]};
	do
		egrep -o "content\=\"[^\"]*$r[^\"]*\"" $file | uniq | head -1 | sed 's/content=//g' | sed 's/\"//g'
	done
}

roku_titles=(`egrep -o "\<a title=\"[^\/]*/watch/[a-zA-Z0-9\-]*\"" $file | egrep -o "title=\"[^\"]*\"" | sed 's/ /\_/g' | awk '{system("echo " $0)}'`)
roku_urls=(`egrep -o "\<a title=\"[^\/]*/watch/[a-zA-Z0-9\-]*\"" $file | egrep -o "/watch/[^\"]*\"" | sed 's/\"//g' | awk '{system("echo https://therokuchannel.roku.com" $NF)}'`)
tmp=(`printArray "${roku_urls[@]}" | sed 's/\// /g'`)
roku_ids=(`printArray "${tmp[@]}" | egrep -v "https|watch|therokuchannel"`)
printArray "${roku_ids[@]}"
roku_images=(`imageArray "${roku_ids[@]}"`)
#xargs -I {} egrep -o "content\=\"[^\"]*{}[^\"]*\"" $file | uniq | head -1`)


printArray "${roku_urls[@]}"
echo "url count: ${#roku_urls[@]}"

printArray "${roku_images[@]}"
echo "image count: ${#roku_images[@]}"

printArray "${roku_titles[@]}"

echo "title count: ${#roku_titles[@]}"
echo "url count: ${#roku_urls[@]}"
echo "image count: ${#roku_images[@]}"

for index in "${!roku_urls[@]}"
do
	url="${roku_urls[$index]}"
	filename="${roku_titles[$index]}"
	filename="GrabFolder/Roku/"`echo $filename | sed 's/title=//g' | sed -E 's/[^[:alnum:]]+/_/g'`.url
	ls_res="$(ls $filename)"
	if [ -z "$ls_res" ];
	then
		./rokuToUrl.sh "$url" "$filename" 
	else
		echo $filename " already saved."
	fi
done

for index in "${!roku_images[@]}"
do
	url="${roku_urls[$index]}"
	filename="${roku_titles[$index]}"
	filename="GrabFolder/Roku/images/"`echo $filename | sed 's/title=//g' | sed -E 's/[^[:alnum:]]+/_/g'`.jpg
	ls_res="$(ls $filename)"
	if [ -z "$ls_res" ];
	then
		curl --output "$filename" "$url"
	else
		echo $filename " already saved."
	fi
done