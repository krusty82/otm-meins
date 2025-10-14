CREATE INDEX IF NOT EXISTS idx_planet_osm_point_osm_id
ON planet_osm_point(osm_id);

-- Name
CREATE INDEX IF NOT EXISTS idx_point_name
ON planet_osm_point(name);

-- Natural
CREATE INDEX IF NOT EXISTS idx_point_natural
ON planet_osm_point("natural");

-- Optional: evtl. Duplikat
CREATE INDEX IF NOT EXISTS idx_point_osm_id
ON planet_osm_point(osm_id);

-- GiST für Geometrie
CREATE INDEX IF NOT EXISTS planet_osm_point_way_idx
ON planet_osm_point USING GIST(way);
