--
-- Create a dump of interesting locations/POIs suitable for import to 
-- for example LinkedEvents
--

select a.place_id,
 get_name_by_language(a.name, ARRAY['name:fi']) as fi,
 get_name_by_language(a.name, ARRAY['name:sv']) as sv,
 get_name_by_language(a.name, ARRAY['name:en']) as en,
 get_name_by_language(f.name, ARRAY['name:fi']) as street_fi,
 get_name_by_language(f.name, ARRAY['name:sv']) as street_sv,
 a.housenumber,
 a.postcode,
 a.extratags->'website' as url,
 a.extratags->'phone' as phone,
 a.type, a.class, 
 ST_Y(centroid) AS lat, ST_X(centroid) AS lon
 from placex as a
 left join lateral get_addressdata(a.place_id, 0) f on true where
 f.isaddress=true and f.class='highway' and 
 f.osm_type='W' and
 a.postcode='20500' and
 a.name is not null and
 a.class in ('amenity','tourism','shop','leisure') order by importance;

select a.place_id,
 get_name_by_language(a.name, ARRAY['name:fi']) as fi,
 get_name_by_language(a.name, ARRAY['name:sv']) as sv,
 get_name_by_language(a.name, ARRAY['name:en']) as en,
 get_name_by_language(f.name, ARRAY['name:fi']) as street_fi,
 get_name_by_language(f.name, ARRAY['name:sv']) as street_sv,
 a.housenumber,
 a.postcode,
 a.extratags->'website' as url,
 a.extratags->'phone' as phone,
 a.extratags->'description' as description, 
 a.type, a.class, 
 ST_Y(centroid) AS lat, ST_X(centroid) AS lon
 from placex as a,vs 
 left join lateral get_addressdata(a.place_id, 0) f on true where
 f.isaddress=true and f.class='highway' and 
 f.osm_type='W' and
 a.name is not null and
 a.class in ('amenity','tourism','shop','leisure','place') and ST_Within(a.centroid, vs.wkb_geometry);

select a.place_id,
 get_name_by_language(a.name, ARRAY['name:fi']) as fi,
 get_name_by_language(a.name, ARRAY['name:sv']) as sv,
 get_name_by_language(a.name, ARRAY['name:en']) as en,
 get_name_by_language(f.name, ARRAY['name:fi']) as street_fi,
 get_name_by_language(f.name, ARRAY['name:sv']) as street_sv,
 a.housenumber,
 vs.name as municipality,a.postcode,
 a.extratags->'website' as url,
 a.extratags->'phone' as phone,
 a.extratags->'description' as description, 
 a.type, a.class, 
 ST_Y(centroid) AS lat, ST_X(centroid) AS lon
 from placex as a,vs 
 left join lateral get_addressdata(a.place_id, 0) f on true where
 f.isaddress=true and f.class='highway' and 
 f.osm_type='W' and
 a.name is not null and
 a.class in ('amenity','tourism','shop','leisure','place','office','historic') and ST_Within(a.centroid, vs.wkb_geometry);



\copy (select * from vs_pos) to 'poi-dump-vs.csv' with csv header
