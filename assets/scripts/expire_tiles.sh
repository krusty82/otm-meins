#!/bin/bash
render_expired --map=s2o --min-zoom=13 --touch-from=15 --delete-from=17 --max-zoom=17 \
     -t /var/lib/tirex/tiles \
     -s /var/lib/tirex/modtile.sock < /dirty_tiles.txt
rm /dirty_tiles.txt
