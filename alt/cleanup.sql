--
-- Check against municipality borders in fik table
--
CREATE TABLE fi_postcode_areas AS SELECT ST_ConcaveHull(ST_Collect(fa.wkb_geometry), 0.99) AS area,
 ST_Centroid(ST_Collect(ST_Points(fa.wkb_geometry))) as center,
 (ST_MinimumBoundingRadius(ST_Collect(fa.wkb_geometry))).radius as radius, postal_code, region, municipality
 FROM finland_addresses fa,fik WHERE
 fa.municipality=fik.code::int AND
 street != '' AND
 house_number!='' AND
 postal_code not in ('00000','00002','00099') AND
 ST_Contains(fik.wkb_geometry, fa.wkb_geometry)
 GROUP by postal_code,region,municipality;

