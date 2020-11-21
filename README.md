Simple helper script to convert Finland Addresses data to PostgreSQL PostGIS table.

Extract the archive downloaded from the opendata.fi site below and put the file
Finland_addresses_2020-11-13.csv in the current directory and run the script.

It assumes a database with the current user already exists with PostGIS extensions.

Adjust the script in case the file date stamp changes or you like to use some other destination database.

* https://www.opendata.fi/data/fi/dataset/postcodes
