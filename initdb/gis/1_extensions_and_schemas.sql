CREATE EXTENSION postgis;
CREATE EXTENSION hstore;
CREATE EXTENSION unaccent;
CREATE EXTENSION pgcrypto;
ALTER TABLE spatial_ref_sys OWNER TO osm_admin;

CREATE SCHEMA IF NOT EXISTS app_auth;
CREATE SCHEMA IF NOT EXISTS app_userdata;
CREATE SCHEMA IF NOT EXISTS app_placedata;

CREATE SCHEMA IF NOT EXISTS mapdata_staging;
CREATE SCHEMA IF NOT EXISTS mapdata_prod;
CREATE SCHEMA IF NOT EXISTS mapdata_backup;
CREATE SCHEMA IF NOT EXISTS mapdata_utils;
CREATE SCHEMA IF NOT EXISTS mapdata_layers;
