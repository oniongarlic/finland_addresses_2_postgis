#!/bin/bash

set -e

echo "*** Building nominatim"
./make-nominatim.sh

echo "*** Importing Finland"
./import-finland-nominatim.sh

echo "*** Augmenting data"
./augment-nominatim-data.sh

echo "*** Dumping data"
./dump-vs-csv.sh
