#/bin/bash
set PYTHONUTF8=1
python grabRokuCategories.py > rokuHomePage.txt
./rokuUrlStrip.sh rokuHomePage.txt > rokuCategories.txt