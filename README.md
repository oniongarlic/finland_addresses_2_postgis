# Import Addresses, postal codes and WGS84-coordinates of Finnish buildings to PostGIS Database

Simple helper script to convert the Addresses, postal codes and 
WGS84-coordinates of Finnish buildings open data to PostgreSQL PostGIS table.

The dataset is available for download at:

* https://www.opendata.fi/data/fi/dataset/postcodes

Extract the archive downloaded from the above opendata.fi site and put the file
Finland_addresses_2021-05-17.csv in the current directory and run the script or
optionally the path to the file as first argument to the scripts.

Usage: fi-address-to-postgis.sh input.csv dbname

Note: The above data contains errors, there are points that are outside their correct area.

## Requirements

* iconv
* ogr2ogr
* PostgreSQL with PostGIS

## Import

It assumes a database with the current user already exists with PostGIS extensions, if 
not create a database and run:

 CREATE EXTENSION postgis;

Adjust the script in case the file date stamp changes or you like to use some other destination database.

## Nominatim augmentation

The imported data can be used to augment a Nominatim search index. Currently support are:

* Postal codes

Support for augmenting addresses is to be added.

### Postal codes

Import the data into the nominatim database and run the SQL scripts:

* create-nominatim-postcodes.sql
* update-fi-postcodes.sql

