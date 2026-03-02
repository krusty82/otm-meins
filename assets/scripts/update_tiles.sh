#!/bin/bash
osm2pgsql-replication \
    update -d gis \
    --max-diff-size 10  --  \
    -G \
    -C 3000 --number-processes 4 \
    --flat-nodes /mnt/db/flat-nodes/gis-flat-nodes.bin  \
    --style /home/otm/db/opentopomap.style \
    --expire-tiles=11-17 \
    --expire-output=/dirty_tiles.txt
