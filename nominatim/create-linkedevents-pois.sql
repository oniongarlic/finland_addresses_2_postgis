CREATE OR REPLACE FUNCTION get_name_by_language_only(name hstore, languagepref TEXT[])
  RETURNS TEXT
  AS $$
DECLARE
  result TEXT;
BEGIN
  IF name is null THEN
    RETURN null;
  END IF;

  FOR j IN 1..array_upper(languagepref,1) LOOP
    IF name ? languagepref[j] THEN
      result := trim(name->languagepref[j]);
      IF result != '' THEN
        return result;
      END IF;
    END IF;
  END LOOP;

  RETURN null;
END;
$$
LANGUAGE plpgsql IMMUTABLE;


create view linkedevents_pois as select a.osm_id,
 get_name_by_language(a.name, ARRAY['name:fi']) as fi,
 get_name_by_language_only(a.name, ARRAY['name:sv']) as sv,
 get_name_by_language_only(a.name, ARRAY['name:en']) as en,
 get_name_by_language(f.name, ARRAY['name:fi']) as street_fi,
 get_name_by_language_only(f.name, ARRAY['name:sv']) as street_sv,
 a.housenumber,
 vs.name as municipality,a.postcode,
 a.extratags->'website' as url,
 a.extratags->'phone' as phone,
 a.extratags->'description' as description,
 a.type, a.class,
 ST_Y(centroid) AS lat, ST_X(centroid) AS lon
 from placex as a,vs
 left join lateral get_addressdata(a.place_id, 0) f on true where
 f.isaddress=true and f.class='highway' and f.type != 'motorway' and f.osm_type='W' and
 a.name is not null and
 a.class in ('amenity','tourism','shop','leisure','place','office','historic') and
 a.type not in ('atm','milestone','motorcycle_parking','bicycle_rental') and
 vs.name in ('Turku', 'Kaarina', 'Aura', 'Lieto', 'Marttila', 'Masku', 'Mynämäki', 'Naantali', 'Nousiainen', 'Paimio',  'Raisio', 'Rusko', 'Sauvo') and
 ST_Within(a.centroid, vs.wkb_geometry);

\copy (select * from linkedevents_pois) to 'poi-dump-le.csv' with csv header
