#!/bin/bash

sudo -u postgres     osm2pgsql-replication init     -d gis     --osm-file /mnt/data/*.osm.pbf
