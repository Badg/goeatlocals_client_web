createuser osm;
createdb -E UTF8 -O osm gis;
psql -c "CREATE EXTENSION postgis;" -d gis;
psql -c "CREATE EXTENSION hstore;" -d gis;
psql -c "ALTER TABLE spatial_ref_sys OWNER TO osm;" -d gis;
