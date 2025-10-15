#!/bin/bash

sh 00_setup_database.sh
sh 01_download_water_polys.sh
sh 02_import_osm_data.sh
sh 03a_dem_contours1.sh
sh 03b_dem_hillshade.sh
sh 04_preprocess_osm_data.sh
sh 06_dem_contours2.sh
