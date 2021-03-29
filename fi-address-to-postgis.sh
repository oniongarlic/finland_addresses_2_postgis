#!/bin/sh
FA=Finland_addresses_2021-02-05.csv
DB=$USER

echo "Converting to UTF-8"
iconv -f ISO_8859-15 -t UTF-8 -o finland_addresses.csv $FA

echo "Importing to database: $DB"
ogr2ogr -f "PostgreSQL" PG:"dbname=$DB" finland_addresses.vrt

echo "Done"
