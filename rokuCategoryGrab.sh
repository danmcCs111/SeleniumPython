#/bin/bash
mkdir -p "GrabFolder/Roku/images/"

python grabRokuCategories.py > rokuHomePage.txt
./rokuUrlStrip.sh rokuHomePage.txt | sort -n | uniq > rokuCategories.txt

read -p "Edit rokuCategories.txt if desired and press Enter to continue"

cats=(`cat rokuCategories.txt`)
for index in "${!cats[@]}"
do
	echo $(( $index + 1 )) " category of : ${#cats[@]}"
	python grabRokuCategory.py "${cats[$index]}" > rokuCat.txt
	./rokuVideoName.sh rokuCat.txt
done

cd GrabFolder
./convertRokuToPng.sh
