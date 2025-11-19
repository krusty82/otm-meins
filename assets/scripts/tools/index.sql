CREATE INDEX IF NOT EXISTS idx_planet_osm_point_osm_id
ON planet_osm_point(osm_id);

-- Name
CREATE INDEX IF NOT EXISTS idx_point_name
ON planet_osm_point(name);

-- Natural
CREATE INDEX IF NOT EXISTS idx_point_natural
ON planet_osm_point("natural");

CREATE INDEX IF NOT EXISTS idx_planet_osm_polygon_osm_id
ON planet_osm_polygon(osm_id);

-- Name
CREATE INDEX IF NOT EXISTS idx_polygon_name
ON planet_osm_polygon(name);

-- Natural
CREATE INDEX IF NOT EXISTS idx_polygon_natural
ON planet_osm_polygon("natural");

-- region:type
CREATE INDEX IF NOT EXISTS idx_planet_region_type
ON planet_osm_polygon("region:type");

CREATE INDEX IF NOT EXISTS idx_planet_osm_line_osm_id
ON planet_osm_line(osm_id);

-- Name
CREATE INDEX IF NOT EXISTS idx_line_name
ON planet_osm_line(name);

-- Natural
CREATE INDEX IF NOT EXISTS idx_line_natural
ON planet_osm_line("natural");

--Ferry
CREATE INDEX planet_osm_line_route_ferry_idx
  ON planet_osm_line (route)
  WHERE route = 'ferry';



