#!/bin/bash


cd /mnt/data
mkdir srtm
cd srtm

# create contour lines - this takes a long time
# and you need A LOT of RAM, at least 16 GB are needed!
# reads a polyfile in the /mn/data folder and downloads the srtm files
# Use pyhgtmap
pyhgtmap --polygon ../*.poly --step=10 --pbf --hgtdir=hgt  --source=view3 --simplifyContoursEpsilon=0.0001
