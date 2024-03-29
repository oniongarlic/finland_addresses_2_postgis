#!/bin/bash
DB=$USER

if [ $# -gt 0 ]; then
 DB=$1
fi

echo "Converting to UTF-8"
xzcat Finland_addresses_2021-05-17.csv.xz | iconv -f ISO_8859-15 -t UTF-8 -o finland_addresses.csv

echo "Importing to database: $DB"
ogr2ogr -f "PostgreSQL" PG:"dbname=$DB" finland_addresses.vrt

echo "Done"
