CREATE ROLE osm_admin;
CREATE ROLE osm_import;
CREATE ROLE osm_read;
CREATE DATABASE gis WITH
    ENCODING = UTF8
    OWNER = osm_admin;

ALTER DATABASE gis SET search_path TO "$user",public,mapdata_layers,mapdata_utils;
