# Import Addresses, postal codes and WGS84-coordinates of Finnish buildings to PostGIS Database

Simple helper script to convert the Addresses, postal codes and 
WGS84-coordinates of Finnish buildings open data to PostgreSQL PostGIS table.

The upstream dataset is available for download at:

* https://www.opendata.fi/data/fi/dataset/postcodes

The current data file is contained in this repository as xz archive to make usage as easy as possible.

Usage: fi-address-to-postgis.sh dbname

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

