#!/bin/bash

set -e

../fi-address-to-postgis.sh Finland_addresses_2021-05-17.csv nominatimFI
psql -f create-nominatim-postcodes.sql nominatimFI
psql -f update-fi-postcodes.sql nominatimFI
