#/bin/bash
set PYTHONUTF8=1
python grabRokuCategories.py > rokuHomePage.txt
./rokuUrlStrip.sh rokuHomePage.txt > rokuCategories.txt
set PYTHONUTF8=1; cat rokuCategories.txt | awk '{system("python grabRokuCategory.py " $NF)}'