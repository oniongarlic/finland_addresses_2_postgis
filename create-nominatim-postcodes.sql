--
-- Create table with postcode center, radius and the concave area of the postal code points
-- We skip importing of special postal codes (PO boxes, etc) and locations with no street name.
--

CREATE TABLE fi_postcode_areas AS SELECT ST_ConcaveHull(ST_Collect(wkb_geometry), 0.99) AS area,
 ST_Centroid(ST_Collect(ST_Points(wkb_geometry))) as center,
 (ST_MinimumBoundingRadius(ST_Collect(wkb_geometry))).radius as radius, postal_code, region, municipality
 FROM finland_addresses WHERE street != '' AND postal_code not in ('00000','00002','00099')
 GROUP by postal_code,region,municipality;

