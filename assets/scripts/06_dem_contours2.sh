#!/bin/bash

cd /mnt/data/srtm
# Je nach Umfang der Höhendaten wird viel Speicher benötigt, ggfs swap size erhöhen. 
# Für Europa reichen 16Gb RAM und etwa 20Gb Swap
# import contours data into db
createdb contours -O tirex
psql -d contours -c 'CREATE EXTENSION postgis;'
psql -d contours -c 'GRANT SELECT ON ALL TABLES IN SCHEMA public TO tirex;'
osm2pgsql --slim -d contours --cache 5000 --style /home/otm/db/contours.style *.pbf
psql -d contours -c 'GRANT SELECT ON ALL TABLES IN SCHEMA public TO tirex;'
