#!/bin/bash


cd /mnt/2tb

#for hgtfile in *.hgt; do gdal_fillnodata.py $hgtfile $hgtfile.tif; done
#rm -f *.hgt

#gdal_merge.py -n 32767 -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -o ../raw.tif *.hgt.tif

#cd ..
#rm -rf unpacked
gdalbuildvrt -overwrite -hidenodata -srcnodata 0 -addalpha relief.vrt relief-euro.tif relief-world.tif

#gdalwarp -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -t_srs epsg:3857 -r bilinear -tr 1000 1000 raw.tif warp-1000.tif
#gdalwarp -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -t_srs epsg:3857 -r bilinear -tr 5000 5000 raw.tif warp-5000.tif
#gdalwarp -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -t_srs epsg:3857 -r bilinear -tr 500 500 raw.tif warp-500.tif
#gdalwarp -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -t_srs epsg:3857 -r bilinear -tr 150 150 raw.tif warp-150.tif
#gdalwarp -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -t_srs epsg:3857 -r bilinear -tr 90 90 raw.tif warp-90.tif
# 30m - for the detail hillshade
#gdalwarp -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -t_srs epsg:3857 -r bilinear -tr 30 30 raw.tif warp-30.tif

# relief for zoom factors 1-4
#gdaldem color-relief -co COMPRESS=LZW -co PREDICTOR=2 -alpha warp-5000.tif /home/otm/relief_color_text_file.txt relief-5000.tif
# relief for zoom factors 5-8
#gdaldem color-relief -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -alpha warp-500.tif /home/otm/relief_color_text_file.txt relief-500.tif
# relief for zoom factors 9-10
#gdaldem color-relief -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -alpha warp-150.tif /home/otm/relief_color_text_file.txt relief-150.tif
#gdal_translate -co compress=JPEG -co bigtiff=yes -co tiled=yes relief-150.tif relief-150-jpeg.tif
#gdal_translate -co compress=JPEG -co bigtiff=yes -co tiled=yes relief-euro.tif relief-euro-jpeg.tif
#gdal_translate -co compress=JPEG -co bigtiff=yes -co tiled=yes relief-world.tif relief-world-jpeg.tif
# create hillshade
#gdaldem hillshade -z 7 -compute_edges -co COMPRESS=JPEG warp-5000.tif hillshade-5000.tif
#gdaldem hillshade -z 7 -compute_edges -co BIGTIFF=YES -co TILED=YES -co COMPRESS=JPEG warp-1000.tif hillshade-1000.tif
#gdaldem hillshade -z 5 -compute_edges -co BIGTIFF=YES -co TILED=YES -co COMPRESS=JPEG warp-500.tif hillshade-500.tif
#gdaldem hillshade -z 3 -compute_edges -co BIGTIFF=YES -co TILED=YES -co COMPRESS=JPEG warp-150.tif hillshade-150.tif
#gdaldem hillshade -z 2 -co compress=lzw -co predictor=2 -co bigtiff=yes -compute_edges euro-warp-30.tif hillshade-euro.tif
#gdal_translate -co compress=JPEG -co bigtiff=yes -co tiled=yes hillshade-euro.tif hillshade-euro-jpeg.tif
#gdaldem hillshade -z 2 -co compress=lzw -co predictor=2 -co bigtiff=yes -compute_edges world-warp-30.tif hillshade-world.tif
#gdal_translate -co compress=JPEG -co bigtiff=yes -co tiled=yes hillshade-world.tif hillshade-world-jpeg.tif
gdalbuildvrt -overwrite -hidenodata -srcnodata 181 -vrtnodata 181 -addalpha hillshade.vrt hillshade-world-jpeg.tif hillshade-euro-jpeg.tif
gdalbuildvrt -overwrite -hidenodata -srcnodata "16 119 3" -vrtnodata "16 119 3" -addalpha relief.vrt relief-world-jpeg.tif relief-euro-jpeg.tif
