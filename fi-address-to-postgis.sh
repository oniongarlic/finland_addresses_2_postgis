#!/bin/bash
FA=Finland_addresses_2021-05-17.csv
DB=$USER

if [ $# -gt 0 ]; then
 FA=$1
fi

if [ $# -gt 1 ]; then
 DB=$2
fi

if [ ! -f "$FA" ]; then
 echo "Input file $FA not found"
 exit 1
fi

echo "Converting to UTF-8"
iconv -f ISO_8859-15 -t UTF-8 -o finland_addresses.csv $FA

echo "Importing to database: $DB"
ogr2ogr -f "PostgreSQL" PG:"dbname=$DB" finland_addresses.vrt

echo "Done"
