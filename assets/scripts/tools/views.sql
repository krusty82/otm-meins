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

-- Optional sinnvoll: Name-Index (falls Filter darauf)
CREATE INDEX ferry_routes_lowzoom_name_idx
    ON ferry_routes_lowzoom (name);

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
