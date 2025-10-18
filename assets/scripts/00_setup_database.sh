#!/bin/bash

sudo -u postgres psql -c 'CREATE USER root';
sudo -u postgres psql -c 'ALTER USER root WITH SUPERUSER';
dropdb gis
createuser tirex
createdb gis
psql -d gis -c 'CREATE EXTENSION postgis;'
psql -d gis -c 'GRANT SELECT ON ALL TABLES IN SCHEMA public TO tirex;'
psql -d gis -c 'GRANT CONNECT ON DATABASE gis TO tirex;'
psql -d gis -c 'DROP TABLESPACE hdd;'
#Funktion zur Namensanpassung hinzufügen
psql -f ./tools/get_localized_name.sql gis
