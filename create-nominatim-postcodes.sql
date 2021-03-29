--
-- Create table with postcode center, radius and the concave area of the postal code points
--

CREATE TABLE fi_postcode_areas AS SELECT ST_ConcaveHull(ST_Collect(wkb_geometry), 0.99) AS area,
 ST_Centroid(ST_Collect(ST_Points(wkb_geometry))) as center,
 (ST_MinimumBoundingRadius(ST_Collect(wkb_geometry))).radius as radius, postal_code, region, municipality
 FROM finland_addresses WHERE street is not null
 GROUP by postal_code,region,municipality;

--
-- Remove 00000 code
--

DELETE FROM fi_postcode_areas WHERE postal_code='00000';
