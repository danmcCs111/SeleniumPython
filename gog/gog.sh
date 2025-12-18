#!/bin/bash
filename=$1
egrep -o "_ngcontent-gogcom-store-c[^\"]*\"\">[^<]*</span>|\"(final-value|base-value)[^\"]*\">[^<]*</span>|product-tile[^\"]*\" href=\"[^\"]*\"" "$filename" | grep -v "Filter</span>"
