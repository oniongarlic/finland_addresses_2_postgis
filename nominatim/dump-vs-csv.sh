#!/bin/bash

set -e

echo "Dumping POIs"
psql -c "\copy (select * from linkedevents_pois order by osm_id) to 'poi-dump-vs-le.csv' with csv header" nominatimFI
