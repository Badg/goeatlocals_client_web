CREATE TYPE mapdata_utils.route_network_type AS ENUM (
    'us-interstate', 'us-highway', 'us-state',
    'ca-transcanada',
    'gb-motorway', 'gb-trunk'
);

CREATE TYPE mapdata_utils.public_transport_stop_type AS ENUM (
    'subway', 'tram_stop', 'bus_station', 'bus_stop'
);

CREATE TYPE mapdata_utils.city_place AS ENUM (
            'city', 'town', 'village', 'hamlet', 'suburb', 'neighbourhood',
            'isolated_dwelling');
