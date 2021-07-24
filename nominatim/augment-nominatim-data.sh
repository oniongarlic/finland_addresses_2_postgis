#!/bin/bash

set -e

../fi-address-to-postgis.sh Finland_addresses_2021-05-17.csv nominatimFI

echo "Postcodes"
psql -f create-nominatim-postcodes.sql nominatimFI

echo "Update postcodes"
psql -f update-fi-postcodes.sql nominatimFI

echo "Add VS geodata"
psql -f create-vs-kunta.sql nominatimFI

echo "Add LE view"
psql -f create-linkedevents-pois.sql nominatimFI
