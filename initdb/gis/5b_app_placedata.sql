-- the places table has JUST the place and its identity and locator info
CREATE TABLE IF NOT EXISTS app_placedata.places(
    place_id                        uuid
        PRIMARY KEY
        NOT NULL
        DEFAULT gen_random_uuid(),

    identity_name                   text
        NOT NULL,
    identity_display_class          app_placedata.display_class,
    identity_tagline                text,

    status                          app_placedata.business_status,
    status_last_updated             timestamp with time zone,
    status_last_verified            timestamp with time zone,

    -- TODO: constrain this to just being a point, one way or another
    locator_point                   geometry,
    locator_address                 app_placedata.address,
    locator_website                 text,
    locator_phone                   text);


CREATE TABLE IF NOT EXISTS app_placedata.attrs_temporal(
    place_id                        uuid
        NOT NULL
        REFERENCES app_placedata.places(place_id)
        ON DELETE CASCADE,
    sales_class                     app_placedata.sales_class
        NOT NULL,

    nominal_hours                   app_placedata.attr_temporal,

    PRIMARY KEY(place_id, sales_class));


CREATE TABLE IF NOT EXISTS app_placedata.attrs_physical(
    place_id                        uuid
        NOT NULL
        REFERENCES app_placedata.places(place_id)
        ON DELETE CASCADE,
    sales_class                     app_placedata.sales_class
        NOT NULL,

    capacity_inside                 app_placedata.attr_rating,
    capactiy_outside                app_placedata.attr_rating,

    PRIMARY KEY(place_id, sales_class));


CREATE TABLE IF NOT EXISTS app_placedata.attrs_inventory(
    place_id                        uuid
        NOT NULL
        REFERENCES app_placedata.places(place_id)
        ON DELETE CASCADE,
    sales_class                     app_placedata.sales_class
        NOT NULL,

    alcohol_light                   app_placedata.attr_rating,
    alcohol_heavy                   app_placedata.attr_rating,
    food_prepared                   app_placedata.attr_rating,
    food_grocery                    app_placedata.attr_rating,

    PRIMARY KEY(place_id, sales_class));


CREATE TABLE IF NOT EXISTS app_placedata.attrs_houserules(
    place_id                        uuid
        NOT NULL
        REFERENCES app_placedata.places(place_id)
        ON DELETE CASCADE,
    sales_class                     app_placedata.sales_class
        NOT NULL,

    -- TODO: which currencies?
    payment_accepts_cards           app_placedata.attr_bool,
    payment_accepts_cash            app_placedata.attr_bool,

    PRIMARY KEY(place_id, sales_class));
