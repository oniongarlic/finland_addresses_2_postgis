#!/bin/bash

set -e

echo "Checking for Finland extract"
if [ ! -f finland-latest.osm.pbf ]; then
 wget https://download.geofabrik.de/europe/finland-latest.osm.pbf
else
 echo "Using existing Finland dump (remove file to re-download):"
 ls -l finland-latest.osm.pbf
fi

echo "Linking nominatim .env configuration"
ln -sf nominatim-finland.env .env

echo "Dropping old import in case it exists"
dropdb --if-exists nominatimFI

echo "Starting import"
nominatim import -v -j 12 --no-partitions --osm-file finland-latest.osm.pbf

echo "Checking import"
nominatim admin --check-database

echo "Import done"
