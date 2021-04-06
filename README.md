# Import Addresses, postal codes and WGS84-coordinates of Finnish buildings to PostGIS Database

Simple helper script to convert the Addresses, postal codes and 
WGS84-coordinates of Finnish buildings open data to PostgreSQL PostGIS table.

The dataset is available for download at:

* https://www.opendata.fi/data/fi/dataset/postcodes

Extract the archive downloaded from the above opendata.fi site and put the file
Finland_addresses_2021-02-05.csv in the current directory and run the script.

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

Import the data into the nominatim database and run create-nominatim-postcodes.sql

Support for augmenting addresses is to be added.
