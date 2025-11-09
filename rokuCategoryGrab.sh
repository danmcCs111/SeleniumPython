#/bin/bash
python grabRokuCategories.py > rokuHomePage.txt
./rokuUrlStrip.sh rokuHomePage.txt > rokuCategories.txt
cats=`(cat rokuCategories.txt)`
for i in ${cats[@]};
do
	python grabRokuCategory.py $i > rokuCat.txt
	./rokuVideoName.sh rokuCat.txt
	read -p "enter to continue"
done