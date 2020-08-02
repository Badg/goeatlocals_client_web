CREATE TYPE app_placedata.display_class AS ENUM (
    'grocery',
    'prepared_food',
    'full_bar',
    'light_bar');


CREATE TYPE app_placedata.business_status AS ENUM (
    'open',
    'closed_temp',
    'closed_permanent');


CREATE TYPE app_placedata.sales_class AS ENUM (
    'unspecified',
    'on_prem',
    'takeout',
    'delivery');


CREATE TYPE app_placedata.address AS (
    -- Street numbers aren't always actually numbers. Even just in Oakland I've
    -- seen some x-1/2 addresses. Plus A/B, etc. So best to just keep this text
    -- and let processing code error out instead of the database
    street_number                   text,
    street_name                     text,
    unit_number                     text,
    neighborhood                    text,
    city                            text,
    state                           text,
    country                         text,
    postal_code                     text);


CREATE DOMAIN app_placedata.op_hour
    AS int
    CHECK (VALUE IS NOT NULL AND VALUE BETWEEN 0 AND 23);
CREATE DOMAIN app_placedata.op_minute
    AS int
    CHECK (VALUE IS NOT NULL AND VALUE BETWEEN 0 AND 59);


CREATE TYPE app_placedata.unvalidated_op_time AS (
    op_hour                         app_placedata.op_hour,
    op_minute                       app_placedata.op_minute);
CREATE DOMAIN app_placedata.op_time
    AS app_placedata.unvalidated_op_time
    CHECK ((VALUE).op_hour IS NOT NULL AND (VALUE).op_minute IS NOT NULL);


CREATE TYPE app_placedata.unvalidated_op_range AS (
    is_open                         bool,
    opening                         app_placedata.op_time,
    closing                         app_placedata.op_time);
CREATE DOMAIN app_placedata.op_range
    AS app_placedata.unvalidated_op_range
    CHECK (
        ((VALUE).is_open = TRUE AND
            (VALUE).opening IS NOT NULL AND (VALUE).closing IS NOT NULL)
        OR
        ((VALUE).is_open = FALSE AND
            (VALUE).opening IS NULL AND (VALUE).closing IS NULL));


-- Note that any of these can be completely null, which means we don't know the
-- nominal hours for that day.
CREATE TYPE app_placedata.nominal_hours AS (
    monday                          app_placedata.op_range,
    tuesday                         app_placedata.op_range,
    wednesday                       app_placedata.op_range,
    thursday                        app_placedata.op_range,
    friday                          app_placedata.op_range,
    saturday                        app_placedata.op_range,
    sunday                          app_placedata.op_range);


CREATE TYPE app_placedata.unvalidated_attr_temporal AS (
    is_applicable                   bool,
    nominal_hours                   app_placedata.nominal_hours,
    last_updated                    timestamp with time zone);
CREATE DOMAIN app_placedata.attr_temporal
    AS app_placedata.unvalidated_attr_temporal
    CHECK ((VALUE).last_updated IS NOT NULL AND (
        ((VALUE).is_applicable = TRUE AND (VALUE).nominal_hours IS NOT NULL)
        OR
        ((VALUE).is_applicable = FALSE AND (VALUE).nominal_hours IS NULL)));


CREATE TYPE app_placedata.unvalidated_attr_rating AS (
    is_applicable                   bool,
    rating                          float,
    last_updated                    timestamp with time zone,
    nominal_hours_restriction       app_placedata.nominal_hours);
CREATE DOMAIN app_placedata.attr_rating
    AS app_placedata.unvalidated_attr_rating
    CHECK ((VALUE).last_updated IS NOT NULL AND (
        ((VALUE).is_applicable = TRUE AND (VALUE).rating IS NOT NULL)
        OR
        ((VALUE).is_applicable = FALSE AND (VALUE).rating IS NULL)));
CREATE DOMAIN app_placedata.attr_bool
    AS app_placedata.unvalidated_attr_rating
    CHECK (
        (VALUE).last_updated IS NOT NULL
        AND (VALUE).is_applicable IS NOT NULL
        AND (VALUE).rating IS NULL);
