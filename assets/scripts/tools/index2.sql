-- ==========================================
-- CREATE OPTIMAL INDEXES
-- ==========================================

-- ------------------
-- POINT
-- ------------------
CREATE INDEX planet_osm_point_way_idx
    ON planet_osm_point USING GIST(way);

CREATE INDEX planet_osm_point_peaks_geom_idx
ON planet_osm_point
USING GIST (way)
WHERE "natural" IN ('peak','volcano');

CREATE INDEX planet_osm_point_amenity_idx
    ON planet_osm_point (amenity)
    USING GIST (way)
    WHERE amenity IS NOT NULL;

CREATE INDEX planet_osm_point_tourism_idx
    ON planet_osm_point (tourism)
    USING GIST (way)
    WHERE tourism IS NOT NULL;

CREATE INDEX planet_osm_point_shop_idx
    ON planet_osm_point (shop)
    USING GIST (way)
    WHERE shop IS NOT NULL;

CREATE INDEX planet_osm_point_historic_idx
    ON planet_osm_point (historic)
    USING GIST (way)
    WHERE historic IS NOT NULL;

CREATE INDEX planet_osm_point_route_ferry_idx
    ON planet_osm_point (route)
    WHERE route = 'ferry';

-- ------------------
-- LINE
-- ------------------
CREATE INDEX planet_osm_line_way_idx
    ON planet_osm_line USING GIST(way);

CREATE INDEX planet_osm_line_highway_idx
    ON planet_osm_line (highway)
    WHERE highway IS NOT NULL;

CREATE INDEX planet_osm_line_waterway_idx
    ON planet_osm_line (waterway)
    WHERE waterway IS NOT NULL;

CREATE INDEX planet_osm_line_railway_idx
    ON planet_osm_line (railway)
    WHERE railway IS NOT NULL;

CREATE INDEX planet_osm_line_aerialway_idx
    ON planet_osm_line (aerialway)
    WHERE aerialway IS NOT NULL;

CREATE INDEX planet_osm_line_route_ferry_idx
    ON planet_osm_line (route)
    WHERE route = 'ferry';

-- ------------------
-- POLYGON
-- ------------------
CREATE INDEX planet_osm_polygon_way_idx
    ON planet_osm_polygon USING GIST(way);

CREATE INDEX planet_osm_polygon_water_idx
    ON planet_osm_polygon (water)
    WHERE water IS NOT NULL;

CREATE INDEX planet_osm_polygon_natural_idx
    ON planet_osm_polygon ("natural")
    WHERE "natural" IS NOT NULL;

CREATE INDEX planet_osm_polygon_landuse_idx
    ON planet_osm_polygon (landuse)
    WHERE landuse IS NOT NULL;

CREATE INDEX planet_osm_polygon_building_idx
    ON planet_osm_polygon (building)
    WHERE building IS NOT NULL;

CREATE INDEX planet_osm_polygon_place_idx
    ON planet_osm_polygon (place)
    WHERE place IS NOT NULL;

-- ==========================================
-- ANALYZE TABLES
-- ==========================================
ANALYZE planet_osm_point;
ANALYZE planet_osm_line;
ANALYZE planet_osm_polygon;

