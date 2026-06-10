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
CREATE INDEX IF NOT EXISTS planet_osm_polygon_nat_region_idx
ON planet_osm_polygon ("natural");

-- Glacier
CREATE INDEX IF NOT EXISTS idx_polygon_glacier
ON planet_osm_polygon("natural")
WHERE "natural"='glacier';

-- Peaks
CREATE INDEX IF NOT EXISTS idx_point_peaks
ON planet_osm_point("natural")
WHERE "natural" IN ('peak','volcano');

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


CREATE INDEX IF NOT EXISTS idx_polygon_military
  ON planet_osm_polygon (landuse)  
  WHERE landuse = 'military';


CREATE INDEX IF NOT EXISTS idx_polygon_nature_reserve
  ON planet_osm_polygon (leisure)  
  WHERE leisure = 'nature_reserve';

CREATE INDEX IF NOT EXISTS idx_line_power
  ON planet_osm_line (power);  

CREATE INDEX IF NOT EXISTS idx_point_power
  ON planet_osm_point (power);  
