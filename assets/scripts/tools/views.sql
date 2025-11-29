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
