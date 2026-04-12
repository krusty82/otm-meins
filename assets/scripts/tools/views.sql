-- Create view for ferry routes
CREATE MATERIALIZED VIEW ferry_routes_lowzoom AS
SELECT
    ST_LineMerge(ST_Collect(way)) AS way,
    name,
    ST_Length(ST_LineMerge(ST_Collect(way))) AS length
FROM planet_osm_line
WHERE route = 'ferry'
  AND osm_id > 0
GROUP BY name;

-- GIST-Index für Geometrie
CREATE INDEX ferry_routes_lowzoom_way_idx
    ON ferry_routes_lowzoom
    USING GIST (way);

GRANT SELECT ON ferry_routes_lowzoom TO tirex;

-- view on landuse_over_water
CREATE MATERIALIZED VIEW landuse_over_water AS
SELECT
    way,
    "natural",
    wetland
FROM planet_osm_polygon
WHERE
    ("natural" IN ('wetland','beach'))
    OR (wetland IS NOT NULL);

CREATE INDEX landuse_over_water_way_idx
    ON landuse_over_water
    USING GIST (way);
GRANT SELECT ON landuse_over_water TO tirex;

-- view on areas
CREATE MATERIALIZED VIEW areas AS
SELECT
    way,landuse,leisure,way_area
FROM planet_osm_polygon
WHERE
    (landuse = 'military') 
    OR (leisure = 'nature_reserve');

CREATE INDEX areas_way_idx
    ON areas
    USING GIST (way);
GRANT SELECT ON areas TO tirex;

-- view on landuse
CREATE MATERIALIZED VIEW landuse AS
SELECT way,way_area,landuse,leisure,"natural",wetland,leaf_type,amenity,crop,orchard 
    FROM planet_osm_polygon
    WHERE (landuse IS NOT NULL) OR (leisure IS NOT NULL) OR ("natural" IS NOT NULL) OR (wetland IS NOT NULL) OR (leaf_type IS NOT NULL) OR
                (amenity IS NOT NULL) OR (crop IS NOT NULL) OR (orchard IS NOT NULL) ORDER BY (CASE WHEN landuse='forest' THEN 0 ELSE 1 END) asc;
CREATE INDEX landuse_way_idx
    ON landuse
    USING GIST (way);
GRANT SELECT ON landuse TO tirex;

-- view for saddles
 CREATE MATERIALIZED VIEW mv_symbols_saddle AS
SELECT                                                               
    s.way,                           
    s."natural",
    s.direction,
    s.name,
    s.ele,
    s.mountain_pass,
    CASE                     
        WHEN l.osm_id IS NOT NULL THEN true
        ELSE false
    END AS has_way
FROM planet_osm_point AS s
LEFT JOIN planet_osm_line AS l
  ON ST_Intersects(s.way, l.way)
  AND l.highway IN ('motorway','trunk','primary','secondary','tertiary','unclassified','residential')
WHERE
    (
        s."natural" IN ('saddle','col','notch')
        OR s.mountain_pass = 'yes'
    )
    AND s.direction ~ '^[0-9]+$';  

-- GIST-Index auf die Geometrie
CREATE INDEX idx_mv_symbols_saddle_way                               
ON mv_symbols_saddle USING GIST (way);
GRANT SELECT ON mv_symbols_saddle TO tirex;

