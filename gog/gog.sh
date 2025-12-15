#!/bin/bash
egrep -o "_ngcontent-gogcom-store-c[^\"]*\"\">[^<]*</span>|\"(final-value|base-value)[^\"]*\">[^<]*</span>|product-tile[^\"]*\" href=\"[^\"]*\"|srcset=\"[^\"]*\"|src=\"[^\"]*\"" temp.txt 
