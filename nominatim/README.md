# Finland to Nominatim

Helper scripts to:

* Build Nominatim
* Import geofabrik extract
* Augment with Finland_addresses data

## POI dump

* Extract POIs for selected municipalities in Varsinais-Suomi for use with City of Turku LinkedEvents

# How to

Run doit.sh to do everything, or:

* make-nominatim.sh Build and install nominatim
* import-finland-nominatim.sh Download and import 
* augment-nominatim-data.sh Augment with Finland_addresses data
* dump-vs-csv.sh Dump CSV file with POIs
