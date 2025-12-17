#!/bin/bash
egrep -o "thumbnail\" content=\"[^\"]*\"" temp-title.txt | sed "s/thumbnail\" content=\"//g" | sed "s/\"$//g"
